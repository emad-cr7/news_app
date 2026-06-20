import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_theme.dart';

import 'core/api/local_data/servies/preferences_manager.dart';
import 'features/home/home_screen.dart';
import 'features/main/main_screen.dart';
import 'features/onboarding/onboarding.dart';
import 'features/splash/splash_screen.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
 await  PreferencesManager().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:lightTheme,
      home:  SplashScreen(),
    );
  }
}
