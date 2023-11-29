import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/core/utils/dio_helper.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/repos/handle_appointments_repo.dart';

class HandleAppointmentsRepoImpl extends HandleAppointmentsRepo {
  // @override
  // Future<Either<Failure, List<BookedAppointmentsModel>>> getBookedAppointments({
  //   required String token,
  //   required int appointmentID,
  // }) async {
  //   try {
  //     var response = await DioHelper.getData(
  //       url: 'handled/view/$appointmentID',
  //       token: token,
  //     );
  //     List<BookedAppointmentsModel> bookedAppointments = [];
  //     for (var item in response.data['Booked Appointments']) {
  //       bookedAppointments.add(BookedAppointmentsModel.fromJson(item));
  //     }
  //     return right(bookedAppointments);
  //   } catch (ex) {
  //     log('There is an error in getBookedAppointments method in HandleAppointmentsRepoImpl');
  //     log(ex.toString());
  //     if (ex is DioException) {
  //       log(ex.response?.data.toString() ?? '');
  //       return left(ServerFailure.fromDioException(ex));
  //     }
  //     return left(ServerFailure(ex.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, String>> approveAppointment({
    required String token,
    required int appointmentID,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'approveTheAppointment/$appointmentID',
        body: {},
        token: token,
      );
      return right(response.data['message']);
    } catch (ex) {
      log('There is an error in approveAppointment method in HandleAppointmentsRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment({
    required String token,
    required int appointmentID,
    required String cancelReason,
  }) async {
    try {
      await DioHelper.postData(
        url: 'cancelAppointment/$appointmentID',
        body: {
          'cancel_reason': cancelReason,
        },
        token: token,
      );
      return right(null);
    } catch (ex) {
      log('There is an error in getBookedAppointments method in HandleAppointmentsRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> handleAppointment({
    required String token,
    required int appointmentID,
    required String date,
    required String time,
  }) async {
    try {
      await DioHelper.postData(
        url: 'AppointmentHandle',
        body: {
          'id': appointmentID,
          'date': date,
          'time': time,
          'status': 'approve',
        },
        token: token,
      );
      return right(null);
    } catch (ex) {
      log('There is an error in handleAppointment method in HandleAppointmentsRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
