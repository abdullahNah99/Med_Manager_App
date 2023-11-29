import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';

abstract class HomePatientStates {}

final class HomePatientInitial extends HomePatientStates {}

final class HomePatientLoading extends HomePatientStates {}

final class BalanceLoadingState extends HomePatientStates {}

final class LogOutSuccess extends HomePatientStates {}

final class SelectDepartmentState extends HomePatientStates {}

final class HomePatientFailure extends HomePatientStates {
  final String failureMsg;

  HomePatientFailure({required this.failureMsg});
}

final class GetDepartmentsSuccess extends HomePatientStates {}

final class GetDoctorsSuccess extends HomePatientStates {}

final class ChangeFavoriteState extends HomePatientStates {
  final String message;
  final int index;

  ChangeFavoriteState({
    required this.message,
    required this.index,
  });
}

final class GetPatientDataSuccess extends HomePatientStates {
  final PatientModel patientModel;

  GetPatientDataSuccess({required this.patientModel});
}
