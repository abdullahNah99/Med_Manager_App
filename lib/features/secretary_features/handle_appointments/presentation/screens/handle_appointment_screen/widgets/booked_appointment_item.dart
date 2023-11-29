import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/size_config.dart';

class BookedAppointmentItem extends StatelessWidget {
  final String time;
  const BookedAppointmentItem({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        String h = time.split(':')[0];
        String m = time.split(':')[1].split(' ')[0];
        log(h);
        log(m);
      },
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: SizeConfig.defaultSize * 14,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 235, 245),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.defaultColor),
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              fontSize: SizeConfig.defaultSize * 2.2,
            ),
          ),
        ),
      ),
    );
  }
}
