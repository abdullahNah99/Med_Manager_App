import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:med_manager_app/core/utils/app_constants.dart';
import 'package:med_manager_app/core/utils/cache_helper.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/features/authentication/data/models/login_response_model.dart';
import 'package:med_manager_app/features/authentication/data/repos/authentication_repo.dart';
import 'package:med_manager_app/features/authentication/presentation/cubits/login_cubit/login_states.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/repos/home_patient_repo_impl.dart';

class LoginCubit extends Cubit<LoginStates> {
  final AuthenticationRepo authenticationRepo;
  final formKey = GlobalKey<FormState>();
  IconData passwordSuffixIcon = Icons.remove_red_eye;
  String email = '';
  String password = '';
  bool obscureText = true;

  LoginCubit({required this.authenticationRepo}) : super(LoginInitial());

  void changePasswordSuffixIcon() {
    if (passwordSuffixIcon == Icons.remove_red_eye) {
      passwordSuffixIcon = FontAwesomeIcons.solidEyeSlash;
    } else {
      passwordSuffixIcon = Icons.remove_red_eye;
    }
    obscureText = !obscureText;
    emit(LoginChangeSuffixIcon());
  }

  int getUserID({required String token}) {
    return int.parse(JwtDecoder.decode(token)['sub']);
  }

  Future<void> login() async {
    emit(LoginLoading());
    (await authenticationRepo.login(email: email, password: password)).fold(
      (failure) {
        emit(LoginFailure(failureMsg: failure.errorMessege));
      },
      (loginResponseModel) async {
        await CacheHelper.saveData(
          key: 'Token',
          value: loginResponseModel.token,
        );
        await CacheHelper.saveData(
          key: 'Role',
          value: loginResponseModel.role,
        );
        await CacheHelper.saveData(
          key: 'UserID',
          value: getUserID(
            token: loginResponseModel.token,
          ),
        );
        if (loginResponseModel.role == 'patient') {
          getPatientData(loginResponseModel: loginResponseModel);
        } else if (loginResponseModel.role == 'secretary') {
          getSecretaryData(loginResponseModel: loginResponseModel);
        } else {
          getDoctorData(loginResponseModel: loginResponseModel);
        }
      },
    );
  }

  Future<void> getPatientData(
      {required LoginResponseModel loginResponseModel}) async {
    (await authenticationRepo.getPatientData(
      adminToken: AppConstants.adminToken,
      userID: getUserID(token: loginResponseModel.token),
    ))
        .fold(
      (failure) {
        emit(LoginFailure(failureMsg: failure.errorMessege));
      },
      (patientModel) {
        emit(LoginSuccess(patientModel: patientModel));
      },
    );
  }

  Future<void> getSecretaryData({
    required LoginResponseModel loginResponseModel,
  }) async {
    (await authenticationRepo.getSecretaryData(
      adminToken: AppConstants.adminToken,
      userID: getUserID(token: loginResponseModel.token),
    ))
        .fold(
      (failure) {
        emit(LoginFailure(failureMsg: failure.errorMessege));
      },
      (secretaryModel) {
        emit(LoginSuccess(secretaryModel: secretaryModel));
      },
    );
  }

  Future<void> getDoctorData({
    required LoginResponseModel loginResponseModel,
  }) async {
    (await getIt.get<HomePatientRepoImpl>().viewDoctorDetails(
              token: await CacheHelper.getData(key: 'Token'),
              userID: getUserID(token: loginResponseModel.token),
            ))
        .fold(
      (failure) {
        emit(LoginFailure(failureMsg: failure.errorMessege));
      },
      (doctorModel) {
        emit(LoginSuccess(doctorModel: doctorModel));
      },
    );
  }
}
