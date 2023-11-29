import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/models/consultation_model.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/presentation/cubit/my_consultations_cubit.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/presentation/cubit/my_consultations_states.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/presentation/screens/widgets/answer_section.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/presentation/screens/widgets/doctor_section.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/presentation/screens/widgets/question_section.dart';

class MyConsultationItem extends StatelessWidget {
  final ConsultationModel consultationModel;
  final int index;
  const MyConsultationItem({
    super.key,
    required this.consultationModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    log('MyConsultationItem build');
    final MyConsultationsCubit cubit =
        BlocProvider.of<MyConsultationsCubit>(context);
    return BlocBuilder<MyConsultationsCubit, MyConsultationsStates>(
      buildWhen: (previous, current) => (current is ShowAnswerState &&
          cubit.tappedConsultationIndex == index),
      builder: (context, state) {
        log('MyConsultationItem cubit builder');
        return Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 700),
              reverseDuration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.only(
                  left: SizeConfig.defaultSize,
                  right: SizeConfig.defaultSize,
                  bottom: SizeConfig.defaultSize,
                  top: SizeConfig.defaultSize * 5,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 239, 243),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuestionSection(consultationModel: consultationModel),
                    Visibility(
                      visible: consultationModel.showAnswer,
                      child: AnimatedSize(
                        duration: const Duration(seconds: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              indent: SizeConfig.defaultSize * 2,
                              endIndent: SizeConfig.defaultSize * 2,
                            ),
                            AnswerSection(
                              consultationModel: consultationModel,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  splashColor: AppColors.defaultColor.withOpacity(.1),
                  highlightColor: AppColors.defaultColor.withOpacity(.1),
                  onTap: () {
                    if (consultationModel.answer != 'null') {
                      cubit.tappedConsultationIndex = index;
                      cubit.showAnswer(consultationModel: consultationModel);
                    }
                  },
                ),
              ),
            ),
            Positioned(
              left: SizeConfig.screenWidth * .1,
              right: SizeConfig.screenWidth * .1,
              top: SizeConfig.defaultSize * -2,
              child: DoctorSection(consultationModel: consultationModel),
            ),
            Positioned(
              left: SizeConfig.screenWidth * .85,
              top: SizeConfig.defaultSize * -2,
              child: Icon(
                Icons.question_mark_rounded,
                size: SizeConfig.defaultSize * 5,
                color: consultationModel.answer == 'null'
                    ? Colors.orange
                    : Colors.green,
              ),
            ),
          ],
        );
      },
    );
  }
}
