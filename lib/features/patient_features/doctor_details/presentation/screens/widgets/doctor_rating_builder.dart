import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/cubit/doctor_details_cubit.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/cubit/doctor_details_state.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class DoctorRatingBuilder extends StatelessWidget {
  final DoctorModel doctorModel;
  const DoctorRatingBuilder({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    log('DoctorRatingBuilder build');
    return BlocBuilder<DoctorDetailsCubit, DoctorDetailsStates>(
      buildWhen: (previous, current) =>
          current is DoctorDetailsInitial || current is GetDoctorDetailsSuccess,
      builder: (context, state) {
        log('DoctorRatingBuilder cubit builder');
        return Text(
          'Rating: (${doctorModel.review} / 5.0) ⭐️',
          style: TextStyle(
            fontSize: SizeConfig.defaultSize * 1.8,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        );
      },
    );
  }
}
