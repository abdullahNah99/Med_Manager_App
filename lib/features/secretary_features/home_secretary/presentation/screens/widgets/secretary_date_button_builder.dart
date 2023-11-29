import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/screens/widgets/custom_date_button.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_cubit.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_states.dart';

class SecretaryDateButtonBuilder extends StatelessWidget {
  final int index;
  const SecretaryDateButtonBuilder({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    log('SecretaryDateButtonBuilder build');
    final HomeSecretaryCubit cubit =
        BlocProvider.of<HomeSecretaryCubit>(context);
    return BlocBuilder<HomeSecretaryCubit, HomeSecretaryStates>(
      buildWhen: (previous, current) =>
          current is SelectDateState &&
          (index == cubit.selectedDateIndex ||
              index == cubit.previousDateIndex),
      builder: (context, state) {
        log('SecretaryDateButtonBuilder cubit builder');
        return CustomDateButton(
          index: index,
          day: cubit.getDayAndDate(index: index)[0],
          date: '${cubit.getDayAndDate(index: index)[1]} '
              '${cubit.getDayAndDate(index: index)[2]}',
          color: index == cubit.selectedDateIndex
              ? AppColors.defaultColor
              : Colors.grey.withOpacity(.6),
          onTap: () {
            cubit.selectDate(index: index);
          },
          textColor: Colors.white,
        );
      },
    );
  }
}
