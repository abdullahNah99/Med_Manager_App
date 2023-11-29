import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/functions/custom_progress_indicator.dart';
import 'package:med_manager_app/core/functions/custom_snack_bar.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_cubit.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/cubits/home_patient_cubit/home_patient_states.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/screens/widgets/departments_list.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/screens/widgets/doctors_grid.dart';

class HomePatientViewBody extends StatelessWidget {
  final PatientModel patientModel;
  const HomePatientViewBody({
    super.key,
    required this.patientModel,
  });

  @override
  Widget build(BuildContext context) {
    HomePatientCubit cubit = BlocProvider.of<HomePatientCubit>(context);
    log('HomePatientViewBody build');
    return BlocConsumer<HomePatientCubit, HomePatientStates>(
      listener: (context, state) {
        if (state is HomePatientLoading && !(CustomProgressIndicator.isOpen)) {
          CustomProgressIndicator.showProgressIndicator(context);
        } else {
          if (CustomProgressIndicator.isOpen) {
            Navigator.pop(context);
          }
          if (state is HomePatientFailure) {
            CustomSnackBar.showErrorSnackBar(context,
                message: state.failureMsg);
          } else if (state is LogOutSuccess) {
            context.pushReplacement(AppRouter.kLoginView);
          } else if (state is ChangeFavoriteState) {
            CustomSnackBar.showCustomSnackBar(
              context,
              message: state.message,
              backgroundColor:
                  state.message.contains('delete') ? Colors.orange : null,
            );
          }
        }
      },
      buildWhen: (previous, current) => current is HomePatientInitial,
      builder: (context, state) {
        log('HomePatientViewBody cubit builder');
        // if (state is HomePatientLoading && !(CustomProgressIndicator.isOpen)) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     CustomProgressIndicator.showProgressIndicator(context);
        //   });
        // }
        return RefreshIndicator(
          onRefresh: () async {
            cubit.getHomePatientData();
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              const SliverToBoxAdapter(
                child: DepartmentsList(),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  endIndent: 10,
                  indent: 10,
                  thickness: 2,
                  color: Colors.grey.withOpacity(.3),
                ),
              ),
              const DoctorsGrid(),
            ],
          ),
        );
      },
    );
  }
}
