import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/app_assets.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_arrow_back_button.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';

class DoctorDetailsDesignSection extends StatelessWidget {
  final String doctorImage;
  const DoctorDetailsDesignSection({super.key, required this.doctorImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomImage(
          circleShape: false,
          fit: BoxFit.fill,
          width: SizeConfig.screenWidth * 1,
          height: SizeConfig.screenHeight * .27,
          image: AppAssets.designImg,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomNetworkImage(
            margin: EdgeInsets.only(top: SizeConfig.screenHeight * .16),
            circleShape: true,
            color: const Color.fromARGB(255, 242, 240, 246),
            width: SizeConfig.defaultSize * 19,
            height: SizeConfig.defaultSize * 19,
            imageUrl: doctorImage,
            withBorder: true,
            borderWidth: 3,
            borderColor: Colors.white,
          ),
        ),
        const CustomArrowBackButton(),
      ],
    );
  }
}
