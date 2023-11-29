abstract class MyConsultationsStates {}

final class MyConsultationsInitial extends MyConsultationsStates {}

final class MyConsultationsLoading extends MyConsultationsStates {}

final class MyConsultationsSuccess extends MyConsultationsStates {}

final class MyConsultationsFailure extends MyConsultationsStates {
  final String failureMsg;

  MyConsultationsFailure({required this.failureMsg});
}

final class ShowAnswerState extends MyConsultationsStates {}
