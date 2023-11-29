import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/cubit/doctor_details_cubit.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/cubit/doctor_details_state.dart';

class DoctorDepartmentImage extends StatelessWidget {
  const DoctorDepartmentImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDetailsCubit, DoctorDetailsStates>(
      buildWhen: (previous, current) => current is GetDoctorDepartmentSuccess,
      builder: (context, state) {
        if (state is DoctorDetailsLoading) {
          return SizedBox(
            width: SizeConfig.defaultSize * 1.5,
            height: SizeConfig.defaultSize * 1.5,
            child: const CircularProgressIndicator(
              strokeWidth: 1,
            ),
          );
        } else {
          return CustomNetworkImage(
            circleShape: true,
            width: SizeConfig.defaultSize * 4,
            imageUrl: BlocProvider.of<DoctorDetailsCubit>(context)
                .doctorDepartmentImg,
          );
        }
      },
    );
  }
}
