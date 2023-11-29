import 'package:dartz/dartz.dart';
import 'package:med_manager_app/core/errors/failures.dart';

abstract class HandleAppointmentsRepo {
  // Future<Either<Failure, List<BookedAppointmentsModel>>> getBookedAppointments({
  //   required String token,
  //   required int appointmentID,
  // });

  Future<Either<Failure, String>> approveAppointment({
    required String token,
    required int appointmentID,
  });

  Future<Either<Failure, void>> cancelAppointment({
    required String token,
    required int appointmentID,
    required String cancelReason,
  });

  Future<Either<Failure, void>> handleAppointment({
    required String token,
    required int appointmentID,
    required String date,
    required String time,
  });
}
