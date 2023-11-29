import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/cache_helper.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/models/consultation_model.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/repos/my_consultations_repo.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/presentation/cubit/my_consultations_states.dart';

class MyConsultationsCubit extends Cubit<MyConsultationsStates> {
  final MyConsultationsRepo myConsultationsRepo;
  int? tappedConsultationIndex;
  List<ConsultationModel> myConsultations = [];
  double? animatedContainerHeight = SizeConfig.defaultSize * 16;
  MyConsultationsCubit({required this.myConsultationsRepo})
      : super(MyConsultationsInitial());

  Future<void> getMyConsultations() async {
    emit(MyConsultationsLoading());
    (await myConsultationsRepo.getMyConsultation(
      token: await CacheHelper.getData(key: 'Token'),
    ))
        .fold(
      (failure) {
        emit(MyConsultationsFailure(failureMsg: failure.errorMessege));
      },
      (myConsultations) {
        this.myConsultations = myConsultations;
        emit(MyConsultationsSuccess());
      },
    );
  }

  void showAnswer({required ConsultationModel consultationModel}) {
    if (consultationModel.showAnswer) {
      animatedContainerHeight = null;
    } else {
      animatedContainerHeight = SizeConfig.defaultSize * 16;
    }
    consultationModel.showAnswer = !consultationModel.showAnswer;
    emit(ShowAnswerState());
  }
}
