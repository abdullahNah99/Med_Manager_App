import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:med_manager_app/core/functions/custom_progress_indicator.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/presentation/cubit/my_consultations_cubit.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/presentation/cubit/my_consultations_states.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/presentation/screens/widgets/my_consultation_item.dart';

class MyConsultationsViewBody extends StatelessWidget {
  const MyConsultationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    log('MyConsultationsViewBody build');
    MyConsultationsCubit cubit = BlocProvider.of<MyConsultationsCubit>(context);
    return BlocConsumer<MyConsultationsCubit, MyConsultationsStates>(
      listener: (context, state) {
        if (state is MyConsultationsLoading) {
          if (!CustomProgressIndicator.isOpen) {
            CustomProgressIndicator.showProgressIndicator(context);
          }
        } else {
          if (CustomProgressIndicator.isOpen) {
            Navigator.pop(context);
          }
        }
      },
      buildWhen: (previous, current) => current is MyConsultationsSuccess,
      builder: (context, state) {
        log('MyConsultationsViewBody cubit builder');
        if (state is MyConsultationsLoading &&
            !(CustomProgressIndicator.isOpen)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomProgressIndicator.showProgressIndicator(context);
          });
        }
        return RefreshIndicator(
          onRefresh: () => cubit.getMyConsultations(),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemBuilder: (context, index) =>
                AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastLinearToSlowEaseIn,
                horizontalOffset: SizeConfig.screenWidth * .5,
                verticalOffset: SizeConfig.screenHeight * .8,
                child: FlipAnimation(
                  duration: const Duration(milliseconds: 3000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  flipAxis: FlipAxis.y,
                  child: MyConsultationItem(
                    consultationModel: cubit.myConsultations[index],
                    index: index,
                  ),
                ),
              ),
            ),
            separatorBuilder: (context, index) => const Column(
              children: [
                VerticalSpace(1),
                Divider(thickness: 2),
                VerticalSpace(2.5),
              ],
            ),
            itemCount: cubit.myConsultations.length,
            padding: EdgeInsets.only(
              left: SizeConfig.defaultSize,
              right: SizeConfig.defaultSize,
              bottom: SizeConfig.defaultSize,
              top: SizeConfig.defaultSize * 3,
            ),
          ),
        );
      },
    );
  }
}
