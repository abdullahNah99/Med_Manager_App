import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_cubit.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_states.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/screens/widgets/custom_date_button.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class DateButtonBuilder extends StatelessWidget {
  final int index;
  final DoctorModel doctorModel;
  const DateButtonBuilder({
    super.key,
    required this.index,
    required this.doctorModel,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DoctorCubit>(context);
    return BlocBuilder<DoctorCubit, DoctorStates>(
      buildWhen: (previous, current) =>
          current is SelectDateState &&
          (index == cubit.selectedDateIndex ||
              index == cubit.previousDateIndex),
      builder: (context, state) {
        final String day = cubit.approvedAppointmentsDates[index].split(' ')[0];
        final String date =
            cubit.approvedAppointmentsDates[index].split(day)[1];
        return CustomDateButton(
          index: index,
          day: day,
          date: date,
          color: index == cubit.selectedDateIndex
              ? AppColors.defaultColor
              : Colors.grey.withOpacity(.6),
          textColor: Colors.white,
          onTap: () {
            cubit.selectDate(index: index, doctorID: doctorModel.id);
          },
        );
      },
    );
  }
}
