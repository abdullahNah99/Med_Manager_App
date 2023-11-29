import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_constants.dart';
import 'package:med_manager_app/core/utils/cache_helper.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/data/repo/doctor_details_repo.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/cubit/doctor_details_state.dart';
import 'package:med_manager_app/features/patient_features/favorite/data/repos/favorite_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/repos/home_patient_repo_impl.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsStates> {
  final DoctorDetailsRepo doctorDetailsRepo;
  String? doctorDepartmentImg;
  int? ratingValue;
  String? question;
  final formKey = GlobalKey<FormState>();
  DoctorDetailsCubit({required this.doctorDetailsRepo})
      : super(DoctorDetailsInitial());

  Future<void> getDoctorDepartment({required DoctorModel doctorModel}) async {
    emit(DoctorDetailsLoading());
    (await doctorDetailsRepo.getDoctorDepartment(
      adminToken: AppConstants.adminToken,
      departmentID: doctorModel.departmentID,
    ))
        .fold(
      (failure) {
        emit(DoctorDetailsFailure(failureMsg: failure.errorMessege));
      },
      (department) {
        doctorDepartmentImg = department.image;
        doctorModel.departmentImg = department.image;
        emit(GetDoctorDepartmentSuccess());
      },
    );
  }

  Future<void> addToFavorite({required DoctorModel doctor}) async {
    emit(DoctorDetailsLoading());
    (await getIt.get<FavoriteRepoImpl>().addToFavorite(
              token: await CacheHelper.getData(key: 'Token'),
              doctorID: doctor.id,
            ))
        .fold(
      (failure) {
        emit(DoctorDetailsFailure(failureMsg: failure.errorMessege));
      },
      (message) {
        doctor.isFavorited = true;
        emit(ChangeFavoriteState(message: message));
      },
    );
  }

  Future<void> deleteFromFavorite({required DoctorModel doctor}) async {
    emit(DoctorDetailsLoading());
    (await getIt.get<FavoriteRepoImpl>().deleteFromFavorite(
              token: await CacheHelper.getData(key: 'Token'),
              doctorID: doctor.id,
            ))
        .fold(
      (failure) {
        emit(DoctorDetailsFailure(failureMsg: failure.errorMessege));
      },
      (message) {
        doctor.isFavorited = false;
        emit(ChangeFavoriteState(message: message));
      },
    );
  }

  Future<void> ratingDoctor({
    required DoctorModel doctorModel,
  }) async {
    if (ratingValue != null) {
      emit(DoctorDetailsLoading());
      (await doctorDetailsRepo.ratingDoctor(
        token: await CacheHelper.getData(key: 'Token'),
        doctorID: doctorModel.id,
        value: ratingValue!,
      ))
          .fold(
        (failure) {
          emit(DoctorDetailsFailure(failureMsg: failure.errorMessege));
        },
        (message) async {
          await getDoctorDetails(doctorModel: doctorModel).then(
            (value) {
              emit(
                RatingDoctorSuccess(message: message),
              );
              ratingValue = null;
            },
          );
        },
      );
    }
  }

  Future<void> getDoctorDetails({required DoctorModel doctorModel}) async {
    emit(DoctorDetailsLoading());
    (await getIt.get<HomePatientRepoImpl>().viewDoctorDetails(
              token: await CacheHelper.getData(key: 'Token'),
              userID: doctorModel.userID,
            ))
        .fold(
      (failure) {
        emit(DoctorDetailsFailure(failureMsg: failure.errorMessege));
      },
      (doctor) {
        doctorModel.review = doctor.review;
        emit(GetDoctorDetailsSuccess());
      },
    );
  }

  Future<void> sendQuestion({required int doctorID}) async {
    emit(DoctorDetailsLoading());
    (await doctorDetailsRepo.sendQuestion(
      token: await CacheHelper.getData(key: 'Token'),
      question: question!,
      doctorID: doctorID,
    ))
        .fold(
      (failure) {
        emit(DoctorDetailsFailure(failureMsg: failure.errorMessege));
      },
      (message) {
        emit(SendQuestionSeccess(message: message));
      },
    );
  }
}
