import 'package:flutter/material.dart';
import 'package:news_app/features/home/home_screen.dart';

import '../../core/api/local_data/servies/preferences_manager.dart';
import '../auth/sign_in_screen.dart';
import '../onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _navigateAfterSplash();
  }

  void _navigateAfterSplash() async {
    await Future.delayed(Duration(seconds: 2));

    final onboardingComplete =
        PreferencesManager().getBool('onboarding_complete') ?? false;
    final isLoggedIn = PreferencesManager().getBool('is_logged_in') ?? false;

    if (!mounted) return;

    if (!onboardingComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Onboarding();
          },
        ),
      );
    } else if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginScreen();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return HomeScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        width: double.infinity,
        'assets/images/splash.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
