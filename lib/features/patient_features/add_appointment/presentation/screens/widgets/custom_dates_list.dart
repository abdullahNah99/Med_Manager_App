import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_cubit.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/cubit/add_appointment_state.dart';
import 'package:med_manager_app/features/patient_features/add_appointment/presentation/screens/widgets/patient_date_button_builder.dart';

class CustomDatesList extends StatelessWidget {
  const CustomDatesList({super.key});

  @override
  Widget build(BuildContext context) {
    AddAppointmentCubit cubit = BlocProvider.of<AddAppointmentCubit>(context);
    log('CustomDatesList build');
    return BlocBuilder<AddAppointmentCubit, AddAppointmentStates>(
      buildWhen: (previous, current) => current is GetDoctorWorkDaysSuccess,
      builder: (context, state) {
        return SizedBox(
          height: SizeConfig.defaultSize * 10,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) => PatientDateButtonBuilder(
              index: index,
              day: cubit.dates[index].EEEE,
              date: cubit.dates[index].MMMd,
            ),
            separatorBuilder: (context, index) => const HorizintalSpace(.5),
            itemCount: cubit.dates.length,
          ),
        );
      },
    );
  }
}
