import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';

class BottomSheetTopContainer extends StatelessWidget {
  const BottomSheetTopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.defaultSize * .5,
      width: SizeConfig.defaultSize * 5,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
