import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:med_manager_app/core/utils/app_constants.dart';
import 'package:med_manager_app/core/utils/cache_helper.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/authentication/data/models/secretary_model.dart';
import 'package:med_manager_app/features/authentication/data/repos/authentication_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/models/work_day_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/models/handle_appointment_navigator_model.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/data/models/waiting_appointment_model.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/data/repos/home_secretary_repo.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_states.dart';

class HomeSecretaryCubit extends Cubit<HomeSecretaryStates> {
  final HomeSecretaryRepo homeSecretaryRepo;
  bool listener = false;
  List<String> waitingAppointmentsDates = [];
  List<WaitingAppointmentModel> waitingAppointments = [];
  List<AppointmentModel> approvedAppointments = [];
  List<WorkDayModel> workDays = [];
  int selectedDateIndex = 0;
  int previousDateIndex = 0;
  final List<Widget> tabs = List.generate(
    3,
    (index) {
      return Tab(
        text: index == 0
            ? 'Home'
            : index == 1
                ? 'Doctors'
                : 'Patients',
        icon: Icon(
          index == 0
              ? Icons.home
              : index == 1
                  ? FontAwesomeIcons.stethoscope
                  : Icons.person,
          size: SizeConfig.defaultSize * 3.3,
        ),
      );
    },
  );

  HomeSecretaryCubit({required this.homeSecretaryRepo})
      : super(HomeSecretaryInitial());

  Future<void> logout() async {
    emit(HomeSecretaryLoading());
    (await getIt.get<AuthenticationRepoImpl>().logout(
              token: await CacheHelper.getData(key: 'Token'),
            ))
        .fold(
      (failure) {
        emit(HomeSecretaryFailure(failureMsg: failure.errorMessege));
      },
      (success) async {
        await CacheHelper.deletData(key: 'Token');
        await CacheHelper.deletData(key: 'Role');
        await CacheHelper.deletData(key: 'UserID');
        emit(LogOutSuccess());
      },
    );
  }

  Future<void> getWaitingAppointmentsDates() async {
    (await homeSecretaryRepo.getWaitingAppointmentsDates(
      token: await CacheHelper.getData(key: 'Token'),
    ))
        .fold(
      (failure) {
        emit(HomeSecretaryFailure(failureMsg: failure.errorMessege));
      },
      (dates) {
        waitingAppointmentsDates = dates;
        emit(GetWaintingAppointnmentsDatesSuccess());
      },
    );
  }

  void selectDate({required int index}) async {
    if (selectedDateIndex != index) {
      previousDateIndex = selectedDateIndex;
      selectedDateIndex = index;
      await indexWaintingAppointmentsByDate();
      emit(SelectDateState());
    }
  }

  List<String> getDayAndDate({required int index}) {
    String date = sortedDates()[index];
    return date.split(' ');
  }

  Future<void> indexWaintingAppointmentsByDate({bool? emitLoading}) async {
    if (waitingAppointmentsDates.isNotEmpty) {
      if (emitLoading ?? true) {
        emit(HomeSecretaryLoading());
      }
      (await homeSecretaryRepo.indexWaintingAppointmentsByDate(
        token: await CacheHelper.getData(key: 'Token'),
        date: waitingAppointmentsDates[selectedDateIndex],
      ))
          .fold(
        (failure) {
          emit(HomeSecretaryFailure(failureMsg: failure.errorMessege));
        },
        (waitingAppointments) {
          this.waitingAppointments = waitingAppointments;
          emit(GetWaintingAppointnmentsSuccess());
        },
      );
    }
  }

  Future<void> getDepartmentDoctorsWorkDays({required int departmentID}) async {
    (await homeSecretaryRepo.getDepartmentDoctorsWorkDays(
      adminToken: AppConstants.adminToken,
      departmentID: departmentID,
    ))
        .fold(
      (failure) {
        emit(HomeSecretaryFailure(failureMsg: failure.errorMessege));
      },
      (workDays) {
        this.workDays = workDays;
        emit(GetDoctorsWorkDays());
      },
    );
  }

  Future<void> firstOpen({required SecretaryModel secretaryModel}) async {
    emit(HomeSecretaryLoading());
    await getWaitingAppointmentsDates().then(
      (value) async =>
          await indexWaintingAppointmentsByDate(emitLoading: false).then(
        (value) async => await getDepartmentDoctorsWorkDays(
          departmentID: secretaryModel.departmentID,
        ).then(
          (value) async => await indexDepartmentAppointments(
            departmentID: secretaryModel.departmentID,
          ),
        ),
      ),
    );
  }

  Future<void> indexDepartmentAppointments({
    required int departmentID,
  }) async {
    (await homeSecretaryRepo.indexDepartmentAppointments(
      token: await CacheHelper.getData(key: 'Token'),
      departmentID: departmentID,
    ))
        .fold(
      (failure) {
        emit(HomeSecretaryFailure(failureMsg: failure.errorMessege));
      },
      (appointments) {
        approvedAppointments.clear();
        for (AppointmentModel item in appointments) {
          if (item.status == 'approve') {
            approvedAppointments.add(item);
          }
        }
        emit(IndexDepartmentAppointments());
      },
    );
  }

  bool checkDateEqual({
    required String ymd,
    required String dmmmNum,
  }) {
    Jiffy jiffy = Jiffy.parse(ymd);
    if ('${jiffy.EEEE} ${jiffy.MMMd}' == dmmmNum) {
      return true;
    }
    return false;
  }

  List<AppointmentModel> getDoctorBookedAppointments({
    required int doctorID,
    required String date,
  }) {
    List<AppointmentModel> booked = [];
    for (AppointmentModel item in approvedAppointments) {
      if (item.doctorID == doctorID) {
        if (checkDateEqual(ymd: item.date, dmmmNum: date)) {
          booked.add(item);
        }
      }
    }
    return booked;
  }

  int compareTwoDates({
    required String date1,
    required String date2,
  }) {
    List<String> d1 = date1.split(' ');
    List<String> d2 = date2.split(' ');
    Jiffy jiffy1 = Jiffy.parse('${d1[1]} ${d1[2]}', pattern: "MMM dd");
    Jiffy jiffy2 = Jiffy.parse('${d2[1]} ${d2[2]}', pattern: "MMM dd");
    bool isSame = jiffy1.isSame(jiffy2);
    bool isBefore = jiffy1.isBefore(jiffy2);
    if (isSame) {
      return 0;
    } else if (isBefore) {
      return -1;
    } else {
      return 1;
    }
  }

  List<String> sortedDates() {
    List<String> sorted = [];
    for (String item in waitingAppointmentsDates) {
      sorted.add(item);
    }
    sorted.sort(
      (a, b) {
        return compareTwoDates(date1: a, date2: b);
      },
    );
    return sorted;
  }

  HandleAppointmentNavigatorModel getNavigatorModel({
    required WaitingAppointmentModel waitingAppointmentModel,
    required SecretaryModel secretaryModel,
  }) {
    return HandleAppointmentNavigatorModel(
      waitingAppointmentModel: waitingAppointmentModel,
      doctorWorkDays: workDays,
      secretaryModel: secretaryModel,
      approvedAppointments: getDoctorBookedAppointments(
        doctorID: waitingAppointmentModel.doctorID,
        date: waitingAppointmentModel.date,
      ),
    );
  }
}
