import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/bottom_sheet_top_container.dart';
import 'package:med_manager_app/core/widgets/custom_button.dart';
import 'package:med_manager_app/core/widgets/custom_text_field.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/doctor_details/presentation/cubit/doctor_details_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/cubits/handle_appointment_cubit/handle_appointments_cubit.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/screens/handle_appointment_screen/widgets/custom_handle_button.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/data/models/waiting_appointment_model.dart';

abstract class CustomBottomSheet {
  static void showConsultationBottomSheet(
    BuildContext context, {
    required DoctorModel doctorModel,
    required DoctorDetailsCubit cubit,
  }) {
    showModalBottomSheet(
      context: context,
      elevation: 10,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(45),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HorizintalSpace(100),
                  const VerticalSpace(1),
                  const BottomSheetTopContainer(),
                  const VerticalSpace(2),
                  Text(
                    'Note: You Will Lose ${doctorModel.consultationPrice} From Your Balance When Doctor Answer Your Question',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  const VerticalSpace(2),
                  Form(
                    key: cubit.formKey,
                    child: CustomTextField(
                      initialValue: cubit.question,
                      hintText: 'Enter Your Question?',
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) => cubit.question = value,
                    ),
                  ),
                  const VerticalSpace(2),
                  CustomButton(
                    text: 'Send',
                    onTap: () async {
                      if (cubit.formKey.currentState!.validate()) {
                        await cubit.sendQuestion(doctorID: doctorModel.id);
                      }
                    },
                  ),
                  const VerticalSpace(1),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showCancelAppointmentBottomSheet(
    BuildContext context, {
    required WaitingAppointmentModel waitingAppointmentModel,
    required HandleAppointmentsCubit cubit,
  }) {
    cubit.cancelReason = cubit.getInitialCancelReason(
      waitingAppointmentModel: waitingAppointmentModel,
    );
    showModalBottomSheet(
      context: context,
      elevation: 10,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(45),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: SizeConfig.screenHeight * .36,
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.all(SizeConfig.defaultSize),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Column(
              children: [
                const HorizintalSpace(100),
                const BottomSheetTopContainer(),
                const VerticalSpace(1),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '  Cancel Reason:',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColors.defaultColor,
                      fontSize: SizeConfig.defaultSize * 2,
                    ),
                  ),
                ),
                const VerticalSpace(1.5),
                Form(
                  key: cubit.formKey,
                  child: CustomTextField(
                    maxLines: 4,
                    autofocus: true,
                    initialValue: cubit.getInitialCancelReason(
                      waitingAppointmentModel: waitingAppointmentModel,
                    ),
                    onChanged: (value) => cubit.cancelReason = value,
                  ),
                ),
                const VerticalSpace(1),
                CustomHandleButton(
                  text: 'Cancel',
                  icon: Icons.close,
                  onPressed: () async {
                    if (cubit.formKey.currentState!.validate()) {
                      await cubit
                          .cancelAppointment(
                            appointmentID: waitingAppointmentModel.id,
                          )
                          .then(
                            (value) => Navigator.pop(context),
                          );
                    }
                  },
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
