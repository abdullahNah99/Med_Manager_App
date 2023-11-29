import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/core/utils/custom_transitions.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/authentication/data/models/secretary_model.dart';
import 'package:med_manager_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_cubit.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/doctor_screen.dart';
import 'package:med_manager_app/features/doctor_features/features/home_doctor/data/repos/home_doctor_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/screens/add_appointment_screen.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/screens/doctor_details_screen.dart';
import 'package:med_manager_app/features/patient_features/favorite/presentation/screens/favorite_screen.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/repos/home_patient_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/screens/home_patient_screen.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/navigator_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/presentation/screens/my_appointments_screen.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/presentation/screens/my_consultations_screen.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/models/handle_appointment_navigator_model.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/screens/edit_appointment_request_screen/edit_apointment_request_screen.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/screens/handle_appointment_screen/handle_appointment_screen.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/data/repos/home_secretary_repo_impl.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_cubit.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/screens/home_secretary_screen.dart';
import 'package:med_manager_app/features/splash/presentation/screens/splash_screen.dart';

abstract class AppRouter {
  static const kLoginView = '/LoginView';
  static const kRegisterView = '/RegisterView';
  static const kPatientHomeView = '/PatientHomeView';
  static const kFavoriteView = '/FavoriteView';
  static const kDoctorDetailsView = '/DoctorDetailsView';
  static const kAddAppointmentView = '/AddAppointmentView';
  static const kMyAppointmentsView = '/MyAppointmentsView';
  static const kMyConsultationsView = '/MyConsultationsView';
  static const kHomeSecretaryView = '/HomeSecretaryView';
  static const kHandleAppointmentView = '/HandleAppointmentView';
  static const kEditAppointmentRequestView = '/EditAppointmentRequestView';
  static const kDoctorView = '/DoctorView';
  static const kDoctorConsultationsView = '/DoctorConsultationsView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kLoginView,
        pageBuilder: (context, state) => CenterTransition(
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kPatientHomeView,
        pageBuilder: (context, state) => CenterTransition(
          child: BlocProvider(
            create: (context) => HomePatientCubit(
              homePatientRepo: getIt.get<HomePatientRepoImpl>(),
            )..getHomePatientData(),
            child: HomePatientView(
              patientModel: state.extra as PatientModel,
            ),
          ),
        ),
      ),
      GoRoute(
        path: kFavoriteView,
        pageBuilder: (context, state) => LeftToRightTransition(
          child: const FavoriteView(),
        ),
      ),
      GoRoute(
        path: kDoctorDetailsView,
        pageBuilder: (context, state) => LeftToRightTransition(
          child: DoctorDetailsView(
            doctorModel: state.extra as DoctorModel,
          ),
        ),
      ),
      GoRoute(
        path: kAddAppointmentView,
        pageBuilder: (context, state) => BottomToTopTransition(
          child: AddAppointmentView(
            doctorModel: state.extra as DoctorModel,
          ),
        ),
      ),
      GoRoute(
        path: kMyAppointmentsView,
        pageBuilder: (context, state) => LeftToRightTransition(
          child: MyAppointmentsView(
            model: state.extra as MyAppointmentsNavigatorModel,
          ),
        ),
      ),
      GoRoute(
        path: kMyConsultationsView,
        pageBuilder: (context, state) => LeftToRightTransition(
          child: const MyConsultationsView(),
        ),
      ),
      GoRoute(
        path: kHomeSecretaryView,
        pageBuilder: (context, state) => LeftToRightTransition(
          child: BlocProvider(
            create: (context) => HomeSecretaryCubit(
              homeSecretaryRepo: getIt.get<HomeSecretaryRepoImpl>(),
            )..firstOpen(
                secretaryModel: state.extra as SecretaryModel,
              ),
            child: HomeSecretaryView(
              secretaryModel: state.extra as SecretaryModel,
            ),
          ),
        ),
      ),
      GoRoute(
        path: kHandleAppointmentView,
        pageBuilder: (context, state) => LeftToRightTransition(
          child: HandleAppointmentView(
            model: state.extra as HandleAppointmentNavigatorModel,
          ),
        ),
      ),
      GoRoute(
        path: kEditAppointmentRequestView,
        pageBuilder: (context, state) => LeftToRightTransition(
          child: EditAppointmentRequestView(
            model: state.extra as HandleAppointmentNavigatorModel,
          ),
        ),
      ),
      GoRoute(
        path: kDoctorView,
        pageBuilder: (context, state) => LeftToRightTransition(
          child: BlocProvider(
            create: (context) => DoctorCubit(
              homeDoctorRepo: getIt.get<HomeDoctorRepoImpl>(),
            )..firstOpen(
                doctorModel: state.extra as DoctorModel,
              ),
            child: DoctorView(
              doctorModel: state.extra as DoctorModel,
            ),
          ),
        ),
      ),
    ],
  );
}
