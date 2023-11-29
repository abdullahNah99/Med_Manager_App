import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_cubit.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_state.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/screens/widgets/custom_time_button.dart';

class CustomTimesGrid extends StatelessWidget {
  const CustomTimesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    log('CustomTimesGrid build');
    AddAppointmentCubit cubit = BlocProvider.of<AddAppointmentCubit>(context);
    return BlocBuilder<AddAppointmentCubit, AddAppointmentStates>(
      buildWhen: (previous, current) {
        if (current is SelectDateState) {
          if (cubit.selectedDateIndex == 0 && cubit.previousDateIndex == 0) {
            return true;
          } else if (cubit.dates[cubit.selectedDateIndex].EEEE !=
              cubit.dates[cubit.previousDateIndex].EEEE) {
            return true;
          }
        }
        return false;
      },
      builder: (context, state) {
        log('CustomTimesGrid cubit builder');
        return SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: SizeConfig.defaultSize * 6.5,
            mainAxisSpacing: SizeConfig.defaultSize,
            crossAxisSpacing: SizeConfig.defaultSize,
          ),
          itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: 2,
            child: ScaleAnimation(
              duration: const Duration(milliseconds: 900),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                child: CustomTimeButton(
                  index: index,
                  time: cubit.timesBetween[index],
                ),
              ),
            ),
          ),
          itemCount: cubit.timesBetween.length,
        );
      },
    );
  }
}
