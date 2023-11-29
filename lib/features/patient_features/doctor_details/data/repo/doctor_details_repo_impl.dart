import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/core/utils/dio_helper.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/data/repo/doctor_details_repo.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/department_model.dart';

class DoctorDetailsRepoImpl extends DoctorDetailsRepo {
  @override
  Future<Either<Failure, DepartmentModel>> getDoctorDepartment(
      {required String adminToken, required int departmentID}) async {
    try {
      var response = await DioHelper.postData(
        url: 'viewDepartment',
        body: {'id': departmentID},
        token: adminToken,
      );
      return right(DepartmentModel.fromJson(response.data['item']));
    } catch (ex) {
      log('There is an error in getDoctorDepartment method in DoctorDetailsRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> ratingDoctor({
    required String token,
    required int doctorID,
    required int value,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'evaluation/store',
        body: {
          'doctor_id': doctorID,
          'value': value,
        },
        token: token,
      );
      return right(response.data['message']);
    } catch (ex) {
      log('There is an error in ratingDoctor method in DoctorDetailsRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendQuestion({
    required String token,
    required String question,
    required int doctorID,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'question/store',
        body: {
          'doctor_id': doctorID,
          'question': question,
        },
        token: token,
      );
      return right(response.data['message']);
    } catch (ex) {
      log('There is an error in sendQuestion method in DoctorDetailsRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
