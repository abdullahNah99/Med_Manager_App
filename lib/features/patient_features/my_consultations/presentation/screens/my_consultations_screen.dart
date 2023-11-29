import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/core/widgets/custom_scaffold.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/data/repos/my_consultations_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/presentation/cubit/my_consultations_cubit.dart';
import 'package:med_manager_app/features/patient_features/my_consultations/presentation/screens/widgets/my_consultations_view_body.dart';

class MyConsultationsView extends StatelessWidget {
  const MyConsultationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyConsultationsCubit(
        myConsultationsRepo: getIt.get<MyConsultationsRepoImpl>(),
      )..getMyConsultations(),
      child: CustomScaffold(
        appBar: AppBar(
          title: const Text('My Consultations'),
        ),
        body: const MyConsultationsViewBody(),
      ),
    );
  }
}
