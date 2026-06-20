import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/auth/register_screen.dart';

import '../../core/widget/Custom_elevated_button.dart';
import '../../core/widget/Custom_text_from_field.dart';
import '../home/home_screen.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  obscureText:isPassword ? false : true,
                  controller: passwordController,
                  title: 'Password',
                  hint: 'Enter Password',
                  errorMessage: 'Please Enter Password',
                  suffix:IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: isPassword
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return RegisterScreen();
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
