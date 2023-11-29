import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  final String token;
  final String role;

  const LoginResponseModel({
    required this.token,
    required this.role,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginResponseModel(
      token: jsonData['token'],
      role: jsonData['role'],
    );
  }

  @override
  List<Object?> get props => [token, role];
}
