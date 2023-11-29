import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class CustomFavoriteIcon extends StatelessWidget {
  final DoctorModel doctorModel;
  final void Function()? onTap;
  const CustomFavoriteIcon({
    super.key,
    required this.doctorModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.defaultSize * .5,
        right: SizeConfig.defaultSize * .5,
      ),
      child: Positioned(
        left: SizeConfig.defaultSize * 15,
        top: SizeConfig.defaultSize * .6,
        child: Material(
          color: Colors.white,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(25),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                doctorModel.isFavorited
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
