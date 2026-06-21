import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/auth/register_screen.dart';

import '../../core/api/local_data/servies/preferences_manager.dart';
import '../../core/widget/Custom_elevated_button.dart';
import '../../core/widget/Custom_text_from_field.dart';
import '../home/home_screen.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  String? errorMessage;

  bool isLoading = false;

  void login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 3));

    final savedEmail = PreferencesManager().getString("user_email");
    final savedPassword = PreferencesManager().getString("user_Password");

    if (savedEmail == null || savedPassword == null) {
      setState(() {
        errorMessage = "No Account Found Please Register First ";
        isLoading = false;
      });
      return ;
    }

    if (savedEmail != emailController.text || savedPassword != passwordController.text) {
      setState(() {
        errorMessage = "Incorrect Email or Password";
        isLoading = false;
      });
      return ;
    }

    await PreferencesManager().setBool('is_logged_in', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return MainScreen();
        },
      ),
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Email";
                        }
                        RegExp emailRegExp = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );

                        if (!emailRegExp.hasMatch(value)) {
                          return "Please Enter Valid Email ";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 12),
                    CustomTextFromField(
                      obscureText: true,
                      controller: passwordController,
                      title: 'Password',
                      hint: 'Enter Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Password";
                        }
                      },
                    ),


                    if (errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),


                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            52,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),

                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            login();
                          }
                        },
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text("Sign In"),
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
