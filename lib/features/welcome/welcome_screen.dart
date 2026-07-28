import 'package:flutter/material.dart';
import 'package:news_app/features/main/main_screen.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/datasource/local_data/preferences_manager.dart';
import '../../core/theme/light_color.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _form = GlobalKey();

    TextEditingController nameController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,

          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_image.png"),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.r16),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: AppSizes.h45,
                        ),
                      ),
                      SizedBox(height: AppSizes.h8),
                      Center(
                        child: Text(
                          "Welcome ",
                          style: TextStyle(
                            fontSize: AppSizes.sp20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizes.ph20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter your name.";
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: LightColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizes.ph30),
                      ElevatedButton(
                        onPressed: () async {
                          if (_form.currentState!.validate()) {
                            await PreferencesManager().setBool(
                              'is_logged_in',
                              true,
                            );
                            await PreferencesManager().setString(
                              "name",
                              nameController.text,
                            );
                            if (!context.mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return MainScreen();
                                },
                              ),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Lets Go"),
                            SizedBox(width: AppSizes.w8),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
