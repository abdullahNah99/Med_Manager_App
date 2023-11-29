import 'package:flutter/material.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/models/handle_appointment_navigator_model.dart';

class EditAppointmentRequestViewBody extends StatelessWidget {
  final HandleAppointmentNavigatorModel model;
  const EditAppointmentRequestViewBody({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    // final EditAppointmentRequestCubit cubit =
    //     BlocProvider.of<EditAppointmentRequestCubit>(context);
    return Column(
      children: List.generate(
        model.approvedAppointments.length,
        (index) => Row(
          children: [
            const Expanded(child: HorizintalSpace(1)),
            Text(
              '${model.approvedAppointments[index].date} ${model.approvedAppointments[index].time}',
            ),
          ],
        ),
      ),
    );
  }
}
