import 'package:dartz/dartz.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/models/consultation_model.dart';

abstract class MyConsultationsRepo {
  Future<Either<Failure, List<ConsultationModel>>> getMyConsultation({
    required String token,
  });
}
