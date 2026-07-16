import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/models/user_model.dart';

class AuthRepository {
  AuthRepository(this.apiService);

  final ApiService apiService;

  Future<UserModel?> login({
    required String userName,
    required String password,
  }) async {
    final response = await apiService.post(
      ApiConfig.login,
      ApiConfig.baseUrlAuth,
      body: {"username": userName, "password": password, "expiresInMins": 30},
      token: UserRepository().getUser()?.accessToken,
    );
    final user = UserModel.fromAuth(response, userName);

    await _saveUser(user);
    return user ;
  }

  Future<void> _saveUser(UserModel user) async {
    await UserRepository().saveUser(user);
  }
}
