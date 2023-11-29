import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/functions/custom_alert_dialog.dart';
import 'package:med_manager_app/core/functions/custom_snack_bar.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_button.dart';
import 'package:med_manager_app/core/widgets/custom_text_field.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_cubit.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/screens/widgets/custom_times_grid.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class AddAppointmentBottomSection extends StatelessWidget {
  final DoctorModel doctorModel;
  const AddAppointmentBottomSection({
    super.key,
    required this.doctorModel,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddAppointmentCubit>(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: SizeConfig.screenHeight * .7,
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const CustomTimesGrid(),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const VerticalSpace(3),
                    Form(
                      key: cubit.formKey,
                      child: CustomTextField(
                        hintText: 'Description',
                        maxLines: 3,
                        maxLength: 100,
                        keyboardType: TextInputType.multiline,
                        onChanged: (p0) => cubit.description = p0,
                      ),
                    ),
                    const VerticalSpace(3),
                    CustomButton(
                      text: 'Add Request',
                      onTap: () async {
                        if (cubit.formKey.currentState!.validate()) {
                          if (cubit.selectedTimeIndex == null) {
                            CustomSnackBar.showCustomSnackBar(
                              context,
                              message: 'Please Select Time',
                              backgroundColor: Colors.red,
                            );
                          } else {
                            CustomAlertDialog.showCustomAlertDialog(
                              context,
                              cubit: cubit,
                              doctorModel: doctorModel,
                            );
                          }
                        }
                      },
                    ),
                    const VerticalSpace(1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
