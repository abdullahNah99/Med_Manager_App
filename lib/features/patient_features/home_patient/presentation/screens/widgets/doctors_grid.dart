import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_states.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/screens/widgets/home_favorite_icon_builder.dart';
import 'custom_doctor_item.dart';

class DoctorsGrid extends StatelessWidget {
  const DoctorsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    log('DoctorsGrid build');
    HomePatientCubit cubit = BlocProvider.of<HomePatientCubit>(context);
    return BlocBuilder<HomePatientCubit, HomePatientStates>(
      buildWhen: (previous, current) {
        if (current is GetDoctorsSuccess) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        log('DoctorsGrid cubit builder');
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) => AnimationConfiguration.staggeredGrid(
              columnCount: 2,
              position: index,
              duration: const Duration(milliseconds: 500),
              child: ScaleAnimation(
                duration: const Duration(milliseconds: 900),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  child: CustomDoctorItem(
                    doctorModel: cubit.doctors[index],
                    index: index,
                    favoriteIcon: HomeFavoriteIconBuilder(
                      doctorModel: cubit.doctors[index],
                      index: index,
                    ),
                  ),
                ),
              ),
            ),
            childCount: cubit.doctors.length,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: SizeConfig.defaultSize * 30,
          ),
        );
      },
    );
  }
}
