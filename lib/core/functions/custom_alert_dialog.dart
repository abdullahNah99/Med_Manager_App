import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/app_assets.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_button.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

abstract class CustomAlertDialog {
  static void showCustomAlertDialog(
    BuildContext context, {
    required AddAppointmentCubit cubit,
    required DoctorModel doctorModel,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            Center(
              child: CustomButton(
                text: 'Submit',
                width: SizeConfig.defaultSize * 20,
                onTap: () async {
                  Navigator.pop(context);
                  await cubit.addAppointment(doctorModel: doctorModel);
                },
              ),
            ),
          ],
          content: SizedBox(
            height: SizeConfig.screenHeight * .19,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    const Text(
                      'Warning: You Will Lose 100 From Your Balance When You Submit The Appointment',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
                    const Divider(),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: 'Your Request At ',
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 2,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${cubit.timesBetween[cubit.selectedTimeIndex!]}\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.defaultSize * 2.2,
                            ),
                          ),
                          TextSpan(
                            text: 'in ',
                            style:
                                TextStyle(fontSize: SizeConfig.defaultSize * 2),
                          ),
                          TextSpan(
                            text: cubit.dates[cubit.selectedDateIndex].yMEd,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.defaultSize * 2.2,
                              height: SizeConfig.defaultSize * .15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.defaultSize,
                  ),
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: CustomImage(
                      image: AppAssets.logo,
                    ),
                  ),
                ),
                Positioned(
                  bottom: SizeConfig.defaultSize * 16,
                  left: SizeConfig.defaultSize * 3,
                  right: SizeConfig.defaultSize * 3,
                  child: Container(
                    width: SizeConfig.defaultSize * 10,
                    height: SizeConfig.defaultSize * 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        'Balance: ${cubit.patientModel?.patientWallet}',
                        style: const TextStyle(
                          color: AppColors.defaultColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
