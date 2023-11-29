import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/department_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_states.dart';

class CustomDepartmentItem extends StatelessWidget {
  final DepartmentModel departmentModel;
  final int index;
  const CustomDepartmentItem({
    super.key,
    required this.departmentModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    log('CustomDepartmentItem build');
    HomePatientCubit cubit = BlocProvider.of<HomePatientCubit>(context);
    return BlocBuilder<HomePatientCubit, HomePatientStates>(
      buildWhen: (previous, current) {
        if (current is SelectDepartmentState &&
            (index == cubit.selectedDepartmentIndex ||
                index == cubit.previousDepartmentIndex)) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        log('CustomDepartmentItem cubit builder');
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              color: const Color.fromARGB(255, 237, 235, 243),
              borderRadius: BorderRadius.circular(20),
              elevation: 10,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  cubit.selectDepartmentItem(index: index);
                },
                child: Container(
                  width: SizeConfig.defaultSize * 20,
                  height: SizeConfig.defaultSize * 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: index == cubit.selectedDepartmentIndex ? 2.4 : 1,
                      color: index == cubit.selectedDepartmentIndex
                          ? Colors.green.withOpacity(.7)
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomNetworkImage(
                        height: SizeConfig.defaultSize * 12,
                        width: SizeConfig.defaultSize * 12,
                        color: Colors.transparent,
                        imageUrl: departmentModel.image,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                      ),
                      const Divider(
                        indent: 7,
                        endIndent: 7,
                      ),
                      Center(
                        child: SizedBox(
                          width: SizeConfig.defaultSize * 12,
                          // height: SizeConfig.defaultSize! * 6,
                          child: Center(
                            child: Text(
                              departmentModel.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: departmentModel.name.length < 12
                                    ? SizeConfig.defaultSize * 1.8
                                    : SizeConfig.defaultSize * 1.4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: index == cubit.selectedDepartmentIndex,
              child: Positioned(
                left: SizeConfig.defaultSize * 18,
                top: SizeConfig.defaultSize * -.4,
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
