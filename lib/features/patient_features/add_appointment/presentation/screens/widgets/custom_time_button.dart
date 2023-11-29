import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_cubit.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_state.dart';

class CustomTimeButton extends StatelessWidget {
  final int index;
  final String time;
  const CustomTimeButton({
    super.key,
    required this.index,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    log('CustomTimeButton build');
    AddAppointmentCubit cubit = BlocProvider.of<AddAppointmentCubit>(context);
    return BlocBuilder<AddAppointmentCubit, AddAppointmentStates>(
      buildWhen: (previous, current) =>
          current is SelectTimeState &&
          (index == cubit.selectedTimeIndex ||
              index == cubit.previousTimeIndex),
      builder: (context, state) {
        log('CustomTimeButton cubit builder');
        return ElevatedButton(
          onPressed: () {
            cubit.selectTime(index: index);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: index == cubit.selectedTimeIndex ? 2 : 1,
                color: index == cubit.selectedTimeIndex
                    ? Colors.green
                    : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            enableFeedback: false,
          ),
          child: Text(
            time,
            style: TextStyle(
              fontSize: SizeConfig.defaultSize * 2.5,
              color: index == cubit.selectedTimeIndex
                  ? Colors.green
                  : AppColors.defaultColor,
            ),
          ),
        );
      },
    );
  }
}
