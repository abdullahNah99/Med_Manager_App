import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_scaffold.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/models/handle_appointment_navigator_model.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/repos/handle_appointments_repo_impl.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/cubits/edit_appointment_request_cubit/edit_appointment_request_cubit.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/screens/edit_appointment_request_screen/widgets/edit_appointment_request_view_body.dart';

class EditAppointmentRequestView extends StatelessWidget {
  final HandleAppointmentNavigatorModel model;

  const EditAppointmentRequestView({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAppointmentRequestCubit(
        handleAppointmentsRepo: getIt.get<HandleAppointmentsRepoImpl>(),
      ),
      child: CustomScaffold(
        appBar: AppBar(
          title: const Text('Edit Appointment Request'),
          titleTextStyle: TextStyle(
            fontSize: SizeConfig.defaultSize * 2.3,
          ),
        ),
        body: EditAppointmentRequestViewBody(
          model: model,
        ),
      ),
    );
  }
}
