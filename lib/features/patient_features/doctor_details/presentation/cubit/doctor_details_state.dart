abstract class DoctorDetailsStates {}

final class DoctorDetailsInitial extends DoctorDetailsStates {}

final class DoctorDetailsLoading extends DoctorDetailsStates {}

final class DoctorDetailsFailure extends DoctorDetailsStates {
  final String failureMsg;

  DoctorDetailsFailure({required this.failureMsg});
}

final class GetDoctorDepartmentSuccess extends DoctorDetailsStates {}

final class RatingDoctorSuccess extends DoctorDetailsStates {
  final String message;

  RatingDoctorSuccess({required this.message});
}

final class ChangeFavoriteState extends DoctorDetailsStates {
  final String message;

  ChangeFavoriteState({required this.message});
}

final class GetDoctorDetailsSuccess extends DoctorDetailsStates {}

final class SendQuestionSeccess extends DoctorDetailsStates {
  final String message;

  SendQuestionSeccess({required this.message});
}
