import 'package:dartz/dartz.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/features/authentication/data/models/login_response_model.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/authentication/data/models/secretary_model.dart';

abstract class AuthenticationRepo {
  Future<Either<Failure, LoginResponseModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout({
    required String token,
  });

  Future<Either<Failure, PatientModel>> getPatientData({
    required String adminToken,
    required int userID,
  });

  Future<Either<Failure, SecretaryModel>> getSecretaryData({
    required String adminToken,
    required int userID,
  });
}
