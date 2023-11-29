import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_arrow_back_button.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class CustomAppBar extends StatelessWidget {
  final DoctorModel doctorModel;
  const CustomAppBar({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    log('CustomAppBar build');
    return Row(
      children: [
        const HorizintalSpace(1),
        const CustomArrowBackButton(
          padding: EdgeInsets.only(right: 2),
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'Add Appointment',
              textAlign: TextAlign.center,
              // maxLines: 1,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.defaultSize * 2.6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: SizedBox(
            height: SizeConfig.defaultSize * 5,
            width: SizeConfig.defaultSize * 9,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CustomNetworkImage(
                  imageUrl: doctorModel.image,
                  circleShape: true,
                  color: Colors.white,
                  width: SizeConfig.defaultSize * 5,
                  iconSize: SizeConfig.defaultSize * 4,
                ),
                Positioned(
                  left: SizeConfig.defaultSize * 4,
                  bottom: SizeConfig.defaultSize * -2.5,
                  child: CustomNetworkImage(
                    imageUrl: doctorModel.departmentImg,
                    circleShape: true,
                    color: Colors.white,
                    width: SizeConfig.defaultSize * 5,
                    iconSize: SizeConfig.defaultSize * 4,
                  ),
                ),
              ],
            ),
          ),
        ),
        const HorizintalSpace(1),
      ],
    );
  }
}
