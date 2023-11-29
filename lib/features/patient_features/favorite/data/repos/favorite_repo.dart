import 'package:dartz/dartz.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

abstract class FavoriteRepo {
  Future<Either<Failure, List<DoctorModel>>> indexFavorite({
    required String token,
  });

  Future<Either<Failure, String>> addToFavorite({
    required String token,
    required int doctorID,
  });

  Future<Either<Failure, String>> deleteFromFavorite({
    required String token,
    required int doctorID,
  });

  Future<Either<Failure, bool>> checkFavorite({
    required String token,
    required int doctorID,
  });
}
