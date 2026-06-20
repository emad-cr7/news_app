import 'package:flutter/material.dart';
import 'package:news_app/features/auth/sign_in_screen.dart';

import '../../core/widget/Custom_elevated_button.dart';
import '../../core/widget/Custom_text_from_field.dart';
import '../home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _key,
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
                  obscureText: false,
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
                SizedBox(height: 12),
                CustomTextFromField(
                  obscureText:true,
                  controller: confirmPasswordController,
                  extraValidator: (value) {
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  title: 'Confirm Password',
                  hint: 'Enter Confirm Password',
                  errorMessage: 'Please Enter Confirm Password',

                ),
                SizedBox(height: 20),
                Center(
                  child: CustomElevatedButton(
                    title: 'Sign Up',
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return LoginScreen();
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
                    Text("Have an account ?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
