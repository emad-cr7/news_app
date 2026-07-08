import 'package:hive_ce_flutter/adapters.dart';
import '../../../constants/constant.dart';
import '../../../models/user_model.dart';

class UserRepository {
  UserRepository._internal();

  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() => _instance;

  Box<UserModel>? _userBox;

  Box<UserModel> get userBox {
    if (_userBox == null) {
      throw Exception("User not initialized");
    }
    return _userBox!;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }

    _userBox = await Hive.openBox<UserModel>(Constant.userBox);
  }

  Future<void> saveUser(UserModel user) async {
    await userBox.put(Constant.currentUser, user);
  }

  UserModel? getUser() {
    return _userBox?.get(Constant.currentUser);
  }

  bool get isLoggedIn => getUser()?.isLoggedIn ?? false;

  Future<void> updateUser({
    String? name,
    String? email,
    String? password,
    String? countryName,
    String? countryCode,
  }) async {
    final user = getUser();

    if (user != null) {
      final updatedUser = user.copyWith(
        name: name,
        email: email,
        password: password,
        countryName: countryName,
        countryCode: countryCode,
      );

      await saveUser(updatedUser);
    }
  }

  delete() async {
    await userBox.delete(Constant.currentUser);
  }

  clearAl() async {
    await userBox.clear();
  }

  Future<String?> login(String email, String password) async {
    final user = getUser();

    if (user == null) {
      return "No Account Found Please Register First";
    }
    if (user.email != email || user.password != password) {
      return "Incorrect Email or Password";
    }
    await saveUser(user.copyWith(isLoggedIn: true));
    return null;
  }

  Future<void> logout() async {
    final user = getUser();
    if (user != null) {
      await saveUser(user.copyWith(isLoggedIn: false));
    }
  }

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = getUser();

    if (user != null) {
      return "User Already Register";
    }
    final newUser = UserModel(
      name: name,
      email: email,
      password: password,
      isLoggedIn: true,
    );
    await saveUser(newUser);
    return null;
  }
}
