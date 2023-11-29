import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_cubit.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_states.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/screens/widgets/secretary_date_button_builder.dart';

class SecretaryDatesListBuilder extends StatelessWidget {
  const SecretaryDatesListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeSecretaryCubit cubit =
        BlocProvider.of<HomeSecretaryCubit>(context);
    return BlocBuilder<HomeSecretaryCubit, HomeSecretaryStates>(
      buildWhen: (previous, current) =>
          current is GetWaintingAppointnmentsDatesSuccess,
      builder: (context, state) {
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) =>
              SecretaryDateButtonBuilder(index: index),
          separatorBuilder: (context, index) => const HorizintalSpace(.5),
          itemCount: cubit.waitingAppointmentsDates.length,
        );
      },
    );
  }
}
