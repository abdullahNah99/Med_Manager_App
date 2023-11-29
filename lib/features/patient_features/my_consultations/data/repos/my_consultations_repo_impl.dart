import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/core/utils/dio_helper.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/models/consultation_model.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/repos/my_consultations_repo.dart';

class MyConsultationsRepoImpl extends MyConsultationsRepo {
  @override
  Future<Either<Failure, List<ConsultationModel>>> getMyConsultation({
    required String token,
  }) async {
    try {
      var response = await DioHelper.getData(
        url: 'consultation/index',
        token: token,
      );
      List<ConsultationModel> myConsultations = [];
      for (var item in response.data['consultaion']) {
        myConsultations.add(ConsultationModel.fromJson(item));
      }
      return right(myConsultations);
    } catch (ex) {
      log('There is an error in getMyConsultation method in MyConsultationsRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
