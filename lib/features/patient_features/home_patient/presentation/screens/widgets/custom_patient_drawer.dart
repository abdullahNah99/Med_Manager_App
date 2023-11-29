import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/screens/widgets/balance_text_builder.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/screens/widgets/custom_drawer_button.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/navigator_model.dart';

class CustomPatientDrawer extends StatelessWidget {
  final PatientModel patientModel;
  const CustomPatientDrawer({super.key, required this.patientModel});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: SizeConfig.defaultSize * 30,
            decoration: const BoxDecoration(
              color: AppColors.defaultColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const VerticalSpace(5),
                CustomImage(
                  height: SizeConfig.defaultSize * 12,
                  color: Colors.white,
                  circleShape: true,
                ),
                const VerticalSpace(2),
                Text(
                  '${patientModel.userModel.firstName}'
                  ' ${patientModel.userModel.firstName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 3,
                    color: Colors.white,
                  ),
                ),
                const VerticalSpace(2),
                const BalanceTextBuilder(),
              ],
            ),
          ),
          const VerticalSpace(5),
          CustomDrawerButton(
            icon: Icons.favorite,
            text: 'Favorite',
            onTap: () {
              GoRouter.of(context).push(
                AppRouter.kFavoriteView,
                extra: BlocProvider.of<HomePatientCubit>(context),
              );
            },
          ),
          CustomDrawerButton(
            icon: Icons.question_answer_rounded,
            text: 'Consultations',
            onTap: () {
              GoRouter.of(context).push(AppRouter.kMyConsultationsView);
            },
          ),
          CustomDrawerButton(
            icon: Icons.date_range_outlined,
            text: 'Appointments',
            onTap: () {
              GoRouter.of(context).push(
                AppRouter.kMyAppointmentsView,
                extra: MyAppointmentsNavigatorModel(
                  patientID: patientModel.id,
                ),
              );
            },
          ),
          const Expanded(
            child: VerticalSpace(1),
          ),
          CustomDrawerButton(
            icon: Icons.logout,
            iconColor: Colors.red,
            text: 'Log Out',
            onTap: () async {
              Scaffold.of(context).closeDrawer();
              await BlocProvider.of<HomePatientCubit>(context).logout();
            },
          ),
          const VerticalSpace(3),
        ],
      ),
    );
  }
}
