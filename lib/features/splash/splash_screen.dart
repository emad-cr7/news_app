import 'package:flutter/material.dart';
import 'package:news_app/features/main/main_screen.dart';
import '../../core/datasource/local_data/servies/preferences_manager.dart';
import '../../core/datasource/local_data/servies/user_repository.dart';
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

    final onboardingComplete = PreferencesManager().getBool('onboarding_complete') ?? false;
    final isLoggedIn = UserRepository().isLoggedIn;

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
            return MainScreen();
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
