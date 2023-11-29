import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';

class DoctorDetailsButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final void Function() onTap;
  const DoctorDetailsButton({
    super.key,
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: SizeConfig.defaultSize * 10,
        height: SizeConfig.defaultSize * 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: SizeConfig.defaultSize * 4,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.grey,
                fontSize: text.length > 11
                    ? SizeConfig.defaultSize * 1.7
                    : SizeConfig.defaultSize * 2,
              ),
            ),
            const Divider(
              thickness: 1.5,
              endIndent: 6,
              indent: 6,
            ),
          ],
        ),
      ),
    );
  }
}
