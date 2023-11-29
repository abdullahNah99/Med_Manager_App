import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/cache_helper.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/repos/my_appointments_repo.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/presentation/cubit/my_appointments_states.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsStates> {
  final MyAppointmentsRepo myAppointmentsRepo;
  final ScrollController scrollController = ScrollController();
  List<AppointmentModel> myAppointments = [];
  bool enableScroll = true;
  Color containerColor = Colors.green.withOpacity(.7);
  MyAppointmentsCubit({required this.myAppointmentsRepo})
      : super(MyAppointmentsInitial());

  Future<void> getMyAppointments({required patientID}) async {
    emit(MyAppointmentsLoading());
    (await myAppointmentsRepo.getMyApointments(
      token: await CacheHelper.getData(key: 'Token'),
      patientID: patientID,
    ))
        .fold(
      (failure) {
        emit(MyAppointmentsFailure(failureMsg: failure.errorMessege));
      },
      (myAppointments) {
        this.myAppointments = myAppointments;
        emit(MyAppointmentsSuccess());
      },
    );
  }

  Future<void> deleteAppointment({
    required int id,
    required int patientID,
  }) async {
    emit(MyAppointmentsLoading());
    (await myAppointmentsRepo.deleteAppointment(
      token: await CacheHelper.getData(key: 'Token'),
      id: id,
    ))
        .fold(
      (failure) {
        emit(MyAppointmentsFailure(failureMsg: failure.errorMessege));
      },
      (success) async {
        await getMyAppointments(patientID: patientID);
        emit(DeleteAppointmentSuccess(message: success));
      },
    );
  }

  void scrollToDown() {
    if (scrollController.hasClients) {
      enableScroll = false;
      scrollController
          .animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(seconds: 1),
            curve: Curves.ease,
          )
          .then(
            (value) => updateContainerColor(),
          );
    }
  }

  void updateContainerColor() {
    containerColor = Colors.white;
    emit(UpdateColorState());
  }

  @override
  Future<void> close() {
    log('closedddddddddddddddddddddd');
    scrollController.dispose();
    return super.close();
  }
}
