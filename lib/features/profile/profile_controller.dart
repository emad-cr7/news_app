import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/models/user_model.dart';

import '../../core/datasource/local_data/preferences_manager.dart';

class ProfileController extends ChangeNotifier {
  XFile? selectedImage;

  String? name;
  String? countryCode;
  String? countryName;




  Future<void> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;

    selectedImage = image;

    await PreferencesManager().setString(
      "profile_image",
      image.path,
    );

    notifyListeners();
  }

  void getUserData() {
    final user = UserRepository().getUser();

    name = user?.name ?? "";
    countryName = user?.countryName;
    countryCode = user?.countryCode;

    final imagePath = PreferencesManager().getString("profile_image");

    if (imagePath != null) {
      selectedImage = XFile(imagePath);
    }

    notifyListeners();
  }

  Future<void> saveCountry(Country selectedCountry) async {
    await UserRepository().updateUser(
      countryName: selectedCountry.name,
      countryCode: selectedCountry.countryCode,
    );

    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;

    notifyListeners();
  }
}