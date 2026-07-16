import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/register_screen.dart';
import 'package:news_app/features/auth/repos/auth_reposatory.dart';
import 'package:news_app/features/main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthCubit(AuthRepository(ApiService())),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_image.png"),
              ),
            ),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.status == RequestStatusEnum.loaded) {
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
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(AppSizes.r16),
                  child: Form(
                    key: _form,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/images/logo.png",
                                height: AppSizes.h45,
                              ),
                            ),
                            SizedBox(height: AppSizes.h40),
                            Text(
                              "Welcome to Newts",
                              style: TextStyle(
                                fontSize: AppSizes.sp20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              controller: userNameController,
                              hintText: 'usama@gmail.com',
                              title: 'Email',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Email";
                                }
                              },
                            ),
                            SizedBox(height: AppSizes.h24),
                            CustomTextFormField(
                              controller: passwordController,
                              hintText: '*************',
                              title: 'Password',
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Password";
                                }

                                return null;
                              },
                            ),

                            if (state.errorMessage != null)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSizes.ph8,
                                ),
                                child: Text(
                                  state.errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),

                            SizedBox(height: AppSizes.ph24),
                            SizedBox(
                              width: double.infinity,
                              height: AppSizes.h48,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_form.currentState?.validate() ?? false) {
                                    context.read<AuthCubit>().login(
                                      userName: userNameController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: state.status == RequestStatusEnum.loading
                                    ? const CircularProgressIndicator()
                                    : const Text("Sign In"),
                              ),
                            ),
                            SizedBox(height: AppSizes.ph24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don’t have an account ?",
                                  style: TextStyle(fontSize: AppSizes.sp14),
                                ),
                                SizedBox(width: AppSizes.pw8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return const RegisterScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: AppSizes.sp16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
