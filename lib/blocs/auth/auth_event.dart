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

class SignInGoogle extends AuthEvent {
  final String? email;
  final String? fullName;
  final String? idExternal;
  final String? token;

  SignInGoogle(
    this.email,
    this.fullName,
    this.idExternal,
    this.token,
  );

  @override
  List<Object?> get props => [
        email,
        fullName,
        idExternal,
        token,
      ];
}

class Register extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  Register(this.fullName, this.email, this.password);

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
      ];
}

class ForgetPassword extends AuthEvent {
  final String email;

  ForgetPassword(this.email);

  @override
  List<Object?> get props => [
        email,
      ];
}

class LoadDetailAccount extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class StoreUpdateAccount extends AuthEvent {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? filePath;

  StoreUpdateAccount(
    this.name,
    this.email,
    this.phone,
    this.address,
    this.filePath,
  );

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        address,
        filePath,
      ];
}
