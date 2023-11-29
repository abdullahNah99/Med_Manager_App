import 'dart:developer';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_cubit.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_states.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/widgets/custom_navigation_bar_item.dart';

class BottomNavigationBarBuilder extends StatelessWidget {
  const BottomNavigationBarBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    log('BottomNavigationBarBuilder build');
    final cubit = BlocProvider.of<DoctorCubit>(context);
    return BlocBuilder<DoctorCubit, DoctorStates>(
      builder: (context, state) {
        log('BottomNavigationBarBuilder cubit builder');
        return CurvedNavigationBar(
          onTap: (index) {
            log(cubit.bottomNavigationBarindex.toString());
            cubit.bottomNavigationBarOnTab(index);
          },
          color: AppColors.defaultColor,
          index: cubit.bottomNavigationBarindex,
          backgroundColor: Colors.white,
          items: List.generate(
            3,
            (index) => CustomNavigationBarItem(index: index),
          ),
        );
      },
    );
  }
}
