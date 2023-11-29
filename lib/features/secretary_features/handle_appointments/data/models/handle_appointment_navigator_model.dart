import 'package:med_manager_app/features/authentication/data/models/secretary_model.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/models/work_day_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/cubits/handle_appointment_cubit/handle_appointments_cubit.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/data/models/waiting_appointment_model.dart';

class HandleAppointmentNavigatorModel {
  final WaitingAppointmentModel waitingAppointmentModel;
  final List<WorkDayModel> doctorWorkDays;
  final SecretaryModel secretaryModel;
  final List<AppointmentModel> approvedAppointments;
  HandleAppointmentsCubit? cubit;

  HandleAppointmentNavigatorModel({
    required this.waitingAppointmentModel,
    required this.doctorWorkDays,
    required this.secretaryModel,
    required this.approvedAppointments,
    this.cubit,
  });

  // @override
  // List<Object> get props => [
  //       waitingAppointmentModel,
  //       doctorWorkDays,
  //       secretaryModel,
  //       approvedAppointments,
  //     ];
}
