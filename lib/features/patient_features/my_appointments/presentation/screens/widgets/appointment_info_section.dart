import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';

class AppointmentInfoSection extends StatelessWidget {
  final AppointmentModel appointmentModel;
  const AppointmentInfoSection({
    super.key,
    required this.appointmentModel,
  });

  @override
  Widget build(BuildContext context) {
    log('AppointmentInfoSection build');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  text: 'To Dr. ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text: '${appointmentModel.doctorModel!.user.firstName} '),
                TextSpan(text: appointmentModel.doctorModel!.user.lastName),
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
              TextSpan(text: appointmentModel.time),
            ],
          ),
        ),
        const VerticalSpace(1),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: SizeConfig.defaultSize *
                  (appointmentModel.date.length > 15 ? 2 : 2.2),
            ),
            children: [
              const TextSpan(
                text: 'Date: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: appointmentModel.date),
            ],
          ),
        ),
      ],
    );
  }
}
