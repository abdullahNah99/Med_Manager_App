// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:med_manager_app/core/utils/app_assets.dart';
import 'package:med_manager_app/core/utils/app_constants.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/core/utils/cache_helper.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_image.dart';
import 'package:med_manager_app/features/authentication/data/repos/authentication_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/home_patient/data/repos/home_patient_repo_impl.dart';

class TestSplashViewBody extends StatefulWidget {
  const TestSplashViewBody({super.key});

  @override
  State<TestSplashViewBody> createState() => _TestSplashViewBodyState();
}

class _TestSplashViewBodyState extends State<TestSplashViewBody>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _containerOpacity = 0.0;
  double _textOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> _animation1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation1 = Tween<double>(
      begin: 40,
      end: 20,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward().then(
      (value) {
        log('forward finish');
        _navigateToHomeView();
      },
    );

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 4000),
              curve: Curves.fastLinearToSlowEaseIn,
              height: SizeConfig.screenHeight / _fontSize,
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              opacity: _textOpacity,
              child: Text(
                'MED MANAGER APP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: _animation1.value * 1.2,
                ),
              ),
            ),
          ],
        ),
        Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastLinearToSlowEaseIn,
            opacity: _containerOpacity,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              height: SizeConfig.screenWidth / _containerSize,
              width: SizeConfig.screenWidth / _containerSize,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(30),
                shape: BoxShape.circle,
              ),
              child: CustomImage(
                image: AppAssets.logo,
                width: SizeConfig.defaultSize * 15,
                height: SizeConfig.defaultSize * 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToHomeView() async {
    final String? role = await CacheHelper.getData(key: 'Role');
    if (role == null) {
      GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
    } else {
      if (role == 'patient') {
        (await getIt.get<AuthenticationRepoImpl>().getPatientData(
                  adminToken: AppConstants.adminToken,
                  userID: await CacheHelper.getData(key: 'UserID'),
                ))
            .fold(
          (failure) {
            GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
          },
          (patientModel) {
            GoRouter.of(context).pushReplacement(
              AppRouter.kPatientHomeView,
              extra: patientModel,
            );
          },
        );
      } else if (role == 'secretary') {
        (await getIt.get<AuthenticationRepoImpl>().getSecretaryData(
                  adminToken: AppConstants.adminToken,
                  userID: await CacheHelper.getData(key: 'UserID'),
                ))
            .fold(
          (failure) {
            GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
          },
          (secretaryModel) {
            GoRouter.of(context).pushReplacement(
              AppRouter.kHomeSecretaryView,
              extra: secretaryModel,
            );
          },
        );
      } else if (role == 'doctor') {
        (await getIt.get<HomePatientRepoImpl>().viewDoctorDetails(
                  token: await CacheHelper.getData(key: 'Token'),
                  userID: await CacheHelper.getData(key: 'UserID'),
                ))
            .fold(
          (failure) {
            GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
          },
          (doctorModel) {
            GoRouter.of(context).pushReplacement(
              AppRouter.kDoctorView,
              extra: doctorModel,
            );
          },
        );
      }
    }
  }
}
