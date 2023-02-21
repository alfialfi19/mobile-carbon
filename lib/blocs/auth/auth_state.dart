part of 'auth_bloc.dart';

abstract class AuthState extends BlocState {
  const AuthState({
    super.statusCode,
    super.message,
    super.errorCode,
  });
}

class AuthInitial extends AuthState {}

class SignInLoading extends AuthState {}

class SignInSuccess extends AuthState {
  final LoginResponse loginResponse;

  const SignInSuccess(this.loginResponse);
}

class SignInFailed extends AuthState {
  final GenericErrorResponse errorResponse;

  const SignInFailed(this.errorResponse);
}

class DetailAccountLoading extends AuthState {}

class DetailAccountLoaded extends AuthState {
  final AccountDetail accountDetail;

  const DetailAccountLoaded(this.accountDetail);
}

class DetailAccountError extends AuthState {
  final GenericErrorResponse errorResponse;

  const DetailAccountError(this.errorResponse);
}
