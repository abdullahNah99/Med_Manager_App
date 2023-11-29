// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:med_manager_app/core/utils/app_colors.dart';
// import 'package:med_manager_app/core/utils/app_constants.dart';
// import 'package:med_manager_app/core/utils/app_router.dart';
// import 'package:med_manager_app/core/utils/cache_helper.dart';
// import 'package:med_manager_app/core/utils/service_locator.dart';
// import 'package:med_manager_app/features/authentication/data/repos/authentication_repo_impl.dart';
// import 'package:med_manager_app/features/splash/presentation/screens/widgets/sliding_logo.dart';

// class SplashView extends StatelessWidget {
//   const SplashView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const SafeArea(
//       child: Scaffold(
//         body: SplashViewBody(),
//         backgroundColor: AppColors.defaultColor,
//       ),
//     );
//   }
// }

// class SplashViewBody extends StatefulWidget {
//   const SplashViewBody({super.key});

//   @override
//   State<SplashViewBody> createState() => _SplashViewBodyState();
// }

// class _SplashViewBodyState extends State<SplashViewBody>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation<Offset> slidingAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _initSlidingAnimation();
//     _navigateToHomeView();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     animationController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         SlidingLogo(slidingAnimation: slidingAnimation),
//       ],
//     );
//   }

//   void _initSlidingAnimation() {
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );

//     slidingAnimation =
//         Tween<Offset>(begin: const Offset(0, 10), end: Offset.zero)
//             .animate(animationController);

//     animationController.forward();
//   }

//   void _navigateToHomeView() {
//     Future.delayed(
//       const Duration(seconds: 5),
//       () async {
//         final String? role = await CacheHelper.getData(key: 'Role');
//         if (role == null) {
//           GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
//         } else {
//           if (role == 'patient') {
//             (await getIt.get<AuthenticationRepoImpl>().getPatientData(
//                       adminToken: AppConstants.adminToken,
//                       userID: await CacheHelper.getData(key: 'UserID'),
//                     ))
//                 .fold(
//               (failure) {
//                 GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
//               },
//               (patientModel) {
//                 GoRouter.of(context).pushReplacement(
//                   AppRouter.kPatientHomeView,
//                   extra: patientModel,
//                 );
//               },
//             );
//           } else if (role == 'secretary') {
//             (await getIt.get<AuthenticationRepoImpl>().getSecretaryData(
//                       adminToken: AppConstants.adminToken,
//                       userID: await CacheHelper.getData(key: 'UserID'),
//                     ))
//                 .fold(
//               (failure) {
//                 GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
//               },
//               (secretaryModel) {
//                 GoRouter.of(context).pushReplacement(
//                   AppRouter.kHomeSecretaryView,
//                   extra: secretaryModel,
//                 );
//               },
//             );
//           }
//         }
//       },
//     );
//   }
// }
