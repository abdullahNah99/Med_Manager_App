import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/core/utils/dio_helper.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/models/add_appointment_model.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/models/work_day_model.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/repos/add_appointment_repo.dart';

class AddAppointmentRepoImpl extends AddAppointmentRepo {
  @override
  Future<Either<Failure, List<WorkDayModel>>> indexDoctorWorkDays({
    required String adminToken,
    required int doctorID,
  }) async {
    try {
      var response = await DioHelper.getData(
        url: 'indexWorkDay',
        token: adminToken,
      );
      List<WorkDayModel> workDays = [];
      for (var item in response.data['data']) {
        if (item['doctor_id'] == doctorID) {
          workDays.add(WorkDayModel.fromJson(item));
        }
      }
      return right(workDays);
    } catch (ex) {
      log('There is an error in indexWorkDays method in AddAppointmentRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addAppointment({
    required String token,
    required AddAppointmentModel addAppointmentModel,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'storeAppointment',
        token: token,
        body: {
          'date': addAppointmentModel.date,
          'time': addAppointmentModel.time,
          'description': addAppointmentModel.description,
          'department_id': addAppointmentModel.departmentID.toString(),
          'doctor_id': addAppointmentModel.doctorID,
        },
      );

      return right(response.data['message']);
    } catch (ex) {
      log('There is an error in addAppointment method in AddAppointmentRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
