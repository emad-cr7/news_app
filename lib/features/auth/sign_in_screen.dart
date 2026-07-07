import 'package:flutter/material.dart';
import 'package:news_app/features/auth/register_screen.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/datasource/local_data/servies/user_repository.dart';
import '../../core/widget/Custom_text_from_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  bool isLoading = false;
  String? errorMessage;
  bool isPassword = false;

  void login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));
   final String? error = UserRepository().login(emailController.text, passwordController.text) ;



    if (error != null ) {
      setState(() {
        errorMessage = error;
        isLoading = false;
      });
      return;
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
            padding:  EdgeInsets.all(AppSizes.w16),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height:AppSizes.h45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height:AppSizes.ph24),
                  Text(
                    "Welcome to Newts",
                    style: TextStyle(
                      color: Color(0XFF363636),
                      fontSize:AppSizes.sp20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height:AppSizes.ph16),
                  CustomTextFromField(
                    obscureText: false,
                    controller: emailController,
                    title: 'Email',
                    hint: 'Enter your email',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your email";
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
                  SizedBox(height:AppSizes.ph12),
                  CustomTextFromField(
                    obscureText: isPassword ? false : true,
                    controller: passwordController,
                    title: 'Password',
                    hint: 'Please enter your password',
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

                  if (errorMessage != null)
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical:AppSizes.pw6),
                      child: Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(height:AppSizes.ph20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState?.validate() ?? false) {
                          login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.r4),
                        ),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text("Sign In"),
                    ),
                  ),
                  SizedBox(height:AppSizes.ph20),
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
      ),
    );
  }
}