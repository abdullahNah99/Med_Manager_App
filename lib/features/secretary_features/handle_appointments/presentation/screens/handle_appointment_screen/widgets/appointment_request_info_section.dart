import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_rich_text.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/models/handle_appointment_navigator_model.dart';

class AppointmentRequestInfoSection extends StatelessWidget {
  final HandleAppointmentNavigatorModel model;
  const AppointmentRequestInfoSection({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.5),
      child: CustomRichText(
        numOfTexts: 9,
        textStyle: TextStyle(
          fontSize: SizeConfig.defaultSize * 2,
          color: Colors.black,
          height: 1.5,
        ),
        texts: [
          'Appointment Requset:\n',
          'From:',
          ' ${model.waitingAppointmentModel.patientModel.userModel.firstName} ${model.waitingAppointmentModel.patientModel.userModel.lastName}\n',
          'Date:',
          ' ${model.waitingAppointmentModel.date}\n',
          'Time:',
          ' ${model.waitingAppointmentModel.time}\n',
          'Description:',
          ' ${model.waitingAppointmentModel.description}',
        ],
        styles: [
          TextStyle(
            color: AppColors.defaultColor,
            fontSize: SizeConfig.defaultSize * 2.6,
            fontWeight: FontWeight.w500,
          ),
          const TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
          null,
          const TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
          null,
          const TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
          null,
          const TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
          null,
        ],
      ),
    );
  }
}
