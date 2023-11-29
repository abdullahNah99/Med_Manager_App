import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';

class CustomImageSection extends StatelessWidget {
  final String doctorImage;
  final String? departmentImage;
  const CustomImageSection({
    super.key,
    required this.doctorImage,
    this.departmentImage,
  });

  @override
  Widget build(BuildContext context) {
    log('CustomImageSection build');
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomNetworkImage(
          circleShape: true,
          withBorder: true,
          width: SizeConfig.defaultSize * 12,
          height: SizeConfig.defaultSize * 12,
          color: const Color.fromARGB(255, 241, 239, 246),
          imageUrl: doctorImage,
          fit: BoxFit.scaleDown,
        ),
        if (departmentImage != null)
          Positioned(
            left: SizeConfig.defaultSize * 8,
            top: SizeConfig.defaultSize * -1.5,
            child: CustomNetworkImage(
              circleShape: true,
              width: SizeConfig.defaultSize * 4,
              height: SizeConfig.defaultSize * 4,
              imageUrl: departmentImage,
              iconSize: SizeConfig.defaultSize * 3.5,
              withBorder: true,
            ),
          ),
      ],
    );
  }
}
