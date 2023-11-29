import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/core/utils/dio_helper.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/features/patient_features/favorite/data/repos/favorite_repo.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/repos/home_patient_repo_impl.dart';

class FavoriteRepoImpl extends FavoriteRepo {
  @override
  Future<Either<Failure, List<DoctorModel>>> indexFavorite(
      {required String token}) async {
    try {
      var response = await DioHelper.getData(
        url: 'favorite/index',
        token: token,
      );
      List<DoctorModel> doctors = [];
      for (var item in response.data['session']) {
        (await getIt.get<HomePatientRepoImpl>().viewDoctorDetails(
                  token: token,
                  userID: item['user_id'],
                ))
            .fold(
          (failure) {
            throw Exception(failure.errorMessege);
          },
          (doctorModel) {
            doctorModel.isFavorited = true;
            doctors.add(doctorModel);
          },
        );
      }
      return right(doctors);
    } catch (ex) {
      log('There is an error in indexFavorite method in FavoriteRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addToFavorite({
    required String token,
    required int doctorID,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'favorite/store',
        body: {'doctor_id': doctorID},
        token: token,
      );
      return right(response.data['message']);
    } catch (ex) {
      log('There is an error in addToFavorite method in HomePatientRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteFromFavorite({
    required String token,
    required int doctorID,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'favorite/deleteOnDoctor',
        body: {'doctor_id': doctorID},
        token: token,
      );
      return right(response.data['message']);
    } catch (ex) {
      log('There is an error in deleteFromFavorite method in HomePatientRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkFavorite({
    required String token,
    required int doctorID,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'favorite/isfavorated',
        body: {'doctor_id': doctorID},
        token: token,
      );
      return right(response.data['isFavorated']);
    } catch (ex) {
      log('There is an error in checkFavorite method in HomePatientRepoImpl');
      log(ex.toString());
      if (ex is DioException) {
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
