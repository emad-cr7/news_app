import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/features/auth/repos/auth_reposatory.dart';

import '../../../core/enums/request_status_enum.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState());

  AuthRepository authRepository;

  Future<void> login({
    required String userName,
    required String password,
  }) async {

    try{
      emit(state.copyWith(status: RequestStatusEnum.loading, errorMessage: null));

      final userModel = await authRepository.login(
        userName: userName,
        password: password,
      );
      if (userModel != null) {
        emit(
          state.copyWith(status: RequestStatusEnum.loaded, userModel: userModel),
        );
      } else {
        emit(
          state.copyWith(
            status: RequestStatusEnum.error,
            errorMessage: "Invalid credentials",
          ),
        );
      }
    }catch(e){
      emit(
        state.copyWith(
          status: RequestStatusEnum.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
