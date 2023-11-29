import 'package:equatable/equatable.dart';

final class WorkDayModel extends Equatable {
  final int id;
  final int doctorID;
  final String day;
  final String statrtTime;
  final String endTime;

  const WorkDayModel({
    required this.id,
    required this.doctorID,
    required this.day,
    required this.statrtTime,
    required this.endTime,
  });

  factory WorkDayModel.fromJson(Map<String, dynamic> jsonData) {
    return WorkDayModel(
      id: jsonData['id'],
      doctorID: jsonData['doctor_id'],
      day: jsonData['day'],
      statrtTime: jsonData['start_time'],
      endTime: jsonData['end_time'],
    );
  }

  @override
  List<Object> get props => [id, doctorID, day, statrtTime, endTime];
}
