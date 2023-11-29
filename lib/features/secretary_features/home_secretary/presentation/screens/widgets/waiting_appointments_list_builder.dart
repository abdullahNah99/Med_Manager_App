import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:med_manager_app/features/authentication/data/models/secretary_model.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_cubit.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_states.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/screens/widgets/waiting_appointment_item.dart';

class WaitingAppointmentsListBuilder extends StatelessWidget {
  final SecretaryModel secretaryModel;
  const WaitingAppointmentsListBuilder({
    super.key,
    required this.secretaryModel,
  });

  @override
  Widget build(BuildContext context) {
    final HomeSecretaryCubit cubit =
        BlocProvider.of<HomeSecretaryCubit>(context);
    return BlocBuilder<HomeSecretaryCubit, HomeSecretaryStates>(
      buildWhen: (previous, current) =>
          current is GetWaintingAppointnmentsSuccess,
      builder: (context, state) {
        return Column(
          children: List.generate(
            cubit.waitingAppointments.length,
            (index) => AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                // horizontalOffset: SizeConfig.screenWidth! * .5,
                verticalOffset: -250,
                child: ScaleAnimation(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  // flipAxis: FlipAxis.y,
                  child: WaitingAppointmentItem(
                    key: Key(index.toString()),
                    waitingAppointmentModel: cubit.waitingAppointments[index],
                    secretaryModel: secretaryModel,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
