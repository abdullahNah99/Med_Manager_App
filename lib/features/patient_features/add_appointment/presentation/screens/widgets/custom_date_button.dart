import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';

class CustomDateButton extends StatelessWidget {
  final int index;
  final String day;
  final String date;
  final Color color, textColor;
  final void Function() onTap;
  const CustomDateButton({
    super.key,
    required this.index,
    required this.day,
    required this.date,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final AddAppointmentCubit cubit =
    //     BlocProvider.of<AddAppointmentCubit>(context);
    return SizedBox(
      width: SizeConfig.defaultSize * 14,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    color: textColor,
                    fontSize: day.length < 9
                        ? SizeConfig.defaultSize * 2.4
                        : SizeConfig.defaultSize * 2,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: textColor,
                    fontSize: SizeConfig.defaultSize * 1.8,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
