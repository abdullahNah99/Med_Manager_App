import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';

class AppointmentStatusSection extends StatelessWidget {
  final AppointmentModel appointmentModel;
  const AppointmentStatusSection({
    super.key,
    required this.appointmentModel,
  });

  @override
  Widget build(BuildContext context) {
    log('AppointmentStatusSection build');
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontSize: SizeConfig.defaultSize * 2.2,
        ),
        children: [
          const TextSpan(
            text: 'Status: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: appointmentModel.status,
            style: TextStyle(
              color: appointmentModel.status.contains('approve')
                  ? Colors.green
                  : appointmentModel.status.contains('cancel')
                      ? Colors.red
                      : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
