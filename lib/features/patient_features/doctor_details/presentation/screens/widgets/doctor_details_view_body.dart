import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/functions/custom_progress_indicator.dart';
import 'package:med_manager_app/core/functions/custom_snack_bar.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/cubit/doctor_details_cubit.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/cubit/doctor_details_state.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/screens/widgets/buttons_section.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/screens/widgets/doctor_department_image.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/screens/widgets/doctor_description_section.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/screens/widgets/doctor_details_design_section.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/screens/widgets/doctor_rating_builder.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class DoctorDetailsViewBody extends StatelessWidget {
  final DoctorModel doctorModel;
  const DoctorDetailsViewBody({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    log('DoctorDetailsViewBody build');
    return BlocConsumer<DoctorDetailsCubit, DoctorDetailsStates>(
      listener: (context, state) {
        if (state is DoctorDetailsLoading &&
            !(CustomProgressIndicator.isOpen)) {
          CustomProgressIndicator.showProgressIndicator(context);
        }
        if (state is! DoctorDetailsLoading) {
          if (CustomProgressIndicator.isOpen) {
            Navigator.pop(context);
          }
          if (state is DoctorDetailsFailure) {
            CustomSnackBar.showErrorSnackBar(context,
                message: state.failureMsg);
          } else if (state is RatingDoctorSuccess) {
            CustomSnackBar.showCustomSnackBar(context, message: state.message);
          } else if (state is ChangeFavoriteState) {
            CustomSnackBar.showCustomSnackBar(
              context,
              message: state.message,
              backgroundColor:
                  state.message.contains('delete') ? Colors.orange : null,
            );
          } else if (state is SendQuestionSeccess) {
            Navigator.pop(context);
            BlocProvider.of<DoctorDetailsCubit>(context).question = null;
            CustomSnackBar.showCustomSnackBar(
              context,
              message: state.message,
            );
          }
        }
      },
      buildWhen: (previous, current) => current is DoctorDetailsInitial,
      builder: (context, state) {
        log('DoctorDetailsViewBody cubit builder');
        return SingleChildScrollView(
          child: Column(
            children: [
              DoctorDetailsDesignSection(doctorImage: doctorModel.image),
              const VerticalSpace(1),
              Text(
                'Dr. ${doctorModel.user.firstName} ${doctorModel.user.lastName}',
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: SizeConfig.defaultSize * 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(flex: 2),
                    const DoctorDepartmentImage(),
                    const HorizintalSpace(1),
                    Text(
                      '${doctorModel.specialty} Doctor',
                      style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.6,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
              DoctorRatingBuilder(doctorModel: doctorModel),
              const VerticalSpace(2),
              DoctorDetailsButtonsSection(doctorModel: doctorModel),
              const VerticalSpace(2),
              DoctorDescriptionSection(description: doctorModel.description),
              const VerticalSpace(2),
            ],
          ),
        );
      },
    );
  }
}
