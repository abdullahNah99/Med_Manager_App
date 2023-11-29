// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:med_manager_app/core/utils/cache_helper.dart';
// import 'package:med_manager_app/core/utils/service_locator.dart';
// import 'package:med_manager_app/features/doctor_features/features/doctor_consultations/presentation/cubit/doctor_consultations_states.dart';
// import 'package:med_manager_app/features/patient_features/my_consultations/data/models/consultation_model.dart';
// import 'package:med_manager_app/features/patient_features/my_consultations/data/repos/my_consultations_repo_impl.dart';

// class DoctorConsultationsCubit extends Cubit<DoctorConsultationsState> {
//   late final List<ConsultationModel> consultations;
//   DoctorConsultationsCubit() : super(DoctorConsultationsInitial());

//   Future<void> indexDoctorConsultations() async {
//     emit(DoctorConsultationsLoading());
//     (await getIt.get<MyConsultationsRepoImpl>().getMyConsultation(
//               token: await CacheHelper.getData(key: 'Token'),
//             ))
//         .fold(
//       (failure) {
//         emit(DoctorConsultationsFailure(failureMsg: failure.errorMessege));
//       },
//       (consultations) {
//         this.consultations = consultations;
//         emit(DoctorConsultationsSuccess());
//       },
//     );
//   }
// }
