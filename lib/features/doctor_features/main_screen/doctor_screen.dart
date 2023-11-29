import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/functions/custom_progress_indicator.dart';
import 'package:med_manager_app/core/functions/custom_snack_bar.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/features/doctor_features/features/doctor_consultations/presentation/screens/doctor_consultations_view_body.dart';
import 'package:med_manager_app/features/doctor_features/features/doctor_patients/presentation/screens/doctor_patients_view_body.dart';
import 'package:med_manager_app/features/doctor_features/features/home_doctor/presentation/screens/home_doctor_view_body.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_cubit.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_states.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/widgets/bottom_navigation_bar_builder.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/widgets/custom_popup_menu_button.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class DoctorView extends StatelessWidget {
  final DoctorModel doctorModel;

  const DoctorView({
    super.key,
    required this.doctorModel,
  });

  @override
  Widget build(BuildContext context) {
    log('DoctorView build');
    final cubit = BlocProvider.of<DoctorCubit>(context);
    final List<Widget> screens = [
      const DoctorPatientsViewBody(),
      HomeDoctorViewBody(doctorModel: doctorModel),
      const DoctorConsultationsViewBody(),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: const [
          CustomPopupMenuButton(),
        ],
        title: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText('Welcome Dr. ${doctorModel.user.firstName}'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarBuilder(),
      body: BlocConsumer<DoctorCubit, DoctorStates>(
        listener: (context, state) {
          cubit.listener = true;
          if (state is DoctorLoading && !CustomProgressIndicator.isOpen) {
            CustomProgressIndicator.showProgressIndicator(context);
          } else {
            if (CustomProgressIndicator.isOpen && state is GetPatientsSuccess) {
              context.pop();
            }
            if (state is LogOutSuccess) {
              context.pushReplacement(AppRouter.kLoginView);
            } else if (state is DoctorFailure) {
              CustomSnackBar.showErrorSnackBar(
                context,
                message: state.failureMsg,
              );
            }
          }
        },
        builder: (context, state) {
          if (!cubit.listener &&
              !CustomProgressIndicator.isOpen &&
              state is DoctorLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CustomProgressIndicator.showProgressIndicator(context);
            });
          }
          return PageView.builder(
            itemCount: 3,
            onPageChanged: (index) {
              cubit.onPageChanged(index);
            },
            controller: cubit.pageController,
            itemBuilder: (context, index) {
              log('PageView item builder');
              return GestureDetector(
                onTap: () {
                  log(cubit.approvedAppointmentsDates.toString());
                },
                child: screens[index],
              );
            },
          );
        },
      ),
    );
  }
}
