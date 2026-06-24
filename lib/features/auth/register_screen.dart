import 'package:flutter/material.dart';
import 'package:news_app/features/auth/sign_in_screen.dart';
import 'package:news_app/features/main/main_screen.dart';

import '../../core/api/local_data/servies/preferences_manager.dart';
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

  bool isLoading = false;

  bool isConfirmPassword = false;
  bool isPassword = false;

  String? errorMessage;

  void register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 3));

    final savedEmail = PreferencesManager().getString("user_email");

    if (savedEmail != null && savedEmail == emailController.text.trim()) {
      setState(() {
        errorMessage = "User Already Register";
        isLoading = false;
      });
      return;
    } else {
      await PreferencesManager().setString("user_email", emailController.text);
      await PreferencesManager().setString(
        "user_password",
        passwordController.text,
      );
      await PreferencesManager().setBool('is_logged_in', true);

      setState(() {
        errorMessage = null;
        isLoading = false;
      });
      Navigator.push(
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height:  MediaQuery.of(context).size.height,
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
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please Enter Email";
                      }
                      RegExp emailRegExp = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );

                      if (!emailRegExp.hasMatch(value)) {
                        return "Please Enter Valid Email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  CustomTextFromField(
                    obscureText: isPassword ? false : true,
                    controller: passwordController,
                    title: 'Password',
                    hint: 'Enter Password',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please Enter Password";
                      }
                    },
                    suffix: IconButton(
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
                  SizedBox(height: 12),
                  CustomTextFromField(
                    obscureText: isConfirmPassword ? false : true,
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please Enter Confirm Password";
                      }
                      if (value != passwordController.text) {
                        return "Password do not match";
                      }
                    },
                    title: 'Confirm Password',
                    hint: 'Enter Confirm Password',
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmPassword = !isConfirmPassword;
                        });
                      },
                      icon: isConfirmPassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState?.validate() ?? false) {
                          register();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text("Sign Up"),
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
                        child: Text("Sign In"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
