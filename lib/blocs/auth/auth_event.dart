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

class StoreUpdateAccount extends AuthEvent {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;

  StoreUpdateAccount(
    this.name,
    this.email,
    this.phone,
    this.address,
  );

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        address,
      ];
}
