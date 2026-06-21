import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/auth/register_screen.dart';

import '../../core/widget/Custom_elevated_button.dart';
import '../../core/widget/Custom_text_from_field.dart';
import '../home/home_screen.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  bool isPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png" , ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _key,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset("assets/images/logo.png", height: 45),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Welcome to Newts",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(height: 16),
                    CustomTextFromField(
                      controller: emailController,
                      title: 'Email',
                      hint: 'Enter Email',
                      errorMessage: 'Please Enter Email',
                    ),
                    SizedBox(height: 12),
                    CustomTextFromField(
                      obscureText: true,
                      controller: passwordController,
                      title: 'Password',
                      hint: 'Enter Password',
                      errorMessage: 'Please Enter Password',
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: CustomElevatedButton(
                        title: 'Sign In',
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return MainScreen();
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don’t have an account ?"),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RegisterScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up ",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
