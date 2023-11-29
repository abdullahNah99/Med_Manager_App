import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/custom_search_delegate.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_cubit.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/widgets/custom_popup_menu_item.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DoctorCubit>(context);
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      itemBuilder: (context) {
        return [
          CustomPopupMenuItem(
            text: 'Search',
            icon: Icons.search,
            iconColor: AppColors.defaultColor,
            onTap: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  searchTerms: cubit.patients,
                ),
              );
            },
          ),
          CustomPopupMenuItem(
            text: 'LogOut',
            icon: Icons.logout,
            iconColor: Colors.red,
            onTap: () async {
              await cubit.logout();
            },
          ),
        ];
      },
    );
  }
}
