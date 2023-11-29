import 'package:flutter/widgets.dart';
import 'package:med_manager_app/core/utils/size_config.dart';

class DoctorDescriptionSection extends StatelessWidget {
  final String description;
  const DoctorDescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Doctor:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.defaultSize * 2),
            ),
            Text(description),
          ],
        ),
      ),
    );
  }
}
