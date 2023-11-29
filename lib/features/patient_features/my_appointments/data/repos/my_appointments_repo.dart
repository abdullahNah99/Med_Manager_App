import 'package:dartz/dartz.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';

abstract class MyAppointmentsRepo {
  Future<Either<Failure, List<AppointmentModel>>> getMyApointments({
    required String token,
    required int patientID,
  });

  Future<Either<Failure, String>> deleteAppointment({
    required String token,
    required int id,
  });
}
