import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class ConsultationModel {
  final int id;
  final String question;
  final String questionDate;
  final String answer;
  final String answerDate;
  final int doctorID;
  final int patientID;
  final DoctorModel? doctorModel;
  final PatientModel? patientModel;
  bool showAnswer;

  ConsultationModel({
    required this.id,
    required this.question,
    required this.questionDate,
    required this.answer,
    required this.answerDate,
    required this.doctorID,
    required this.patientID,
    this.doctorModel,
    this.patientModel,
    required this.showAnswer,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> jsonData) {
    final DoctorModel? doctor;
    final PatientModel? patient;
    if (jsonData['patient'] != null) {
      doctor = null;
      patient = PatientModel.fromJson(jsonData['patient']);
    } else {
      patient = null;
      doctor = DoctorModel.fromJson(jsonData['doctor']);
    }
    return ConsultationModel(
      id: jsonData['id'],
      question: jsonData['question'],
      questionDate: jsonData['question_date'],
      answer: jsonData['answer'],
      answerDate: jsonData['answer_date'],
      doctorID: jsonData['doctor_id'],
      patientID: jsonData['patient_id'],
      doctorModel: doctor,
      patientModel: patient,
      showAnswer: false,
      // doctorModel: DoctorModel.fromJson(jsonData['doctor']),
      // patientModel: PatientModel.fromJson(jsonData['patient']),
    );
  }
}
