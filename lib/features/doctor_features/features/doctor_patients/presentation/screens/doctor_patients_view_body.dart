import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_cubit.dart';

class DoctorPatientsViewBody extends StatelessWidget {
  const DoctorPatientsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DoctorCubit>(context);
    return Center(
      child: Text('Patients: ${cubit.patients.length}'),
    );
  }
}
