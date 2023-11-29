// import 'package:flutter/material.dart';
// import 'package:med_manager_app/core/utils/app_assets.dart';
// import 'package:med_manager_app/core/utils/size_config.dart';
// import 'package:med_manager_app/core/widgets/custom_image.dart';
// import 'package:med_manager_app/core/widgets/space_widgets.dart';

// class SlidingLogo extends StatelessWidget {
//   final Animation<Offset> slidingAnimation;
//   const SlidingLogo({
//     super.key,
//     required this.slidingAnimation,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: slidingAnimation,
//       builder: (context, child) {
//         return SlideTransition(
//           position: slidingAnimation,
//           child: Column(
//             children: [
//               const CustomImage(image: AppAssets.logo),
//               const VerticalSpace(2),
//               Text(
//                 'Welcome To Med Manager',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: SizeConfig.defaultSize! * 2.6,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
