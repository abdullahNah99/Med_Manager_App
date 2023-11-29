import 'package:equatable/equatable.dart';
import 'package:med_manager_app/features/authentication/data/models/user_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/department_model.dart';

class SecretaryModel extends Equatable {
  final int id;
  final int userID;
  final int departmentID;
  final UserModel userModel;
  final DepartmentModel departmentModel;

  const SecretaryModel({
    required this.id,
    required this.userID,
    required this.departmentID,
    required this.userModel,
    required this.departmentModel,
  });

  factory SecretaryModel.fromJson(Map<String, dynamic> jsonData) {
    var data = jsonData['secretary'];
    return SecretaryModel(
      id: data['id'],
      userID: data['user_id'],
      departmentID: data['department_id'],
      userModel: UserModel.fromJson(data['user']),
      departmentModel: DepartmentModel.fromJson(jsonData['department']),
    );
  }

  @override
  List<Object> get props => [
        id,
        userID,
        departmentID,
        userModel,
        departmentModel,
      ];
}
