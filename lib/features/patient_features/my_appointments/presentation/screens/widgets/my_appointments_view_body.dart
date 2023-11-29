import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:med_manager_app/core/functions/custom_progress_indicator.dart';
import 'package:med_manager_app/core/functions/custom_snack_bar.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/presentation/cubit/my_appointments_cubit.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/presentation/cubit/my_appointments_states.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/presentation/screens/widgets/my_appointment_item.dart';

class MyAppointmentsViewBody extends StatelessWidget {
  final bool scrollToDownd;
  const MyAppointmentsViewBody({super.key, required this.scrollToDownd});

  @override
  Widget build(BuildContext context) {
    log('MyAppointmentsViewBody build');
    MyAppointmentsCubit cubit = BlocProvider.of<MyAppointmentsCubit>(context);
    return BlocConsumer<MyAppointmentsCubit, MyAppointmentsStates>(
      listener: (context, state) {
        if (state is MyAppointmentsLoading) {
          if (!CustomProgressIndicator.isOpen) {
            CustomProgressIndicator.showProgressIndicator(context);
          }
        } else {
          if (CustomProgressIndicator.isOpen) {
            Navigator.pop(context);
          }
          if (state is DeleteAppointmentSuccess) {
            CustomSnackBar.showCustomSnackBar(
              context,
              message: state.message,
            );
          }
        }
      },
      builder: (context, state) {
        log('MyAppointmentsViewBody cubit builder');
        if (state is MyAppointmentsLoading && !CustomProgressIndicator.isOpen) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomProgressIndicator.showProgressIndicator(context);
          });
        }
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          controller: cubit.scrollController,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            delay: const Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastLinearToSlowEaseIn,
              verticalOffset: -250,
              child: ScaleAnimation(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.fastLinearToSlowEaseIn,
                child: MyAppointmentItem(
                  appointmentModel: cubit.myAppointments[index],
                  scrollToDown: scrollToDownd,
                  index: index,
                ),
              ),
            ),
          ),
          separatorBuilder: (context, index) => const VerticalSpace(1.3),
          itemCount: cubit.myAppointments.length,
        );
      },
    );
  }
}
