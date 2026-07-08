import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/datasource/local_data/servies/user_repository.dart';
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
    final user = UserRepository().getUser();
    userName = user?.name ?? "";
    countryName = user?.countryName;
    countryCode = user?.countryCode;
    safeNotify();
  }

  void saveCountry(Country selectedCountry) async {
    await UserRepository().updateUser(
      countryName: selectedCountry.name,
      countryCode: selectedCountry.countryCode,
    );

    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;
    safeNotify();
  }
}
