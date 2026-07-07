import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/datasource/local_data/servies/preferences_manager.dart';
import '../../core/mixins/safe_notify_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotifyMixin {
  XFile? selectedImage;
  String? userName;

  String? countryName;

  String? countryCode;



  void pickImage(ImageSource source) async {
    selectedImage = await ImagePicker().pickImage(source: source);
    safeNotify();
  }

  void getUserDate() {
    userName = PreferencesManager().getString("user_name") ?? "";
    countryName = PreferencesManager().getString("country_name");
    countryCode = PreferencesManager().getString("country_code");
    safeNotify();
  }

  void saveCountry(Country selectedCountry) async {
    await PreferencesManager().setString("country_name", selectedCountry.name);
    await PreferencesManager().setString("country_code", selectedCountry.countryCode,);

    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;
    safeNotify();
  }
}
