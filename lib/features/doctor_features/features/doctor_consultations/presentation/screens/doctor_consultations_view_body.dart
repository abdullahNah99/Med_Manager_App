import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_cubit.dart';

class DoctorConsultationsViewBody extends StatelessWidget {
  const DoctorConsultationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DoctorCubit>(context);
    return Center(
      child: Text('Consulattions: ${cubit.consultations.length}'),
    );
  }
}
