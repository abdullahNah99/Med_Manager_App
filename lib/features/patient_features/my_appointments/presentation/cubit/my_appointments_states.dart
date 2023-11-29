abstract class MyAppointmentsStates {}

final class MyAppointmentsInitial extends MyAppointmentsStates {}

final class MyAppointmentsLoading extends MyAppointmentsStates {}

final class MyAppointmentsSuccess extends MyAppointmentsStates {}

final class MyAppointmentsFailure extends MyAppointmentsStates {
  final String failureMsg;

  MyAppointmentsFailure({required this.failureMsg});
}

final class DeleteAppointmentSuccess extends MyAppointmentsStates {
  final String message;

  DeleteAppointmentSuccess({required this.message});
}

final class UpdateColorState extends MyAppointmentsStates {}
