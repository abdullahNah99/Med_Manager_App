import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';

class CustomHandleButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;
  final Color color;
  const CustomHandleButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          SizeConfig.defaultSize * 13,
          SizeConfig.defaultSize * 3,
        ),
        backgroundColor: color,
        elevation: 10,
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
