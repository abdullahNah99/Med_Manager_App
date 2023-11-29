import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_constants.dart';
import 'package:med_manager_app/core/utils/cache_helper.dart';
import 'package:med_manager_app/core/utils/date_helper.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/authentication/data/repos/authentication_repo_impl.dart';
import 'package:med_manager_app/features/doctor_features/features/home_doctor/data/repos/home_doctor_repo.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_states.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/models/consultation_model.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/repos/my_consultations_repo_impl.dart';

class DoctorCubit extends Cubit<DoctorStates> {
  final HomeDoctorRepo homeDoctorRepo;
  late final List<PatientModel> patients;
  late final List<ConsultationModel> consultations;
  List<AppointmentModel> approvedAppointments = [];
  List<String> approvedAppointmentsDates = [];
  int bottomNavigationBarindex = 1;
  bool pageControllerAnimate = true;
  bool listener = false;
  final PageController pageController = PageController(
    initialPage: 1,
  );

  int selectedDateIndex = 0;
  int previousDateIndex = 0;
  DoctorCubit({required this.homeDoctorRepo}) : super(DoctorInitial());

  Future<void> logout() async {
    emit(DoctorLoading());
    (await getIt.get<AuthenticationRepoImpl>().logout(
              token: await CacheHelper.getData(key: 'Token'),
            ))
        .fold(
      (failure) {
        emit(DoctorFailure(failureMsg: failure.errorMessege));
      },
      (success) async {
        await CacheHelper.deletData(key: 'Token');
        await CacheHelper.deletData(key: 'Role');
        await CacheHelper.deletData(key: 'UserID');
        pageController.dispose();
        emit(LogOutSuccess());
      },
    );
  }

  Future<void> indexDoctorPatients() async {
    (await homeDoctorRepo.indexDoctorPatients(
      token: await CacheHelper.getData(key: 'Token'),
    ))
        .fold(
      (failure) {
        emit(DoctorFailure(failureMsg: failure.errorMessege));
      },
      (patients) {
        this.patients = patients;
        emit(GetPatientsSuccess());
      },
    );
  }

  Future<void> indexDoctorConsultations() async {
    (await getIt.get<MyConsultationsRepoImpl>().getMyConsultation(
              token: await CacheHelper.getData(key: 'Token'),
            ))
        .fold(
      (failure) {
        emit(DoctorFailure(failureMsg: failure.errorMessege));
      },
      (consultations) {
        this.consultations = consultations;
        emit(GetConsultationsSuccess());
      },
    );
  }

  Future<void> indexApprovedAppointmentsByDate(
      {required int doctorID, required String date}) async {
    (await homeDoctorRepo.indexApprovedAppointmentsByDate(
      secretaryToken: AppConstants.secretaryTokenOfDepartment1,
      doctorID: doctorID,
      date: date,
      // date: 'Sunday Oct 01'
    ))
        .fold(
      (failure) {
        emit(DoctorFailure(failureMsg: failure.errorMessege));
      },
      (approvedAppointments) {
        this.approvedAppointments = approvedAppointments;
        emit(GetApprovedAppointmentsSuccess());
      },
    );
  }

  Future<void> indexApprovedAppointmentsDates({required int doctorID}) async {
    (await homeDoctorRepo.indexApprovedAppointmentsDates(
      secretaryToken: AppConstants.secretaryTokenOfDepartment1,
      doctorID: doctorID,
    ))
        .fold(
      (failure) {
        emit(DoctorFailure(failureMsg: failure.errorMessege));
      },
      (dates) {
        approvedAppointmentsDates = dates;
        emit(GetApprovedAppointmentsDatesSuccess());
      },
    );
  }

  Future<void> firstOpen({required DoctorModel doctorModel}) async {
    emit(DoctorLoading());
    indexApprovedAppointmentsDates(doctorID: doctorModel.id).then(
      (value) async => await indexApprovedAppointmentsByDate(
        doctorID: doctorModel.id,
        date: DateHelper.getCurrentDate(),
      ).then(
        (value) async => await indexDoctorConsultations().then(
          (value) async => await indexDoctorPatients(),
        ),
      ),
    );
  }

  void bottomNavigationBarOnTab(int index) {
    pageControllerAnimate = false;
    bottomNavigationBarindex = index;
    emit(BottomNavigationBarState());
    pageController
        .animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    )
        .then(
      (value) {
        pageControllerAnimate = true;
      },
    );
  }

  void onPageChanged(int index) {
    if (pageControllerAnimate) {
      log('called');
      bottomNavigationBarindex = index;
      emit(BottomNavigationBarState());
    }
  }

  void selectDate({
    required int index,
    required int doctorID,
  }) async {
    if (selectedDateIndex != index) {
      previousDateIndex = selectedDateIndex;
      selectedDateIndex = index;
      await indexApprovedAppointmentsByDate(
        doctorID: doctorID,
        date: approvedAppointmentsDates[index],
      );
      emit(SelectDateState());
    }
  }
}
