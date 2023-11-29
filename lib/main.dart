import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/app_colors.dart';
import 'package:med_manager_app/core/utils/app_router.dart';
import 'package:med_manager_app/core/utils/dio_helper.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'core/utils/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  DioHelper.init();
  await CacheHelper.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MedManagerApp(),
    ),
  );
}

class MedManagerApp extends StatelessWidget {
  const MedManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp.router(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: AppColors.getMaterialColor(AppColors.defaultColor),
        appBarTheme: AppBarTheme(
          color: AppColors.defaultColor,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.defaultSize * 2.6,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
            size: SizeConfig.defaultSize * 2.8,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
