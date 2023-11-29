import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/functions/custom_progress_indicator.dart';
import 'package:med_manager_app/core/functions/custom_snack_bar.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/models/handle_appointment_navigator_model.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/cubits/handle_appointment_cubit/handle_appointments_cubit.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/cubits/handle_appointment_cubit/handle_appointments_states.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/screens/handle_appointment_screen/widgets/appointment_request_info_section.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/screens/handle_appointment_screen/widgets/doctor_info_section.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/screens/handle_appointment_screen/widgets/handle_appointment_header_section.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/screens/handle_appointment_screen/widgets/handle_buttons_section.dart';

class HandleAppointmentViewBody extends StatelessWidget {
  final HandleAppointmentNavigatorModel model;
  const HandleAppointmentViewBody({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final HandleAppointmentsCubit cubit =
        BlocProvider.of<HandleAppointmentsCubit>(context);
    return BlocConsumer<HandleAppointmentsCubit, HandleAppointmentsStates>(
      listener: (context, state) {
        cubit.listener = true;
        if (state is HandleAppointmentsLoading) {
          if (!CustomProgressIndicator.isOpen) {
            CustomProgressIndicator.showProgressIndicator(context);
          }
        } else {
          if (CustomProgressIndicator.isOpen) {
            Navigator.pop(context);
          }
          if (state is HandleAppointmentsFailure) {
            CustomSnackBar.showErrorSnackBar(
              context,
              message: state.failureMsg,
            );
          } else if (state is ApproveAppointmentSuccess) {
            context.pushReplacement(
              AppRouter.kHomeSecretaryView,
              extra: model.secretaryModel,
            );
            CustomSnackBar.showCustomSnackBar(
              context,
              message: 'Appointment Approved Successfully',
            );
          } else if (state is CancelAppointmentSuccess) {
            context.pushReplacement(
              AppRouter.kHomeSecretaryView,
              extra: model.secretaryModel,
            );
            CustomSnackBar.showCustomSnackBar(
              context,
              message: 'Appointment Cancelled Successfully',
            );
          }
        }
      },
      buildWhen: (previous, current) => current is HandleAppointmentsInitial,
      builder: (context, state) {
        if (state is HandleAppointmentsLoading &&
            !CustomProgressIndicator.isOpen &&
            !cubit.listener) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomProgressIndicator.showProgressIndicator(context);
          });
        }
        return ReorderableListView(
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          header: HandleAppointmentHeaderSection(model: model),
          children: [
            Stack(
              key: const Key('value2'),
              children: [
                Container(
                  padding: EdgeInsets.all(SizeConfig.defaultSize),
                  height: SizeConfig.screenHeight * .76,
                  width: SizeConfig.screenWidth,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const VerticalSpace(11),
                      AppointmentRequestInfoSection(model: model),
                      const Expanded(
                        child: VerticalSpace(1),
                      ),
                      HandleButtonsSection(model: model),
                      const VerticalSpace(2),
                    ],
                  ),
                ),
                Positioned(
                  left: SizeConfig.screenWidth * .05,
                  right: SizeConfig.screenWidth * .05,
                  child: DoctorInfoSection(model: model),
                ),
              ],
            ),
          ],
          onReorder: (oldIndex, newIndex) {},
        );
      },
    );
  }
}
