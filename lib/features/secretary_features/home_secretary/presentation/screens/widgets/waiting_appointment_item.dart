import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/authentication/data/models/secretary_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/presentation/screens/widgets/custom_image_section.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/data/models/waiting_appointment_model.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_cubit.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/screens/widgets/wating_appointment_info_section.dart';

class WaitingAppointmentItem extends StatelessWidget {
  final WaitingAppointmentModel waitingAppointmentModel;
  final SecretaryModel secretaryModel;
  const WaitingAppointmentItem({
    super.key,
    required this.waitingAppointmentModel,
    required this.secretaryModel,
  });

  @override
  Widget build(BuildContext context) {
    final HomeSecretaryCubit cubit =
        BlocProvider.of<HomeSecretaryCubit>(context);
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.defaultSize),
      child: Stack(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * .18,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                CustomImageSection(
                  doctorImage: waitingAppointmentModel.doctorModel.image,
                ),
                const HorizintalSpace(1),
                WaitingAppointmentInfoSection(
                  waitingAppointmentModel: waitingAppointmentModel,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  GoRouter.of(context).pushReplacement(
                    AppRouter.kHandleAppointmentView,
                    extra: cubit.getNavigatorModel(
                      waitingAppointmentModel: waitingAppointmentModel,
                      secretaryModel: secretaryModel,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
