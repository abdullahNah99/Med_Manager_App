import 'package:med_manager_app/features/authentication/data/models/user_model.dart';

class DoctorModel {
  final int id;
  final String specialty;
  final String description;
  final String image;
  final int departmentID;
  final int consultationPrice;
  final int doctorWallet;
  final int userID;
  final UserModel user;
  int review;
  bool isFavorited = false;
  String? departmentImg;

  DoctorModel({
    required this.id,
    required this.specialty,
    required this.description,
    required this.image,
    required this.departmentID,
    required this.consultationPrice,
    required this.review,
    required this.doctorWallet,
    required this.userID,
    required this.user,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> jsonData) {
    return DoctorModel(
      id: jsonData['id'],
      specialty: jsonData['specialty'],
      description: jsonData['description'],
      image: jsonData['image_path'],
      departmentID: jsonData['department_id'],
      consultationPrice: jsonData['consultation_price'],
      review: jsonData['review'],
      doctorWallet: jsonData['doctor_wallet'],
      userID: jsonData['user_id'],
      user: UserModel.fromJson(jsonData['user']),
    );
  }
}
