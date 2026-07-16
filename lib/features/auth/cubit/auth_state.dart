part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final RequestStatusEnum status;
  final UserModel? userModel;
  final String? errorMessage;
  final bool isLoading;

  AuthState({
    this.status = RequestStatusEnum.initial,
    this.userModel,
    this.errorMessage,
     this.isLoading = false,
  });

  AuthState copyWith({
    RequestStatusEnum? status,
    UserModel? userModel,
    String? errorMessage,
    bool? isLoading,
  }) {
    return AuthState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [status, userModel, errorMessage, isLoading];
}
