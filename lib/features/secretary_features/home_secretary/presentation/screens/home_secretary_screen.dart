import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/features/authentication/data/models/secretary_model.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/cubit/home_secretary_cubit.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/screens/widgets/custom_secretary_drawer.dart';
import 'package:med_manager_app/features/secretary_features/home_secretary/presentation/screens/widgets/home_secretary_view_body.dart';

class HomeSecretaryView extends StatelessWidget {
  final SecretaryModel secretaryModel;
  const HomeSecretaryView({super.key, required this.secretaryModel});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeSecretaryCubit>(context);
    log('HomeSecretaryView build');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: CustomSecretaryDrawer(secretaryModel: secretaryModel),
        appBar: AppBar(
          title: Text('Welcom ${secretaryModel.userModel.firstName}'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(.3),
            tabs: cubit.tabs,
          ),
        ),
        body: TabBarView(
          children: List.generate(
            3,
            (index) {
              if (index == 0) {
                return HomeSecretaryViewBody(secretaryModel: secretaryModel);
              } else if (index == 1) {
                return const Center(
                  child: Text('Doctors'),
                );
              } else {
                return const Center(
                  child: Text('Doctors'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
