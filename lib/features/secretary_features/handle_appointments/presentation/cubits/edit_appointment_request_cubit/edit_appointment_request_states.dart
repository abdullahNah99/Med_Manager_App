abstract class EditAppointmentRequestStates {}

final class EditAppointmentRequestInitial
    extends EditAppointmentRequestStates {}

final class EditAppointmentRequestLoading
    extends EditAppointmentRequestStates {}

final class EditAppointmentRequestFailure extends EditAppointmentRequestStates {
  final String failureMsg;

  EditAppointmentRequestFailure({required this.failureMsg});
}
