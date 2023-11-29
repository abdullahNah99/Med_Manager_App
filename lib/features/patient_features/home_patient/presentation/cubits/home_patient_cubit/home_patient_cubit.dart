import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_constants.dart';
import 'package:med_manager_app/core/utils/cache_helper.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/features/authentication/data/repos/authentication_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/favorite/data/repos/favorite_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/department_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/repos/home_patient_repo.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_states.dart';

class HomePatientCubit extends Cubit<HomePatientStates> {
  final HomePatientRepo homePatientRepo;
  int selectedDepartmentIndex = 0;
  int previousDepartmentIndex = 0;
  List<DepartmentModel> departments = [];
  List<DoctorModel> doctors = [];
  HomePatientCubit({required this.homePatientRepo})
      : super(HomePatientInitial());

  Future<void> logout() async {
    emit(HomePatientLoading());
    (await getIt.get<AuthenticationRepoImpl>().logout(
              token: await CacheHelper.getData(key: 'Token'),
            ))
        .fold(
      (failure) => emit(HomePatientFailure(failureMsg: failure.errorMessege)),
      (success) async {
        await CacheHelper.deletData(key: 'Token');
        await CacheHelper.deletData(key: 'Role');
        await CacheHelper.deletData(key: 'UserID');
        emit(LogOutSuccess());
      },
    );
  }

  Future<void> getDepartments() async {
    emit(HomePatientLoading());
    (await homePatientRepo.getDepartments(
      token: await CacheHelper.getData(key: 'Token'),
    ))
        .fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (departments) async {
        this.departments = departments;

        emit(GetDepartmentsSuccess());
      },
    );
  }

  Future<void> getDoctorsByDepartment() async {
    emit(HomePatientLoading());
    (await homePatientRepo.getDoctorsByDepartment(
      adminToken: AppConstants.adminToken,
      departmentID: departments[selectedDepartmentIndex].id,
    ))
        .fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (doctors) async {
        await checkFavorite(doctors: doctors);
        emit(GetDoctorsSuccess());
      },
    );
  }

  Future<void> getHomePatientData() async {
    await getDepartments().then(
      (value) async {
        await getDoctorsByDepartment();
      },
    );
  }

  Future<void> selectDepartmentItem({required int index}) async {
    if (selectedDepartmentIndex != index) {
      previousDepartmentIndex = selectedDepartmentIndex;
      selectedDepartmentIndex = index;
      emit(SelectDepartmentState());
      await getDoctorsByDepartment();
    }
  }

  Future<void> checkFavorite({required List<DoctorModel> doctors}) async {
    for (DoctorModel doc in doctors) {
      (await getIt.get<FavoriteRepoImpl>().checkFavorite(
                token: await CacheHelper.getData(key: 'Token'),
                doctorID: doc.id,
              ))
          .fold(
        (failure) {
          emit(HomePatientFailure(failureMsg: failure.errorMessege));
        },
        (isFavorited) {
          doc.isFavorited = isFavorited;
        },
      );
    }
    this.doctors = doctors;
  }

  Future<void> addToFavorite({
    required DoctorModel doctor,
    required int index,
  }) async {
    emit(HomePatientLoading());
    (await getIt.get<FavoriteRepoImpl>().addToFavorite(
              token: await CacheHelper.getData(key: 'Token'),
              doctorID: doctor.id,
            ))
        .fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (message) {
        doctor.isFavorited = true;
        emit(ChangeFavoriteState(
          message: message,
          index: index,
        ));
      },
    );
  }

  Future<void> deleteFromFavorite({
    required DoctorModel doctor,
    required int index,
  }) async {
    emit(HomePatientLoading());
    (await getIt.get<FavoriteRepoImpl>().deleteFromFavorite(
              token: await CacheHelper.getData(key: 'Token'),
              doctorID: doctor.id,
            ))
        .fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (message) {
        doctor.isFavorited = false;
        emit(ChangeFavoriteState(message: message, index: index));
      },
    );
  }

  Future<void> getPatientData() async {
    emit(BalanceLoadingState());
    (await getIt.get<AuthenticationRepoImpl>().getPatientData(
              adminToken: AppConstants.adminToken,
              userID: await CacheHelper.getData(key: 'UserID'),
            ))
        .fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (patient) {
        emit(GetPatientDataSuccess(patientModel: patient));
      },
    );
  }
}
