import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_states.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/screens/widgets/custom_department_item.dart';

class DepartmentsList extends StatelessWidget {
  const DepartmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    HomePatientCubit cubit = BlocProvider.of<HomePatientCubit>(context);
    log('DepartmentsList build');
    return BlocBuilder<HomePatientCubit, HomePatientStates>(
      buildWhen: (previous, current) {
        if (current is GetDepartmentsSuccess) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        log('DepartmentsList cubit builder');
        return SizedBox(
          height: SizeConfig.defaultSize * 23,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => CustomDepartmentItem(
              departmentModel: cubit.departments[index],
              index: index,
            ),
            separatorBuilder: (context, index) => const HorizintalSpace(1.5),
            itemCount: cubit.departments.length,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: SizeConfig.defaultSize * .8,
              right: SizeConfig.defaultSize * .8,
              top: SizeConfig.defaultSize * 1.3,
            ),
          ),
        );
      },
    );
  }
}
