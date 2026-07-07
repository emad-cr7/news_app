import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/datasource/local_data/servies/user_repository.dart';
import 'package:news_app/core/theme/light_theme.dart';
import 'core/datasource/local_data/servies/preferences_manager.dart';
import 'features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await PreferencesManager().init();
  await UserRepository().init();

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
