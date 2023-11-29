import 'package:equatable/equatable.dart';
import 'package:med_manager_app/features/authentication/data/models/user_model.dart';

final class PatientModel extends Equatable {
  final int id;
  final String address;
  final String fcmToken;
  final String gender;
  final String birthDate;
  final int userID;
  final int patientWallet;
  final UserModel userModel;

  const PatientModel({
    required this.id,
    required this.address,
    required this.fcmToken,
    required this.gender,
    required this.birthDate,
    required this.userID,
    required this.patientWallet,
    required this.userModel,
  });

  factory PatientModel.fromJson(Map<String, dynamic> jsonData) {
    return PatientModel(
      id: jsonData['id'],
      address: jsonData['address'],
      fcmToken: jsonData['FCMToken'],
      gender: jsonData['gender'],
      birthDate: jsonData['birth_date'],
      userID: jsonData['user_id'],
      patientWallet: jsonData['patient_wallet'],
      userModel: UserModel.fromJson(jsonData['user']),
    );
  }

  @override
  List<Object> get props => [
        id,
        address,
        fcmToken,
        gender,
        birthDate,
        userID,
        patientWallet,
        userModel,
      ];
}
