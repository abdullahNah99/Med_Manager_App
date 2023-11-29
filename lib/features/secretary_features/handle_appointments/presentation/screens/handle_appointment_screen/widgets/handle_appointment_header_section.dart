import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_arrow_back_button.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/data/models/handle_appointment_navigator_model.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/cubits/handle_appointment_cubit/handle_appointments_cubit.dart';
import 'package:med_manager_app/features/secretary_features/handle_appointments/presentation/screens/handle_appointment_screen/widgets/booked_appointment_item.dart';

class HandleAppointmentHeaderSection extends StatelessWidget {
  final HandleAppointmentNavigatorModel model;
  const HandleAppointmentHeaderSection({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final HandleAppointmentsCubit cubit =
        BlocProvider.of<HandleAppointmentsCubit>(context);
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.defaultSize,
        right: SizeConfig.defaultSize,
        bottom: SizeConfig.defaultSize,
        top: SizeConfig.defaultSize * 2.3,
      ),
      height: SizeConfig.screenHeight * .24,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomArrowBackButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.pushReplacement(
                    AppRouter.kHomeSecretaryView,
                    extra: model.secretaryModel,
                  );
                },
              ),
              Text(
                'Handle Appointment',
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2.3,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomNetworkImage(
                imageUrl: model.secretaryModel.departmentModel.image,
                color: Colors.white,
                circleShape: true,
                width: SizeConfig.defaultSize * 5,
                height: SizeConfig.defaultSize * 5,
                iconSize: SizeConfig.defaultSize * 4,
              ),
            ],
          ),
          const Expanded(child: VerticalSpace(1)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booked Appointments Times:',
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const VerticalSpace(1),
              SizedBox(
                height: SizeConfig.defaultSize * 5,
                child: model.approvedAppointments.isNotEmpty
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        itemBuilder: (context, index) => BookedAppointmentItem(
                          time: cubit
                              .sortTimes(
                                  times: model.approvedAppointments)[index]
                              .time,
                        ),
                        separatorBuilder: (context, index) =>
                            const HorizintalSpace(.5),
                        scrollDirection: Axis.horizontal,
                        // itemCount: cubit.bookedAppointments.length,
                        itemCount: model.approvedAppointments.length,
                      )
                    : Center(
                        child: Text(
                          'No Booked Appointments',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: SizeConfig.defaultSize * 2.2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
