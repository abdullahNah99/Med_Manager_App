import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/core/utils/dio_helper.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/department_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/repos/home_patient_repo.dart';

class HomePatientRepoImpl extends HomePatientRepo {
  @override
  Future<Either<Failure, List<DepartmentModel>>> getDepartments(
      {required String token}) async {
    try {
      var response =
          await DioHelper.getData(url: 'indexDepartment', token: token);
      List<DepartmentModel> departments = [];
      for (var item in response.data['Department']) {
        departments.add(DepartmentModel.fromJson(item));
      }
      return right(departments);
    } catch (ex) {
      log('There is an error in getDepartments method in HomePatientRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorsByDepartment(
      {required String adminToken, required int departmentID}) async {
    try {
      var response = await DioHelper.postData(
        url: 'doctors/indexByDepartment',
        token: adminToken,
        body: {'department_id': departmentID},
      );
      List<DoctorModel> doctors = [];
      for (var item in response.data['Doctor']) {
        doctors.add(DoctorModel.fromJson(item));
      }
      return right(doctors);
    } catch (ex) {
      log('There is an error in getDoctorsByDepartment method in HomePatientRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorModel>> viewDoctorDetails({
    required String token,
    required int userID,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'viewDoctor',
        body: {'user_id': userID},
        token: token,
      );
      return right(DoctorModel.fromJson(response.data['doctor']));
    } catch (ex) {
      log('There is an error in viewDoctorDetails method in HomePatientRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
