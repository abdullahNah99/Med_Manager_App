import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/cache_helper.dart';
import 'package:med_manager_app/features/patient_features/favorite/data/repos/favorite_repo.dart';
import 'package:med_manager_app/features/patient_features/favorite/presentation/cubit/favorite_state.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  final FavoriteRepo favoriteRepo;
  List<DoctorModel> favDoctors = [];
  FavoriteCubit({required this.favoriteRepo}) : super(FavoriteInitial());

  Future<void> indexFavorite() async {
    emit(FavoriteLoading());
    (await favoriteRepo.indexFavorite(
            token: await CacheHelper.getData(key: 'Token')))
        .fold(
      (failure) {
        emit(FavoriteEmptyState());
      },
      (doctors) {
        favDoctors = doctors;
        emit(FavoriteSuccess());
      },
    );
  }

  Future<void> deleteFromFavorite({required DoctorModel doctorModel}) async {
    emit(FavoriteLoading());
    (await favoriteRepo.deleteFromFavorite(
            token: await CacheHelper.getData(key: 'Token'),
            doctorID: doctorModel.id))
        .fold(
      (failure) {
        emit(FavoriteFailure(failureMsg: failure.errorMessege));
      },
      (success) {
        indexFavorite();
      },
    );
  }
}
