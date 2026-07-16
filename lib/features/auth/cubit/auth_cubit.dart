import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/features/auth/repos/auth_reposatory.dart';

import '../../../core/enums/request_status_enum.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState());

  AuthRepository authRepository ;


  Future<void> login({required String userName, required String password})async {
    emit(state.copyWith(status: RequestStatusEnum.loading , errorMessage: null));




    await authRepository.login(userName: userName, password: password);
  }
}
