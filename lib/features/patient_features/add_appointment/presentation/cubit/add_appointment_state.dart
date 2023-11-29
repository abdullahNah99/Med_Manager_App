abstract class AddAppointmentStates {}

final class AddAppointmentInitial extends AddAppointmentStates {}

final class AddAppointmentLoading extends AddAppointmentStates {}

final class AddAppointmentFailure extends AddAppointmentStates {
  final String failureMsg;

  AddAppointmentFailure({required this.failureMsg});
}

final class AddAppointmentSuccess extends AddAppointmentStates {
  final String message;

  AddAppointmentSuccess({required this.message});
}

final class SelectDateState extends AddAppointmentStates {}

final class SelectTimeState extends AddAppointmentStates {}

final class GetDoctorWorkDaysSuccess extends AddAppointmentStates {
  // final List<WorkDayModel> workDays;

  // GetDoctorWorkDaysSuccess({required this.workDays});
}
