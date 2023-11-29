import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/models/consultation_model.dart';

class AnswerSection extends StatelessWidget {
  final ConsultationModel consultationModel;
  const AnswerSection({
    super.key,
    required this.consultationModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Answer:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.defaultSize * 2.2,
            decoration: TextDecoration.underline,
            color: AppColors.defaultColor,
          ),
        ),
        // Row(
        //   children: [
        //     CustomNetworkImage(
        //       circleShape: true,
        //       width: SizeConfig.defaultSize! * 5,
        //       height: SizeConfig.defaultSize! * 5,
        //       iconSize: SizeConfig.defaultSize! * 4,
        //       color: Colors.white,
        //       imageUrl: consultationModel.doctorModel.image,
        //     ),
        //     const HorizintalSpace(1),
        //     Text(
        //       'Dr. ${consultationModel.doctorModel.user.firstName} ${consultationModel.doctorModel.user.lastName}',
        //       style: TextStyle(
        //         fontSize: SizeConfig.defaultSize! * 2.2,
        //         decoration: TextDecoration.underline,
        //       ),
        //     ),
        //   ],
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                consultationModel.answer != 'null'
                    ? consultationModel.answer
                    : '',
                // textAlign: consultationModel.answer != 'null'
                //     ? TextAlign.center
                //     : null,
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2.2,
                ),
              ),
              Visibility(
                visible: consultationModel.answer != 'null',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Answer Date: ${consultationModel.answerDate}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
