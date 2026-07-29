import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class ProfileInfoBottomSheet extends StatefulWidget {
  const ProfileInfoBottomSheet({super.key});

  @override
  State<ProfileInfoBottomSheet> createState() => _ProfileInfoBottomSheetState();
}

class _ProfileInfoBottomSheetState extends State<ProfileInfoBottomSheet> {
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    final currentUser = UserRepository().getUser();
    usernameController.text = currentUser?.name ?? '';
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizes.r16),
            topRight: Radius.circular(AppSizes.r16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: AppSizes.w42,
                      height: AppSizes.h4,
                      decoration: BoxDecoration(
                        color: Color(0xFF363636),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.ph16),
                  Text(
                    "Profile Info",
                    style: TextStyle(
                      fontSize: AppSizes.sp16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CustomTextFormField(
                    controller: usernameController,
                    hintText: 'Ahmed Ibrahim',
                    title: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSizes.ph60),
                  ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        await UserRepository().updateUser(
                          name: usernameController.text.trim(),
                        );
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Save"),
                  ),
                  SizedBox(height: AppSizes.ph16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}