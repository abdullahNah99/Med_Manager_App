import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/functions/custom_progress_indicator.dart';
import 'package:med_manager_app/core/functions/custom_snack_bar.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/authentication/data/models/secretary_model.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_cubit.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_states.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/screens/widgets/secretary_dates_list_builder.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/screens/widgets/waiting_appointments_list_builder.dart';

class HomeSecretaryViewBody extends StatelessWidget {
  final SecretaryModel secretaryModel;
  const HomeSecretaryViewBody({
    super.key,
    required this.secretaryModel,
  });

  @override
  Widget build(BuildContext context) {
    log('HomeSecretaryViewBody build');
    final HomeSecretaryCubit cubit =
        BlocProvider.of<HomeSecretaryCubit>(context);
    return BlocConsumer<HomeSecretaryCubit, HomeSecretaryStates>(
      listener: (context, state) {
        cubit.listener = true;
        if (state is HomeSecretaryLoading) {
          if (!CustomProgressIndicator.isOpen) {
            CustomProgressIndicator.showProgressIndicator(context);
          }
        } else {
          if (CustomProgressIndicator.isOpen &&
              (state is IndexDepartmentAppointments ||
                  state is HomeSecretaryFailure ||
                  state is SelectDateState)) {
            Navigator.pop(context);
          }
          if (state is LogOutSuccess) {
            context.pushReplacement(AppRouter.kLoginView);
          } else if (state is HomeSecretaryFailure) {
            CustomSnackBar.showErrorSnackBar(
              context,
              message: state.failureMsg,
            );
          }
        }
      },
      buildWhen: (previous, current) => current is HomeSecretaryInitial,
      builder: (context, state) {
        log('HomeSecretaryViewBody cubit builder');
        if (state is HomeSecretaryLoading &&
            !CustomProgressIndicator.isOpen &&
            !cubit.listener) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomProgressIndicator.showProgressIndicator(context);
          });
        }
        return RefreshIndicator(
          onRefresh: () => cubit.firstOpen(
            secretaryModel: secretaryModel,
          ),
          child: ReorderableListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.all(SizeConfig.defaultSize),
            onReorder: (oldIndex, newIndex) {},
            buildDefaultDragHandles: false,
            header: SizedBox(
              height: SizeConfig.defaultSize * 10,
              child: const SecretaryDatesListBuilder(),
            ),
            children: [
              // if (cubit.waitingAppointmentsDates.isEmpty &&
              //     cubit.waitingAppointments.isEmpty)
              //   Column(
              //     key: const Key('Center'),
              //     children: [
              //       const VerticalSpace(25),
              //       Text(
              //         'All Appointments Have Been Handled...',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           fontSize: SizeConfig.defaultSize! * 2,
              //           color: Colors.grey,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // if (cubit.waitingAppointmentsDates.isNotEmpty)
              WaitingAppointmentsListBuilder(
                key: const Key('WaitingAppointmentsListBuilder'),
                secretaryModel: secretaryModel,
              ),
            ],
          ),
        );
      },
    );
  }
}
