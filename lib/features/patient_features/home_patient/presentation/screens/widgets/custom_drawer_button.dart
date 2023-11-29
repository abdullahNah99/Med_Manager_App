import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';

class CustomDrawerButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onTap;
  final Color? iconColor;
  const CustomDrawerButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultSize,
        vertical: SizeConfig.defaultSize,
      ),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromARGB(255, 225, 219, 242),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(25),
          child: Row(
            children: [
              const VerticalSpace(4),
              const HorizintalSpace(3),
              Icon(
                icon,
                color: iconColor ?? AppColors.defaultColor,
                size: SizeConfig.defaultSize * 2.6,
              ),
              const Spacer(flex: 1),
              Text(
                text,
                style: TextStyle(
                  color: AppColors.defaultColor,
                  fontSize: SizeConfig.defaultSize * 2.3,
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
