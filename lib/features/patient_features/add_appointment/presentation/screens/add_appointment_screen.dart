import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/core/widgets/custom_scaffold.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/data/repos/add_appointment_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_cubit.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/screens/widgets/add_appointment_view_body.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class AddAppointmentView extends StatelessWidget {
  final DoctorModel doctorModel;
  const AddAppointmentView({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAppointmentCubit(
        addAppointmentRepo: getIt.get<AddAppointmentRepoImpl>(),
      )..firstOpen(doctorID: doctorModel.id),
      child: CustomScaffold(
        backgroundColor: AppColors.defaultColor,
        body: AddAppointmentViewBody(doctorModel: doctorModel),
      ),
    );
  }
}
