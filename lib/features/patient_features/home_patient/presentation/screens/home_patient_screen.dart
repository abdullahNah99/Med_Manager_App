import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/screens/widgets/custom_patient_drawer.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/screens/widgets/home_patient_view_body.dart';
import '../../../../authentication/data/models/patient_model.dart';

class HomePatientView extends StatelessWidget {
  final PatientModel patientModel;
  const HomePatientView({
    super.key,
    required this.patientModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomPatientDrawer(patientModel: patientModel),
      onDrawerChanged: (isOpened) async {
        if (isOpened) {
          await BlocProvider.of<HomePatientCubit>(context).getPatientData();
        }
      },
      appBar: AppBar(
        title: AnimatedTextKit(
          isRepeatingAnimation: false,
          repeatForever: false,
          animatedTexts: [
            WavyAnimatedText('Welcome ${patientModel.userModel.lastName}'),
          ],
        ),
      ),
      body: HomePatientViewBody(
        patientModel: patientModel,
      ),
    );
  }
}
