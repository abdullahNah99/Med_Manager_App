import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/models/consultation_model.dart';

class DoctorSection extends StatelessWidget {
  final ConsultationModel consultationModel;
  const DoctorSection({super.key, required this.consultationModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.defaultSize * 6,
      width: SizeConfig.screenWidth * .75,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.defaultColor),
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            GoRouter.of(context).push(
              AppRouter.kDoctorDetailsView,
              extra: consultationModel.doctorModel,
            );
          },
          child: Row(
            children: [
              const HorizintalSpace(.5),
              CustomNetworkImage(
                circleShape: true,
                width: SizeConfig.defaultSize * 5,
                height: SizeConfig.defaultSize * 5,
                iconSize: SizeConfig.defaultSize * 4,
                color: const Color.fromARGB(255, 245, 244, 249),
                imageUrl: consultationModel.doctorModel?.image,
              ),
              const HorizintalSpace(1.5),
              Text(
                'Dr. ${consultationModel.doctorModel?.user.firstName} ${consultationModel.doctorModel?.user.lastName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
