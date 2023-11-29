import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/data/models/waiting_appointment_model.dart';

class WaitingAppointmentInfoSection extends StatelessWidget {
  final WaitingAppointmentModel waitingAppointmentModel;
  const WaitingAppointmentInfoSection({
    super.key,
    required this.waitingAppointmentModel,
  });

  @override
  Widget build(BuildContext context) {
    log('WaitingAppointmentInfoSection build');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: SizeConfig.defaultSize * 22,
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.defaultSize * 2.2,
              ),
              children: [
                const TextSpan(
                  text: 'From: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text:
                        '${waitingAppointmentModel.patientModel.userModel.firstName} '),
                TextSpan(
                  text: waitingAppointmentModel.patientModel.userModel.lastName,
                ),
              ],
            ),
          ),
        ),
        const VerticalSpace(1),
        SizedBox(
          width: SizeConfig.defaultSize * 22,
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.defaultSize * 2.2,
              ),
              children: [
                const TextSpan(
                  text: 'To Dr. ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text:
                        '${waitingAppointmentModel.doctorModel.user.firstName} '),
                TextSpan(
                  text: waitingAppointmentModel.doctorModel.user.lastName,
                ),
              ],
            ),
          ),
        ),
        const VerticalSpace(1),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: SizeConfig.defaultSize * 2.2,
            ),
            children: [
              const TextSpan(
                text: 'Time: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: waitingAppointmentModel.time),
            ],
          ),
        ),
      ],
    );
  }
}
