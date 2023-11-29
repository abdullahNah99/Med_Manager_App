import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_states.dart';

class BalanceTextBuilder extends StatelessWidget {
  const BalanceTextBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    log('BalanceTextBuilder build');
    return BlocBuilder<HomePatientCubit, HomePatientStates>(
      buildWhen: (previous, current) => current is GetPatientDataSuccess,
      builder: (context, state) {
        log('BalanceTextBuilder cubit builder');
        if (state is GetPatientDataSuccess) {
          return Text(
            'Balance: ${state.patientModel.patientWallet}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.defaultSize * 2,
            ),
          );
        }
        return Center(
          child: SizedBox(
            width: SizeConfig.defaultSize * 1.5,
            height: SizeConfig.defaultSize * 1.5,
            child: const CircularProgressIndicator(
              strokeWidth: 1,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
