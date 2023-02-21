part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class SignIn extends AuthEvent {
  final String email;
  final String password;

  SignIn(this.email, this.password);

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class LoadDetailAccount extends AuthEvent {
  @override
  List<Object?> get props => [];
}
