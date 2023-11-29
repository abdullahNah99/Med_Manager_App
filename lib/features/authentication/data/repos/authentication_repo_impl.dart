import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/core/utils/dio_helper.dart';
import 'package:med_manager_app/features/authentication/data/models/login_response_model.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/authentication/data/models/secretary_model.dart';
import 'authentication_repo.dart';

class AuthenticationRepoImpl extends AuthenticationRepo {
  @override
  Future<Either<Failure, LoginResponseModel>> login(
      {required String email, required String password}) async {
    try {
      var response = await DioHelper.postData(
        url: 'login',
        body: {
          'email': email,
          'password': password,
        },
      );
      return right(LoginResponseModel.fromJson(response.data));
    } catch (ex) {
      log('There is an error in login method in AuthenticationRepoImpl');
      if (ex is DioException) {
        return left(
          ServerFailure(
            ex.response?.data['message'] ??
                'Something Went Wrong, Please Try Again',
          ),
        );
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout({required String token}) async {
    try {
      await DioHelper.getData(url: 'logout', token: token);
      return right(null);
    } catch (ex) {
      log('There is an error in logout method in AuthenticationRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, PatientModel>> getPatientData({
    required String adminToken,
    required int userID,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'viewPatient',
        body: {
          'user_id': userID,
        },
        token: adminToken,
      );
      return right(PatientModel.fromJson(response.data['Patient']));
    } catch (ex) {
      log('There is an error in getPatientData method in AuthenticationRepoImpl');
      if (ex is DioException) {
        log(ex.toString());
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, SecretaryModel>> getSecretaryData({
    required String adminToken,
    required int userID,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'viewSecretary',
        body: {
          'user_id': userID,
        },
        token: adminToken,
      );
      return right(SecretaryModel.fromJson(response.data));
    } catch (ex) {
      log('There is an error in getSecretaryData method in AuthenticationRepoImpl');
      if (ex is DioException) {
        log(ex.toString());
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
