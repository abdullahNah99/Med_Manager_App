import 'package:dartz/dartz.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/models/work_day_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/data/models/waiting_appointment_model.dart';

abstract class HomeSecretaryRepo {
  Future<Either<Failure, List<String>>> getWaitingAppointmentsDates({
    required String token,
  });

  Future<Either<Failure, List<WaitingAppointmentModel>>>
      indexWaintingAppointmentsByDate({
    required String token,
    required String date,
  });

  Future<Either<Failure, List<WorkDayModel>>> getDepartmentDoctorsWorkDays({
    required String adminToken,
    required int departmentID,
  });

  Future<Either<Failure, List<AppointmentModel>>> indexDepartmentAppointments({
    required String token,
    required int departmentID,
  });
}
