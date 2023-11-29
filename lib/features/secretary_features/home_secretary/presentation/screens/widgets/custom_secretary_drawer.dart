import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/authentication/data/models/secretary_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/screens/widgets/custom_drawer_button.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_cubit.dart';

class CustomSecretaryDrawer extends StatelessWidget {
  final SecretaryModel secretaryModel;
  const CustomSecretaryDrawer({
    super.key,
    required this.secretaryModel,
  });

  @override
  Widget build(BuildContext context) {
    log('CustomSecretaryDrawer build');
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
                CustomNetworkImage(
                  imageUrl: secretaryModel.departmentModel.image,
                  height: SizeConfig.defaultSize * 12,
                  color: Colors.white,
                  circleShape: true,
                ),
                const VerticalSpace(2),
                Text(
                  '${secretaryModel.departmentModel.name} Department',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: SizeConfig.defaultSize * 2.2,
                  ),
                ),
                const VerticalSpace(2),
              ],
            ),
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
              await BlocProvider.of<HomeSecretaryCubit>(context).logout();
            },
          ),
          const VerticalSpace(3),
        ],
      ),
    );
  }
}
