import 'package:equatable/equatable.dart';

class MyAppointmentsNavigatorModel extends Equatable {
  final int patientID;
  final bool scrollToDown;

  const MyAppointmentsNavigatorModel({
    required this.patientID,
    this.scrollToDown = false,
  });
  @override
  List<Object> get props => [patientID, scrollToDown];
}
