import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/features/patient_features/favorite/presentation/screens/widgets/custom_favorite_icon.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_states.dart';

class HomeFavoriteIconBuilder extends StatelessWidget {
  final DoctorModel doctorModel;
  final int index;
  const HomeFavoriteIconBuilder({
    super.key,
    required this.doctorModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    log('HomeFavoriteIconBuilder build');
    HomePatientCubit cubit = BlocProvider.of<HomePatientCubit>(context);
    return BlocBuilder<HomePatientCubit, HomePatientStates>(
      buildWhen: (previous, current) =>
          current is ChangeFavoriteState && current.index == index,
      builder: (context, state) {
        log('HomeFavoriteIconBuilder cubit builder');
        return CustomFavoriteIcon(
          doctorModel: doctorModel,
          onTap: () async {
            if (doctorModel.isFavorited) {
              await cubit.deleteFromFavorite(
                doctor: doctorModel,
                index: index,
              );
            } else {
              await cubit.addToFavorite(
                doctor: doctorModel,
                index: index,
              );
            }
          },
        );
      },
    );
  }
}
