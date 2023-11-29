import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/functions/custom_bottom_sheet.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/models/handle_appointment_navigator_model.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/cubits/handle_appointment_cubit/handle_appointments_cubit.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/screens/handle_appointment_screen/widgets/custom_handle_button.dart';

class HandleButtonsSection extends StatelessWidget {
  final HandleAppointmentNavigatorModel model;
  const HandleButtonsSection({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final HandleAppointmentsCubit cubit =
        BlocProvider.of<HandleAppointmentsCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomHandleButton(
          text: 'Approve',
          color: Colors.green,
          icon: Icons.done_outline,
          onPressed: () async {
            await cubit.approveAppointment(
              appointmentID: model.waitingAppointmentModel.id,
            );
          },
        ),
        CustomHandleButton(
          text: 'Cancel',
          color: Colors.red,
          icon: Icons.close,
          onPressed: () async {
            CustomBottomSheet.showCancelAppointmentBottomSheet(
              context,
              waitingAppointmentModel: model.waitingAppointmentModel,
              cubit: cubit,
            );
          },
        ),
        CustomHandleButton(
          text: 'Edit',
          color: AppColors.defaultColor.withOpacity(.7),
          icon: Icons.edit,
          onPressed: () {
            model.cubit = cubit;
            context.push(
              AppRouter.kEditAppointmentRequestView,
              extra: model,
            );
          },
        ),
      ],
    );
  }
}
