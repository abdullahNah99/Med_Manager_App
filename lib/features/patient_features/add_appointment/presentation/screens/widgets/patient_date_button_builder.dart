import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_cubit.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_state.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/screens/widgets/custom_date_button.dart';

class PatientDateButtonBuilder extends StatelessWidget {
  final int index;
  final String day;
  final String date;
  const PatientDateButtonBuilder({
    super.key,
    required this.index,
    required this.day,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    log('CustomDateButton build');
    final AddAppointmentCubit cubit =
        BlocProvider.of<AddAppointmentCubit>(context);
    return BlocBuilder<AddAppointmentCubit, AddAppointmentStates>(
      buildWhen: (previous, current) =>
          current is SelectDateState &&
          (index == cubit.selectedDateIndex ||
              index == cubit.previousDateIndex),
      builder: (context, state) {
        log('CustomDateButton cubit builder');
        return CustomDateButton(
          index: index,
          day: day,
          date: date,
          color: index == cubit.selectedDateIndex
              ? Colors.white
              : Colors.grey.withOpacity(.6),
          onTap: () {
            cubit.selectDate(index: index);
          },
          textColor:
              index != cubit.selectedDateIndex ? Colors.white : Colors.black,
        );
      },
    );
  }
}
