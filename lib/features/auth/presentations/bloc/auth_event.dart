import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthCheckEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthSignUpEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;

  AuthSignUpEvent({
    required this.userName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [userName,email, password];
}

class AuthLogoutEvent extends AuthEvent {}
