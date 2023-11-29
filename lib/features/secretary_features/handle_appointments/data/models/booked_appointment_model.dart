import 'package:equatable/equatable.dart';

class BookedAppointmentsModel extends Equatable {
  final String date;
  final String time;
  final String description;

  const BookedAppointmentsModel({
    required this.date,
    required this.time,
    required this.description,
  });

  factory BookedAppointmentsModel.fromJson(Map<String, dynamic> jsonData) {
    return BookedAppointmentsModel(
      date: jsonData['date'],
      time: jsonData['time'],
      description: jsonData['description'],
    );
  }

  @override
  List<Object> get props => [date, time, description];
}
