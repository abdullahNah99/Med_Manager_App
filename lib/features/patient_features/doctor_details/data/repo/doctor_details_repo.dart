import 'package:dartz/dartz.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/department_model.dart';

abstract class DoctorDetailsRepo {
  Future<Either<Failure, DepartmentModel>> getDoctorDepartment({
    required String adminToken,
    required int departmentID,
  });

  Future<Either<Failure, String>> ratingDoctor({
    required String token,
    required int doctorID,
    required int value,
  });

  Future<Either<Failure, String>> sendQuestion({
    required String token,
    required String question,
    required int doctorID,
  });
}
