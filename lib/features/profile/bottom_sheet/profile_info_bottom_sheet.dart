import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/models/user_model.dart';
import '../../../core/datasource/local_data/servies/user_repository.dart';
import '../../../core/widget/Custom_text_from_field.dart';

class ProfileInfoBottomSheet extends StatefulWidget {
  const ProfileInfoBottomSheet({super.key});

  @override
  State<ProfileInfoBottomSheet> createState() => _ProfileInfoBottomSheetState();
}

class _ProfileInfoBottomSheetState extends State<ProfileInfoBottomSheet> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _saveUserData();
  }

  void _loadUserData() {
    final UserModel? user = UserRepository().getUser();

    nameController.text = user?.name ?? "";
    emailController.text = user?.email ?? "";
  }

  void _saveUserData() async {
    if (_key.currentState?.validate() ?? false) {
      final user = UserModel(
        email: emailController.text,
        name: nameController.text,
      );
      await UserRepository().updateUser(
        name: nameController.text,
        email: emailController.text,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(AppSizes.r16),
          topRight: Radius.circular(AppSizes.r16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.h16),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.h16),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: AppSizes.h5,
                    width: AppSizes.w42,
                    decoration: BoxDecoration(
                      color: Color(0xff363636),
                      borderRadius: BorderRadiusGeometry.circular(
                        AppSizes.r100,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.h16),
                Text("Profile Info", style: TextStyle(fontSize: AppSizes.sp16)),
                SizedBox(height: AppSizes.h24),
                SizedBox(height: AppSizes.ph16),
                CustomTextFromField(
                  obscureText: false,
                  controller: nameController,
                  title: 'Name',
                  hint: 'Enter Name',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please Enter User Name";
                    }
                  },
                ),
                SizedBox(height: AppSizes.ph12),
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
                SizedBox(height: AppSizes.ph12),

                SizedBox(height: AppSizes.ph112),
                ElevatedButton(
                  onPressed: () {
                    _saveUserData();
                  },
                  child: Text("Save"),
                ),
                SizedBox(height: AppSizes.h16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
