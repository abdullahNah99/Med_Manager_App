import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/core/utils/dio_helper.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/repos/my_appointments_repo.dart';

class MyAppointmentsRepoImpl extends MyAppointmentsRepo {
  @override
  Future<Either<Failure, List<AppointmentModel>>> getMyApointments({
    required String token,
    required int patientID,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'indexAppointmentPatient',
        body: {
          'patient_id': patientID,
        },
        token: token,
      );
      List<AppointmentModel> myAppointments = [];
      for (var item in response.data['Appointment']) {
        myAppointments.add(AppointmentModel.fomJson(item));
      }
      return right(myAppointments);
    } catch (ex) {
      log('There is an error in getMyApointments method in MyAppointmentsRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAppointment({
    required String token,
    required int id,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'deleteAppointment',
        body: {
          'id': id,
        },
        token: token,
      );

      return right(response.data['message']);
    } catch (ex) {
      log('There is an error in deleteAppointment method in MyAppointmentsRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
