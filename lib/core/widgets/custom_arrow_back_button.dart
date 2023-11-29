import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';

class CustomArrowBackButton extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;
  const CustomArrowBackButton({
    super.key,
    this.padding,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.topLeft,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shape: const CircleBorder(),
            padding: EdgeInsets.only(
              left: SizeConfig.defaultSize * .8,
            ),
            minimumSize: Size(
              SizeConfig.defaultSize * 4.3,
              SizeConfig.defaultSize * 4.3,
            ),
          ),
          onPressed: onPressed ??
              () {
                Navigator.pop(context);
              },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }
}
