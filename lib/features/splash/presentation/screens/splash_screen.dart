import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/features/splash/presentation/screens/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.defaultColor,
      body: TestSplashViewBody(),
    );
  }
}
