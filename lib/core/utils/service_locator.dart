import 'package:get_it/get_it.dart';
import 'package:med_manager_app/features/authentication/data/repos/authentication_repo_impl.dart';
import 'package:med_manager_app/features/doctor_features/features/home_doctor/data/repos/home_doctor_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/repos/add_appointment_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/favorite/data/repos/favorite_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/repos/home_patient_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/repos/my_appointments_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/repos/my_consultations_repo_impl.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/repos/handle_appointments_repo_impl.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/data/repos/home_secretary_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<AuthenticationRepoImpl>(
    AuthenticationRepoImpl(),
  );
  getIt.registerSingleton<HomePatientRepoImpl>(
    HomePatientRepoImpl(),
  );
  getIt.registerSingleton<FavoriteRepoImpl>(
    FavoriteRepoImpl(),
  );
  getIt.registerSingleton<AddAppointmentRepoImpl>(
    AddAppointmentRepoImpl(),
  );
  getIt.registerSingleton<MyAppointmentsRepoImpl>(
    MyAppointmentsRepoImpl(),
  );
  getIt.registerSingleton<MyConsultationsRepoImpl>(
    MyConsultationsRepoImpl(),
  );
  getIt.registerSingleton<HomeSecretaryRepoImpl>(
    HomeSecretaryRepoImpl(),
  );
  getIt.registerSingleton<HandleAppointmentsRepoImpl>(
    HandleAppointmentsRepoImpl(),
  );
  getIt.registerSingleton<HomeDoctorRepoImpl>(
    HomeDoctorRepoImpl(),
  );
}
