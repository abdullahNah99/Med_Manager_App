import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/presentation/cubit/my_appointments_cubit.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/presentation/screens/widgets/appointment_info_section.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/presentation/screens/widgets/appointment_status_section.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/presentation/screens/widgets/custom_image_section.dart';

class MyAppointmentItem extends StatelessWidget {
  final int index;
  final AppointmentModel appointmentModel;
  final bool scrollToDown;
  const MyAppointmentItem({
    super.key,
    required this.appointmentModel,
    required this.scrollToDown,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    MyAppointmentsCubit cubit = BlocProvider.of<MyAppointmentsCubit>(context);
    log('MyAppointmentItem build');
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
            color: (index == cubit.myAppointments.length - 1 && scrollToDown)
                ? cubit.containerColor
                : Colors.white,
          ),
          child: Row(
            children: [
              CustomImageSection(
                doctorImage: appointmentModel.doctorModel!.image,
                departmentImage: appointmentModel.departmentModel?.image,
              ),
              const HorizintalSpace(1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppointmentInfoSection(appointmentModel: appointmentModel),
                  const VerticalSpace(1),
                  AppointmentStatusSection(appointmentModel: appointmentModel),
                ],
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              autofocus: true,
              enableFeedback: true,
              excludeFromSemantics: true,
              canRequestFocus: true,
              onFocusChange: (value) {
                if (scrollToDown && cubit.enableScroll) {
                  cubit.scrollToDown();
                }
              },
              onTap: () {
                // log('ccccccc');
                cubit.updateContainerColor();
              },
              splashColor: AppColors.defaultColor.withOpacity(.3),
              highlightColor: AppColors.defaultColor.withOpacity(.3),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        if (appointmentModel.status == 'waiting')
          Positioned(
            left: SizeConfig.screenWidth * .86,
            top: SizeConfig.defaultSize * -1,
            child: Material(
              color: Colors.red,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () async {
                  await BlocProvider.of<MyAppointmentsCubit>(context)
                      .deleteAppointment(
                    id: appointmentModel.id,
                    patientID: appointmentModel.patientID,
                  );
                },
                borderRadius: BorderRadius.circular(100),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
