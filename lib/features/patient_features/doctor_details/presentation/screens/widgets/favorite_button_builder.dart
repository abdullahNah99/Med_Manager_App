import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/cubit/doctor_details_cubit.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/cubit/doctor_details_state.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/screens/widgets/doctor_details_button.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class FavoriteButtonBuilder extends StatelessWidget {
  final DoctorModel doctorModel;
  const FavoriteButtonBuilder({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    log('FavoriteButtonBuilder build');
    DoctorDetailsCubit cubit = BlocProvider.of<DoctorDetailsCubit>(context);
    return BlocBuilder<DoctorDetailsCubit, DoctorDetailsStates>(
      buildWhen: (previous, current) => current is ChangeFavoriteState,
      builder: (context, state) {
        log('FavoriteButtonBuilder cubit builder');
        return DoctorDetailsButton(
          icon:
              doctorModel.isFavorited ? Icons.favorite : Icons.favorite_border,
          text: 'Favorite',
          iconColor: Colors.red,
          onTap: () async {
            if (doctorModel.isFavorited) {
              await cubit.deleteFromFavorite(doctor: doctorModel);
            } else {
              await cubit.addToFavorite(doctor: doctorModel);
            }
          },
        );
      },
    );
  }
}
