import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize:
            (fontSize != null) ? (SizeConfig.defaultSize * fontSize!) : (null),
      ),
    );
  }
}
