import 'package:flutter/material.dart';
import 'package:news_app/features/auth/sign_in_screen.dart';
import 'package:news_app/features/main/main_screen.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/datasource/local_data/servies/user_repository.dart';
import '../../core/widget/Custom_text_from_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
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
    final String? error = await UserRepository().signUp(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    if (error != null) {
      setState(() {
        errorMessage = error;
        isLoading = false;
      });
      return;
    } else {
      setState(() {
        errorMessage = null;
        isLoading = false;
      });
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.w16),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: AppSizes.h45,
                    ),
                  ),
                  SizedBox(height: AppSizes.ph24),
                  Text(
                    "Welcome to Newts",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(height: AppSizes.ph16),
                  CustomTextFromField(
                    obscureText: false,
                    controller: nameController,
                    title: 'Name',
                    hint: 'John Doe',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your full name";
                      }
                    },
                  ),
                  SizedBox(height: AppSizes.ph12),
                  CustomTextFromField(
                    obscureText: false,
                    controller: emailController,
                    title: 'Email',
                    hint: 'example@email.com',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Enter your email address";
                      }
                      RegExp emailRegExp = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );

                      if (!emailRegExp.hasMatch(value)) {
                        return "Please Enter Valid Email_%+-]+@[a-zA-Z0-9.-]";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: AppSizes.ph12),
                  CustomTextFromField(
                    obscureText: isPassword ? false : true,
                    controller: passwordController,
                    title: 'Password',
                    hint: '••••••••',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter a password";
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
                  SizedBox(height: AppSizes.ph12),
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
                    hint: 'Re-enter your password',
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
                      padding: EdgeInsets.symmetric(vertical: AppSizes.ph6),
                      child: Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(height: AppSizes.ph20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState?.validate() ?? false) {
                          register();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.r4),
                        ),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text("Sign Up"),
                    ),
                  ),
                  SizedBox(height: AppSizes.ph20),
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
