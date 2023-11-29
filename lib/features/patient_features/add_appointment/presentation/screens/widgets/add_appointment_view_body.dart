import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/functions/custom_progress_indicator.dart';
import 'package:med_manager_app/core/functions/custom_snack_bar.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_cubit.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_state.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/screens/widgets/bottom_section.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/screens/widgets/custom_app_bar.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/screens/widgets/custom_dates_list.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/navigator_model.dart';

class AddAppointmentViewBody extends StatelessWidget {
  final DoctorModel doctorModel;
  const AddAppointmentViewBody({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    AddAppointmentCubit cubit = BlocProvider.of<AddAppointmentCubit>(context);
    log('AddAppointmentViewBody build');
    return BlocConsumer<AddAppointmentCubit, AddAppointmentStates>(
      listener: (context, state) {
        cubit.listener = true;
        if (state is AddAppointmentLoading) {
          if (CustomProgressIndicator.isOpen == false) {
            CustomProgressIndicator.showProgressIndicator(context);
          }
        } else {
          if (CustomProgressIndicator.isOpen) {
            Navigator.pop(context);
          }
          if (state is AddAppointmentSuccess) {
            if (!state.message.contains('charge')) {
              GoRouter.of(context).pushReplacement(
                AppRouter.kMyAppointmentsView,
                extra: MyAppointmentsNavigatorModel(
                  patientID: cubit.patientModel!.id,
                  scrollToDown: true,
                ),
              );
            }
            CustomSnackBar.showCustomSnackBar(
              context,
              message: state.message,
              backgroundColor:
                  state.message.contains('charge') ? Colors.orange : null,
            );
          }
        }
      },
      buildWhen: (previous, current) => current is AddAppointmentInitial,
      builder: (context, state) {
        log('AddAppointmentViewBody cubit builder');
        if (state is AddAppointmentLoading &&
            !(CustomProgressIndicator.isOpen) &&
            !(cubit.listener)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomProgressIndicator.showProgressIndicator(context);
          });
        }
        return Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * .3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  CustomAppBar(doctorModel: doctorModel),
                  const Spacer(),
                  const CustomDatesList(),
                  const VerticalSpace(3),
                ],
              ),
            ),
            AddAppointmentBottomSection(doctorModel: doctorModel),
          ],
        );
      },
    );
  }
}
