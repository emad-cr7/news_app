import 'package:flutter/material.dart';
import 'package:news_app/features/main/main_screen.dart';
import '../../core/api/local_data/servies/preferences_manager.dart';
import '../../core/widget/Custom_text_from_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<FormState> _key = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? errorMessage;
  bool isLoading = false;



  void register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));

    final savedEmail = PreferencesManager().getString("user_email");

    if (savedEmail != null && savedEmail == emailController.text.trim()) {

      setState(() {
        errorMessage = "User Already Registered";
        isLoading = false;
      });

    } else {
      await PreferencesManager().setString("user_email", emailController.text);
      await PreferencesManager().setString("user_Password", passwordController.text);
      await PreferencesManager().setBool('is_logged_in', true);
      setState(() {
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
                      obscureText: false,
                      controller: emailController,
                      title: 'Email',
                      hint: 'Enter Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter  Email";
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
                    SizedBox(height: 12),
                    CustomTextFromField(
                      obscureText: true,
                      title: 'Confirm Password',
                      hint: 'Enter Confirm Password',
                      controller: confirmPasswordController,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Confirm Password";
                        }
                        if (value != passwordController.text) {
                          return "Password do Not Match";
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
                            register();
                          }
                        },
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text("Sign Up"),
                      ),
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have an account ?  "),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Sign In ",
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
