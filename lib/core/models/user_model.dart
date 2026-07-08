import 'package:hive_ce_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? password;

  @HiveField(3)
  String? countryName;
  @HiveField(4)
  String? countryCode;

  @HiveField(5)
  bool isLoggedIn;

  UserModel({
    required this.name,
    required this.email,
    this.password,
    this.countryName,
    this.countryCode,
    this.isLoggedIn = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'countryName': countryName,
      'countryCode': countryCode,
      'isLoggedIn': isLoggedIn,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      countryName: map['countryName'] as String,
      countryCode: map['countryCode'] as String,
      isLoggedIn: map['isLoggedIn'] as bool? ?? false,
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? countryName,
    String? countryCode,
    bool? isLoggedIn,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
