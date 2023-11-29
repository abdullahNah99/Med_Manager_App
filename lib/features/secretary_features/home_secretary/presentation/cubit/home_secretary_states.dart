abstract class HomeSecretaryStates {}

final class HomeSecretaryInitial extends HomeSecretaryStates {}

final class HomeSecretaryLoading extends HomeSecretaryStates {}

final class GetWaintingAppointnmentsDatesSuccess extends HomeSecretaryStates {}

final class GetWaintingAppointnmentsSuccess extends HomeSecretaryStates {}

final class HomeSecretaryFailure extends HomeSecretaryStates {
  final String failureMsg;

  HomeSecretaryFailure({required this.failureMsg});
}

final class LogOutSuccess extends HomeSecretaryStates {}

final class SelectDateState extends HomeSecretaryStates {}

final class GetDoctorsWorkDays extends HomeSecretaryStates {}

final class IndexDepartmentAppointments extends HomeSecretaryStates {}
