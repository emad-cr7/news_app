import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/auth/sign_in_screen.dart';
import 'package:news_app/features/profile/profile_controller.dart';
import 'package:provider/provider.dart';
import '../../core/api/local_data/servies/preferences_manager.dart';
import '../../core/widget/custom_svg_picture.dart';
import 'bottom_sheet/profile_info_bottom_sheet.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileController>(
      create: (BuildContext context) => ProfileController()..getUserDate(),
      child: Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.h24,
            horizontal: AppSizes.w16,
          ),
          child: Consumer<ProfileController>(
            builder:
                (
                  BuildContext context,
                  ProfileController controller,
                  Widget? child,
                ) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,

                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    controller.selectedImage == null
                                    ? AssetImage("assets/images/profile.png")
                                    : FileImage(
                                        File(controller.selectedImage!.path),
                                      ),
                                radius: AppSizes.r60,
                                backgroundColor: Colors.transparent,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  showImageSourceDialog(context);
                                },
                                child: Container(
                                  width: AppSizes.w34,
                                  height: AppSizes.h34,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.r100,
                                    ),
                                    border: Border.all(
                                      color: Color(0xffD1DAD6),
                                    ),

                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                  ),
                                  child: Icon(Icons.camera_alt_outlined),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppSizes.h8),

                        Center(
                          child: Text(
                            PreferencesManager().getString("user_name") ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF161F1B),
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizes.h16),

                        _buildItem(
                          "Personal Info",
                          "assets/images/person.svg",
                          () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return ProfileInfoBottomSheet();
                              },
                            );
                          },
                        ),
                        _buildItem(
                          "Language",
                          "assets/images/language.svg",
                          () {},
                        ),
                        _buildItem(

                          controller.countryName ?? "Country",
                          "assets/images/Country.svg",
                          () {
                            showCountryPicker(
                              context: context,
                              onSelect: (Country country) {
                                controller.saveCountry(country);

                              },
                            );
                          },
                        ),
                        _buildItem(
                          "Terms & Conditions",
                          "assets/images/description.svg",
                          () {},
                        ),
                        _buildItem(
                          "Logout",
                          "assets/images/log_out.svg",
                          color: LightColor.primaryColor,
                          withDivider: false,
                          () async {
                            await PreferencesManager().clear();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
          ),
        ),
      ),
    );
  }
}

void showImageSourceDialog(BuildContext context) {
  final controller = context.read<ProfileController>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          "Choose Image Source",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              controller.pickImage(ImageSource.camera);
            },
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 8),
                Text("Camara"),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              controller.pickImage(ImageSource.gallery);
            },
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: 8),
                Text("Gallery"),
              ],
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildItem(
  String title,
  String path,
  Function onTap, {
  Color color = const Color(0xff161F1B),
  bool withDivider = true,
}) {
  return Column(
    children: [
      ListTile(
        onTap: () => onTap(),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: AppSizes.sp16,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: CustomSvgPicture.withColor(path: path),
        trailing: CustomSvgPicture.withColor(
          path: 'assets/images/chevron_right.svg',

          height: AppSizes.w16,
          width: AppSizes.w16,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.pw8),
      ),

      if (withDivider) Divider(color: Color(0xffD1DAD6)),
    ],
  );
}
