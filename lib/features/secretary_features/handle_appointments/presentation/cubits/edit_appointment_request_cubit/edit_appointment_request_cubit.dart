import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/repos/handle_appointments_repo.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/cubits/edit_appointment_request_cubit/edit_appointment_request_states.dart';

class EditAppointmentRequestCubit extends Cubit<EditAppointmentRequestStates> {
  final HandleAppointmentsRepo handleAppointmentsRepo;
  EditAppointmentRequestCubit({required this.handleAppointmentsRepo})
      : super(EditAppointmentRequestInitial());
}
