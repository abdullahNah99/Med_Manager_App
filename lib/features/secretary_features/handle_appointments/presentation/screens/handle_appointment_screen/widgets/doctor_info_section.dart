import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/models/handle_appointment_navigator_model.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/cubits/handle_appointment_cubit/handle_appointments_cubit.dart';

class DoctorInfoSection extends StatelessWidget {
  final HandleAppointmentNavigatorModel model;
  const DoctorInfoSection({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final HandleAppointmentsCubit cubit =
        BlocProvider.of<HandleAppointmentsCubit>(context);
    return Stack(
      children: [
        AnimationConfiguration.synchronized(
          child: ScaleAnimation(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastEaseInToSlowEaseOut,
            child: Container(
              height: SizeConfig.screenHeight * .14,
              padding: EdgeInsets.all(SizeConfig.defaultSize),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 234, 249),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomNetworkImage(
                    imageUrl: model.waitingAppointmentModel.doctorModel.image,
                    circleShape: true,
                    iconSize: SizeConfig.defaultSize * 7,
                    color: Colors.white,
                  ),
                  const HorizintalSpace(2),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              'Dr. ${model.waitingAppointmentModel.doctorModel.user.firstName} '
                              '${model.waitingAppointmentModel.doctorModel.user.lastName}\n'
                              'Available in ${cubit.workDayModel!.day}\n'
                              'From: ${cubit.workDayModel!.statrtTime}\n'
                              'To: ${cubit.workDayModel!.endTime}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}
