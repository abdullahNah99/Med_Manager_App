import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/utils/app_assets.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class CustomDoctorItem extends StatelessWidget {
  final DoctorModel doctorModel;
  final int index;
  final Widget favoriteIcon;
  const CustomDoctorItem({
    super.key,
    required this.doctorModel,
    required this.index,
    required this.favoriteIcon,
  });

  @override
  Widget build(BuildContext context) {
    log('Custom Doctor Item build');
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.defaultSize * .7,
        right: SizeConfig.defaultSize * .7,
        bottom: SizeConfig.defaultSize,
        top: SizeConfig.defaultSize,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: const Color.fromARGB(255, 237, 235, 243),
            borderRadius: BorderRadius.circular(20),
            elevation: 5,
            child: Container(
              width: SizeConfig.defaultSize * 19.5,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(.3),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomNetworkImage(
                    height: SizeConfig.defaultSize * 15.5,
                    width: SizeConfig.defaultSize * 15.5,
                    circleShape: true,
                    color: Colors.white,
                    imageUrl: doctorModel.image,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  const Divider(
                    indent: 7,
                    endIndent: 7,
                  ),
                  Center(
                    child: SizedBox(
                      width: SizeConfig.defaultSize * 16,
                      height: SizeConfig.defaultSize * 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dr. ${doctorModel.user.firstName} ${doctorModel.user.lastName}',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.defaultSize * 1.5,
                            ),
                          ),
                          Text(
                            '${doctorModel.specialty} Doctor',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            'Rating (${doctorModel.review} / 5.0) ⭐️',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.defaultSize * 5,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomImage(
                image: AppAssets.logo,
                width: SizeConfig.defaultSize * 6,
                height: SizeConfig.defaultSize * 6,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: SizedBox(
              width: SizeConfig.defaultSize * 19.5,
              child: InkWell(
                highlightColor: AppColors.defaultColor.withOpacity(.2),
                splashColor: AppColors.defaultColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  await GoRouter.of(context).push(
                    AppRouter.kDoctorDetailsView,
                    extra: doctorModel,
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: favoriteIcon,
          ),
          // FavoriteIconBuilder(doctorModel: doctorModel),
        ],
      ),
    );
  }
}
