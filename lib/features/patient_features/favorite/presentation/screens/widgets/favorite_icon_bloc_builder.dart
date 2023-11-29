import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/features/patient_features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:med_manager_app/features/patient_features/favorite/presentation/cubit/favorite_state.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';
import 'custom_favorite_icon.dart';

class FavoriteIconBuilder extends StatelessWidget {
  final DoctorModel doctorModel;
  const FavoriteIconBuilder({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    FavoriteCubit cubit = BlocProvider.of<FavoriteCubit>(context);
    return BlocBuilder<FavoriteCubit, FavoriteStates>(
      builder: (context, state) {
        return CustomFavoriteIcon(
          doctorModel: doctorModel,
          onTap: () async {
            if (doctorModel.isFavorited) {
              await cubit.deleteFromFavorite(doctorModel: doctorModel);
            }
          },
        );
      },
    );
  }
}
