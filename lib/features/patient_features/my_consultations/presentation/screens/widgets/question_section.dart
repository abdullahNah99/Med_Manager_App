import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/models/consultation_model.dart';

class QuestionSection extends StatelessWidget {
  final ConsultationModel consultationModel;
  const QuestionSection({super.key, required this.consultationModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Qusetion:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.defaultSize * 2.2,
            decoration: TextDecoration.underline,
            color: AppColors.defaultColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                consultationModel.question,
                overflow:
                    consultationModel.showAnswer ? null : TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2.2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Date: ${consultationModel.questionDate}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const HorizintalSpace(.2),
                  consultationModel.answer == 'null'
                      ? const Icon(
                          Icons.remove_done_rounded,
                          color: Colors.orange,
                        )
                      : const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
