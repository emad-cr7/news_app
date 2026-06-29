import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/theme/light_theme.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

import 'core/api/local_data/servies/preferences_manager.dart';
import 'features/home/home_screen.dart';
import 'features/main/main_screen.dart';
import 'features/onboarding/onboarding.dart';
import 'features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await PreferencesManager().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 832),
      minTextAdapt: true,
      builder: (context, _) {
        return MaterialApp(
          title: 'News App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}
