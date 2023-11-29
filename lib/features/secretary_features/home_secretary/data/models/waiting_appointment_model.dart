import 'package:equatable/equatable.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class WaitingAppointmentModel extends Equatable {
  final int id;
  final String date;
  final String time;
  final String status;
  final String description;
  final int patientID;
  final int doctorID;
  final int departmentID;
  final String cancelReason;
  final DoctorModel doctorModel;
  final PatientModel patientModel;

  const WaitingAppointmentModel({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
    required this.description,
    required this.patientID,
    required this.doctorID,
    required this.departmentID,
    required this.cancelReason,
    required this.doctorModel,
    required this.patientModel,
  });

  factory WaitingAppointmentModel.fomJson(Map<String, dynamic> jsonData) {
    return WaitingAppointmentModel(
      id: jsonData['id'],
      date: jsonData['date'],
      time: jsonData['time'],
      status: jsonData['status'],
      description: jsonData['description'],
      patientID: jsonData['patient_id'],
      doctorID: jsonData['doctor_id'],
      departmentID: jsonData['department_id'],
      cancelReason: jsonData['cancel_reason'],
      doctorModel: DoctorModel.fromJson(jsonData['doctor']),
      patientModel: PatientModel.fromJson(jsonData['patient']),
    );
  }

  @override
  List<Object> get props => [
        id,
        status,
        description,
        patientID,
        doctorID,
        departmentID,
        cancelReason,
        doctorModel,
      ];
}
