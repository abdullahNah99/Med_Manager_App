import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/authentication/data/models/secretary_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

abstract class LoginStates {}

final class LoginInitial extends LoginStates {}

final class LoginLoading extends LoginStates {}

final class LoginChangeSuffixIcon extends LoginStates {}

final class LoginSuccess extends LoginStates {
  final PatientModel? patientModel;
  final SecretaryModel? secretaryModel;
  final DoctorModel? doctorModel;

  LoginSuccess({
    this.patientModel,
    this.secretaryModel,
    this.doctorModel,
  });

  void navigateToHome(BuildContext context) {
    if (patientModel != null) {
      GoRouter.of(context).pushReplacement(
        AppRouter.kPatientHomeView,
        extra: patientModel,
      );
    } else if (secretaryModel != null) {
      GoRouter.of(context).pushReplacement(
        AppRouter.kHomeSecretaryView,
        extra: secretaryModel,
      );
    } else if (doctorModel != null) {
      GoRouter.of(context).pushReplacement(
        AppRouter.kDoctorView,
        extra: doctorModel,
      );
    }
  }
}

final class LoginFailure extends LoginStates {
  final String failureMsg;

  LoginFailure({required this.failureMsg});
}
