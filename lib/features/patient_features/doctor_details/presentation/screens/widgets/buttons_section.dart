import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/functions/custom_bottom_sheet.dart';
import 'package:med_manager_app/core/functions/custom_rating_dialog.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_button.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/cubit/doctor_details_cubit.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/screens/widgets/doctor_details_button.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/screens/widgets/favorite_button_builder.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class DoctorDetailsButtonsSection extends StatelessWidget {
  final DoctorModel doctorModel;
  const DoctorDetailsButtonsSection({
    super.key,
    required this.doctorModel,
  });

  @override
  Widget build(BuildContext context) {
    DoctorDetailsCubit cubit = BlocProvider.of<DoctorDetailsCubit>(context);
    log('DoctorDetailsButtonsSection build');
    return Column(
      children: [
        CustomButton(
          text: 'Book Appointment',
          width: SizeConfig.screenWidth * .85,
          borderRadius: 10,
          onTap: () {
            if (cubit.doctorDepartmentImg != null) {
              GoRouter.of(context).push(
                AppRouter.kAddAppointmentView,
                extra: doctorModel,
              );
            }
          },
        ),
        const VerticalSpace(2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DoctorDetailsButton(
              icon: Icons.star,
              text: 'Rating',
              iconColor: Colors.yellow.shade700,
              onTap: () {
                CustomRatingDialog.showRatingDialog(
                  context,
                  onRating: (value) {
                    cubit.ratingValue = value;
                  },
                  onSubmitting: () async {
                    Navigator.pop(context);
                    await cubit.ratingDoctor(
                      doctorModel: doctorModel,
                    );
                  },
                );
              },
            ),
            const CustomVerticalDivider(),
            FavoriteButtonBuilder(doctorModel: doctorModel),
            const CustomVerticalDivider(),
            DoctorDetailsButton(
              icon: Icons.question_answer,
              text: 'Consultation',
              iconColor: AppColors.defaultColor,
              onTap: () {
                CustomBottomSheet.showConsultationBottomSheet(
                  context,
                  doctorModel: doctorModel,
                  cubit: cubit,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.withOpacity(.3)),
      height: SizeConfig.defaultSize * 7,
      width: 1,
    );
  }
}
