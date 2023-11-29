import 'package:dartz/dartz.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/department_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

abstract class HomePatientRepo {
  Future<Either<Failure, List<DepartmentModel>>> getDepartments({
    required String token,
  });

  Future<Either<Failure, List<DoctorModel>>> getDoctorsByDepartment({
    required String adminToken,
    required int departmentID,
  });

  Future<Either<Failure, DoctorModel>> viewDoctorDetails({
    required String token,
    required int userID,
  });
}
