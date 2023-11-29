import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/core/widgets/custom_scaffold.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/models/handle_appointment_navigator_model.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/repos/handle_appointments_repo_impl.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/cubits/handle_appointment_cubit/handle_appointments_cubit.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/screens/handle_appointment_screen/widgets/handle_appointment_view_body.dart';

class HandleAppointmentView extends StatelessWidget {
  final HandleAppointmentNavigatorModel model;
  const HandleAppointmentView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HandleAppointmentsCubit(
        handleAppointmentsRepo: getIt.get<HandleAppointmentsRepoImpl>(),
      )..getWorkDayModel(model: model),
      child: WillPopScope(
        onWillPop: () {
          context.pushReplacement(
            AppRouter.kHomeSecretaryView,
            extra: model.secretaryModel,
          );
          return Future.value(false);
        },
        child: CustomScaffold(
          onHorizontalDragUpdate: () => context.pushReplacement(
            AppRouter.kHomeSecretaryView,
            extra: model.secretaryModel,
          ),
          backgroundColor: AppColors.defaultColor,
          body: HandleAppointmentViewBody(
            model: model,
          ),
        ),
      ),
    );
  }
}
