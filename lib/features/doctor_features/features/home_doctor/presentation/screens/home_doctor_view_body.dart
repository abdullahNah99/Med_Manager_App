import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/doctor_features/features/home_doctor/presentation/screens/widgets/date_button_bloc_builder.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/models/doctor_model.dart';

class HomeDoctorViewBody extends StatelessWidget {
  final DoctorModel doctorModel;
  const HomeDoctorViewBody({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DoctorCubit>(context);
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.defaultSize * 10,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => DateButtonBuilder(
              index: index,
              doctorModel: doctorModel,
            ),
            separatorBuilder: (context, index) => const HorizintalSpace(.5),
            itemCount: cubit.approvedAppointmentsDates.length,
          ),
        ),
        Center(
          child: Text('Home: ${cubit.approvedAppointments.length}'),
        ),
      ],
    );
  }
}
