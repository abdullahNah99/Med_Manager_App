import 'package:equatable/equatable.dart';
import 'package:med_manager_app/core/utils/date_helper.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/department_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class AppointmentModel extends Equatable {
  final int id;
  final String date;
  final String time;
  final String status;
  final String description;
  final int patientID;
  final int doctorID;
  final int departmentID;
  final String cancelReason;
  final DepartmentModel? departmentModel;
  final DoctorModel? doctorModel;
  final PatientModel? patientModel;

  const AppointmentModel({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
    required this.description,
    required this.patientID,
    required this.doctorID,
    required this.departmentID,
    required this.cancelReason,
    required this.departmentModel,
    required this.doctorModel,
    required this.patientModel,
  });

  factory AppointmentModel.fomJson(Map<String, dynamic> jsonData) {
    final DepartmentModel? department = jsonData['department'] != null
        ? DepartmentModel.fromJson(jsonData['department'])
        : null;
    final DoctorModel? doctor = jsonData['doctor'] != null
        ? DoctorModel.fromJson(jsonData['doctor'])
        : null;
    final PatientModel? patient = jsonData['patient'] != null
        ? PatientModel.fromJson(jsonData['patient'])
        : null;

    return AppointmentModel(
      id: jsonData['id'],
      date: jsonData['date'],
      time: jsonData['time'],
      status: jsonData['status'],
      description: jsonData['description'],
      patientID: jsonData['patient_id'],
      doctorID: jsonData['doctor_id'],
      departmentID: jsonData['department_id'],
      cancelReason: jsonData['cancel_reason'],
      departmentModel: department,
      doctorModel: doctor,
      patientModel: patient,
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
        departmentModel.toString(),
        // doctorModel,
      ];

  int compareTwoTimes({required String time}) {
    int h1 = DateHelper.getHour24(time: this.time);
    int h2 = DateHelper.getHour24(time: time);
    if (h1 > h2) {
      return 1;
    } else if (h1 == h2) {
      int m1 = int.parse(this.time.split(':')[1].split(' ')[0]);
      int m2 = int.parse(time.split(':')[1].split(' ')[0]);
      if (m1 > m2) {
        return 1;
      } else if (m1 == m2) {
        return 0;
      } else {
        return -1;
      }
    } else {
      return -1;
    }
  }
}
