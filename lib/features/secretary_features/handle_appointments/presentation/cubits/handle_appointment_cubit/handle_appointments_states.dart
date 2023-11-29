abstract class HandleAppointmentsStates {}

final class HandleAppointmentsInitial extends HandleAppointmentsStates {}

final class HandleAppointmentsLoading extends HandleAppointmentsStates {}

final class HandleAppointmentsFailure extends HandleAppointmentsStates {
  final String failureMsg;

  HandleAppointmentsFailure({required this.failureMsg});
}

final class GetBookedAppointmentsSuccess extends HandleAppointmentsStates {}

final class ApproveAppointmentSuccess extends HandleAppointmentsStates {}

final class CancelAppointmentSuccess extends HandleAppointmentsStates {}
