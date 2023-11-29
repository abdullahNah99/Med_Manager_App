import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/core/widgets/custom_scaffold.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/navigator_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/repos/my_appointments_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/presentation/cubit/my_appointments_cubit.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/presentation/screens/widgets/my_appointments_view_body.dart';

class MyAppointmentsView extends StatelessWidget {
  final MyAppointmentsNavigatorModel model;
  const MyAppointmentsView({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    log('MyAppointmentsView build');
    return BlocProvider(
      create: (context) => MyAppointmentsCubit(
        myAppointmentsRepo: getIt.get<MyAppointmentsRepoImpl>(),
      )..getMyAppointments(patientID: model.patientID),
      child: CustomScaffold(
        appBar: AppBar(
          title: const Text('My Appointments'),
        ),
        body: MyAppointmentsViewBody(scrollToDownd: model.scrollToDown),
      ),
    );
  }
}
