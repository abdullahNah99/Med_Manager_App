import 'package:dartz/dartz.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/models/add_appointment_model.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/models/work_day_model.dart';

abstract class AddAppointmentRepo {
  Future<Either<Failure, List<WorkDayModel>>> indexDoctorWorkDays({
    required String adminToken,
    required int doctorID,
  });

  Future<Either<Failure, String>> addAppointment({
    required String token,
    required AddAppointmentModel addAppointmentModel,
  });
}
