import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:med_manager_app/core/utils/app_constants.dart';
import 'package:med_manager_app/core/utils/cache_helper.dart';
import 'package:med_manager_app/core/utils/date_helper.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/authentication/data/repos/authentication_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/models/add_appointment_model.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/models/work_day_model.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/repos/add_appointment_repo.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_state.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class AddAppointmentCubit extends Cubit<AddAppointmentStates> {
  final AddAppointmentRepo addAppointmentRepo;
  bool listener = false;
  PatientModel? patientModel;
  late AddAppointmentModel addAppointmentModel;
  late String description;
  final formKey = GlobalKey<FormState>();
  int selectedDateIndex = 0;
  int previousDateIndex = 0;
  int? selectedTimeIndex;
  int? previousTimeIndex;
  List<Jiffy> dates = [];
  Map<String, WorkDayModel> workDays = {};
  List<String> timesBetween = [];
  AddAppointmentCubit({required this.addAppointmentRepo})
      : super(AddAppointmentInitial());

  void selectDate({required int index}) {
    if (selectedDateIndex != index) {
      previousDateIndex = selectedDateIndex;
      selectedDateIndex = index;
      getTimesBetween();
      emit(SelectDateState());
    }
  }

  void selectTime({required int index}) {
    if (selectedTimeIndex != index) {
      previousTimeIndex = selectedTimeIndex;
      selectedTimeIndex = index;
      emit(SelectTimeState());
    }
  }

  void generateDates() {
    Jiffy jiffy = Jiffy.now();
    for (int i = 1; i < 60; i++) {
      if (workDays.containsKey(jiffy.EEEE)) {
        dates.add(jiffy);
      }
      jiffy = jiffy.add(days: 1);
    }
  }

  Future<void> indexDoctorWorkDays({required int doctorID}) async {
    emit(AddAppointmentLoading());
    (await addAppointmentRepo.indexDoctorWorkDays(
      adminToken: AppConstants.adminToken,
      doctorID: doctorID,
    ))
        .fold(
      (failure) {
        emit(AddAppointmentFailure(failureMsg: failure.errorMessege));
      },
      (workDays) {
        for (WorkDayModel item in workDays) {
          this.workDays[item.day] = item;
        }
        emit(GetDoctorWorkDaysSuccess());
      },
    );
  }

  // int getHour24({required String time}) {
  //   String helper = time.substring(time.length - 2, time.length);
  //   int hour = int.parse(time.substring(0, 2));
  //   if (hour == 12 && helper == 'AM') {
  //     return 0;
  //   } else {
  //     if (helper == 'PM' && hour != 12) {
  //       return (hour + 12);
  //     }
  //     return hour;
  //   }
  // }

  void getTimesBetween() {
    timesBetween.clear();
    WorkDayModel? workDayModel = workDays[dates[selectedDateIndex].EEEE];
    int h1 = DateHelper.getHour24(time: workDayModel!.statrtTime);
    int h2 = DateHelper.getHour24(time: workDayModel.endTime);
    DateTime startTime = DateTime(2023, 1, 1, h1);
    DateTime endTime = DateTime(2023, 1, 1, h2);
    int difference = startTime.difference(endTime).inHours.abs();
    for (int i = 0; i < difference * 2 + 1; i++) {
      timesBetween.add(getStringTime(dateTime: startTime));
      startTime = startTime.add(
        const Duration(minutes: 30),
      );
    }
  }

  String getStringTime({required DateTime dateTime}) {
    Jiffy jiffy = Jiffy.parseFromDateTime(dateTime);
    return jiffy.jm;
  }

  Future<void> firstOpen({required int doctorID}) async {
    await indexDoctorWorkDays(doctorID: doctorID).then(
      (value) async {
        generateDates();
        getTimesBetween();
        emit(SelectDateState());
        await getPatientBalance();
      },
    );
  }

  Future<void> addAppointment({required DoctorModel doctorModel}) async {
    emit(AddAppointmentLoading());
    addAppointmentModel = AddAppointmentModel(
      date: '${dates[selectedDateIndex].EEEE} ${dates[selectedDateIndex].MMMd}',
      time: timesBetween[selectedTimeIndex!],
      description: description,
      departmentID: doctorModel.departmentID,
      doctorID: doctorModel.id,
    );
    (await addAppointmentRepo.addAppointment(
      token: await CacheHelper.getData(key: 'Token'),
      addAppointmentModel: addAppointmentModel,
    ))
        .fold(
      (failure) {
        emit(AddAppointmentFailure(failureMsg: failure.errorMessege));
      },
      (message) {
        emit(AddAppointmentSuccess(message: message));
      },
    );
  }

  Future<void> getPatientBalance() async {
    (await getIt.get<AuthenticationRepoImpl>().getPatientData(
              adminToken: AppConstants.adminToken,
              userID: await CacheHelper.getData(key: 'UserID'),
            ))
        .fold(
      (failure) {
        emit(AddAppointmentFailure(failureMsg: failure.errorMessege));
      },
      (patientModel) {
        this.patientModel = patientModel;
      },
    );
  }
}
