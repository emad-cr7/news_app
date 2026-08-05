import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_app/features/main/main_screen.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/datasource/local_data/user_repository.dart';
import '../../core/models/user_model.dart';
import '../../core/theme/light_color.dart';
import '../../core/widgets/animation/custom_animation.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _form = GlobalKey();
    TextEditingController nameController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_image.png",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppSizes.r16),
              child: Center(
                child: Form(
                  key: _form,
                  child: AnimationLimiter(
                    child: Column(
                      children: [
                        SizedBox(height: 220),
                        CustomAnimation(
                          position: 2,
                          child: Center(
                            child: Image.asset(
                              "assets/images/logo.png",
                              height: AppSizes.h45,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizes.h8),
                        CustomAnimation(
                          position: 4,
                          child: Center(
                            child: Text(
                              "Welcome ",
                              style: TextStyle(
                                fontSize: AppSizes.sp20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizes.ph20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomAnimation(
                            position: 6,
                            child: TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Please enter your name.";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: LightColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizes.ph30),
                        CustomAnimation(
                          position: 8,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_form.currentState!.validate()) {
                                final existingUser = UserRepository().getUser();
                                if (existingUser != null) {
                                  await UserRepository().updateUser(
                                    name: nameController.text.trim(),
                                  );
                                } else {
                                  await UserRepository().saveUser(
                                    UserModel(name: nameController.text.trim()),
                                  );
                                }

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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
