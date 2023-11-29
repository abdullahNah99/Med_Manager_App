import 'package:dartz/dartz.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';

abstract class HomeDoctorRepo {
  Future<Either<Failure, List<PatientModel>>> indexDoctorPatients({
    required String token,
  });

  Future<Either<Failure, List<AppointmentModel>>>
      indexApprovedAppointmentsByDate({
    required String secretaryToken,
    required int doctorID,
    required String date,
  });

  Future<Either<Failure, List<String>>> indexApprovedAppointmentsDates({
    required String secretaryToken,
    required int doctorID,
  });
}
