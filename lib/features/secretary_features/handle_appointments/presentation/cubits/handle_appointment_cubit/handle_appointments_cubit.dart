import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/cache_helper.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/models/work_day_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/models/handle_appointment_navigator_model.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/repos/handle_appointments_repo.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/cubits/handle_appointment_cubit/handle_appointments_states.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/data/models/waiting_appointment_model.dart';

class HandleAppointmentsCubit extends Cubit<HandleAppointmentsStates> {
  final HandleAppointmentsRepo handleAppointmentsRepo;
  final formKey = GlobalKey<FormState>();
  bool listener = false;
  WorkDayModel? workDayModel;
  // List<BookedAppointmentsModel> bookedAppointments = [];
  // bool showHeader = false;
  String? cancelReason;
  HandleAppointmentsCubit({required this.handleAppointmentsRepo})
      : super(HandleAppointmentsInitial());

  // Future<void> getBookedAppointments({required int appointmentID}) async {
  //   emit(HandleAppointmentsLoading());
  //   (await handleAppointmentsRepo.getBookedAppointments(
  //     token: await CacheHelper.getData(key: 'Token'),
  //     appointmentID: appointmentID,
  //   ))
  //       .fold(
  //     (failure) {
  //       emit(HandleAppointmentsFailure(failureMsg: failure.errorMessege));
  //     },
  //     (bookedAppointments) {
  //       this.bookedAppointments = bookedAppointments;
  //       showHeader = true;
  //       emit(GetBookedAppointmentsSuccess());
  //     },
  //   );
  // }

  Future<void> approveAppointment({required int appointmentID}) async {
    emit(HandleAppointmentsLoading());
    (await handleAppointmentsRepo.approveAppointment(
      token: await CacheHelper.getData(key: 'Token'),
      appointmentID: appointmentID,
    ))
        .fold(
      (failure) {
        // emit(HandleAppointmentsFailure(failureMsg: failure.errorMessege));
        emit(ApproveAppointmentSuccess());
      },
      (success) {
        emit(ApproveAppointmentSuccess());
      },
    );
  }

  Future<void> cancelAppointment({required int appointmentID}) async {
    emit(HandleAppointmentsLoading());
    (await handleAppointmentsRepo.cancelAppointment(
      token: await CacheHelper.getData(key: 'Token'),
      appointmentID: appointmentID,
      cancelReason: cancelReason!,
    ))
        .fold(
      (failure) {
        // emit(HandleAppointmentsFailure(failureMsg: failure.errorMessege));
        emit(CancelAppointmentSuccess());
      },
      (success) {
        emit(CancelAppointmentSuccess());
      },
    );
  }

  String getInitialCancelReason({
    required WaitingAppointmentModel waitingAppointmentModel,
  }) {
    return 'Dr. ${waitingAppointmentModel.doctorModel.user.firstName} '
        '${waitingAppointmentModel.doctorModel.user.lastName} '
        'is not available in ${waitingAppointmentModel.date}.\n'
        'Please choose another day...';
  }

  List<AppointmentModel> sortTimes({required List<AppointmentModel> times}) {
    List<AppointmentModel> list = [];
    for (AppointmentModel item in times) {
      list.add(item);
    }
    list.sort(
      (a, b) => a.compareTwoTimes(time: b.time),
    );
    return list;
  }

  void getWorkDayModel({
    required HandleAppointmentNavigatorModel model,
  }) {
    int doctorID = model.waitingAppointmentModel.doctorID;
    String day = model.waitingAppointmentModel.date.split(' ')[0];
    for (WorkDayModel item in model.doctorWorkDays) {
      if (item.doctorID == doctorID && item.day == day) {
        workDayModel = item;
      }
    }
  }
}
