abstract class DoctorStates {}

final class DoctorInitial extends DoctorStates {}

final class DoctorLoading extends DoctorStates {}

final class GetPatientsSuccess extends DoctorStates {}

final class GetConsultationsSuccess extends DoctorStates {}

final class GetApprovedAppointmentsSuccess extends DoctorStates {}

final class GetApprovedAppointmentsDatesSuccess extends DoctorStates {}

final class LogOutSuccess extends DoctorStates {}

final class BottomNavigationBarState extends DoctorStates {}

final class SelectDateState extends DoctorStates {}

final class DoctorFailure extends DoctorStates {
  final String failureMsg;

  DoctorFailure({required this.failureMsg});
}
