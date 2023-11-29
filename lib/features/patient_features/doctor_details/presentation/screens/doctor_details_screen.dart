import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/widgets/custom_scaffold.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/data/repo/doctor_details_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/cubit/doctor_details_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';
import 'widgets/doctor_details_view_body.dart';

class DoctorDetailsView extends StatelessWidget {
  final DoctorModel doctorModel;
  const DoctorDetailsView({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    log('DoctorDetailsView build');
    return BlocProvider(
      create: (context) =>
          DoctorDetailsCubit(doctorDetailsRepo: DoctorDetailsRepoImpl())
            ..getDoctorDepartment(
              doctorModel: doctorModel,
            ),
      child: Container(
        color: AppColors.defaultColor,
        child: SafeArea(
          child: CustomScaffold(
            backgroundColor: Colors.white,
            body: DoctorDetailsViewBody(doctorModel: doctorModel),
          ),
        ),
      ),
    );
  }
}
