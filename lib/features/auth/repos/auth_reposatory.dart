import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_config.dart';
import 'package:news_app/core/models/user_model.dart';

import '../../../core/datasource/remote_data/auth/auth_api_service.dart';

class AuthRepository {
  AuthRepository(this.apiService);

  final AuthBaseApiService apiService;

  Future<UserModel?> login({
    required String userName,
    required String password,
  }) async {
    final response = await apiService.post(
      AuthApiConfig.login,
      body: {"username": userName, "password": password, "expiresInMins": 30},
    );
    final user = UserModel.fromAuth(response, userName);

    await _saveUser(user);
    return user ;
  }

  Future<void> _saveUser(UserModel user) async {
    await UserRepository().saveUser(user);
  }
}
