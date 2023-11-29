import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/core/utils/dio_helper.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/models/work_day_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/data/models/waiting_appointment_model.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/data/repos/home_secretary_repo.dart';

class HomeSecretaryRepoImpl extends HomeSecretaryRepo {
  @override
  Future<Either<Failure, List<String>>> getWaitingAppointmentsDates({
    required String token,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'DateHaveAppointmentToHandel',
        body: {},
        token: token,
      );
      List<String> dates = [];
      for (var item in response.data['Appointment']) {
        dates.add(item['date']);
      }
      return right(dates);
    } catch (ex) {
      log('There is an error in getWaitingAppointmentsDates method in HomeSecretaryRepoImol');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WaitingAppointmentModel>>>
      indexWaintingAppointmentsByDate({
    required String token,
    required String date,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'indexAppointmentByDate',
        body: {'date': date},
        token: token,
      );
      List<WaitingAppointmentModel> waitingAppointments = [];
      for (var item in response.data['Appointment']) {
        waitingAppointments.add(WaitingAppointmentModel.fomJson(item));
      }
      return right(waitingAppointments);
    } catch (ex) {
      log('There is an error in indexWaintingAppointmentsByDate method in HomeSecretaryRepoImol');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WorkDayModel>>> getDepartmentDoctorsWorkDays({
    required String adminToken,
    required int departmentID,
  }) async {
    try {
      var response = await DioHelper.getData(
        url: 'indexWorkDay',
        token: adminToken,
      );
      List<WorkDayModel> workDays = [];
      for (var item in response.data['data']) {
        if (item['doctor']['department_id'] == departmentID) {
          workDays.add(WorkDayModel.fromJson(item));
        }
      }
      return right(workDays);
    } catch (ex) {
      log('There is an error in getDepartmentDoctorsWorkDays method in HomeSecretaryRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentModel>>> indexDepartmentAppointments({
    required String token,
    required int departmentID,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'indexAppointmentDepartmet',
        body: {'department_id': departmentID},
        token: token,
      );
      List<AppointmentModel> appointments = [];
      for (var item in response.data['Appointment']) {
        appointments.add(AppointmentModel.fomJson(item));
      }
      return right(appointments);
    } catch (ex) {
      log('There is an error in indexDepartmentAppointments method in HomeSecretaryRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
