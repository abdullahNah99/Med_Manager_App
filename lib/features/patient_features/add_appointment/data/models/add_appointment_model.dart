final class AddAppointmentModel {
  String date;
  String time;
  String description;
  int departmentID;
  int doctorID;

  AddAppointmentModel({
    required this.date,
    required this.time,
    required this.description,
    required this.departmentID,
    required this.doctorID,
  });
}
