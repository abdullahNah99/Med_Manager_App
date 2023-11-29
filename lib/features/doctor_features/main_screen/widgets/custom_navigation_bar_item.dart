import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/doctor_features/main_screen/cubit/doctor_cubit.dart';

class CustomNavigationBarItem extends StatelessWidget {
  final int index;
  const CustomNavigationBarItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DoctorCubit>(context);
    return Column(
      children: [
        Column(
          children: [
            if (cubit.bottomNavigationBarindex != index) const VerticalSpace(2),
            Padding(
              padding: cubit.bottomNavigationBarindex == index
                  ? const EdgeInsets.all(8.0)
                  : EdgeInsets.zero,
              child: Icon(
                index == 0
                    ? (cubit.bottomNavigationBarindex == index
                        ? Icons.person
                        : Icons.person_outlined)
                    : index == 1
                        ? (cubit.bottomNavigationBarindex == index
                            ? Icons.home
                            : Icons.home_outlined)
                        : (cubit.bottomNavigationBarindex == index
                            ? Icons.chat
                            : Icons.chat_outlined),
                size: SizeConfig.defaultSize * 3.3,
                color: Colors.white,
              ),
            ),
            if (cubit.bottomNavigationBarindex != index)
              Text(
                index == 0
                    ? 'Patients'
                    : index == 1
                        ? 'Home'
                        : 'Consultations',
                style: const TextStyle(color: Colors.white),
              ),
          ],
        ),
      ],
    );
  }
}
