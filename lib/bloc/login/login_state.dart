import 'package:flutter_base/model/response/login_cek_status.dart';
import 'package:flutter_base/model/response/response_login.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}
class LoginEmpty extends LoginState {}
class LoginInitial extends LoginState {
  final ResponseLogin login;
  final LoginCekStatusResponse loginStatus;

  const LoginInitial({@required this.login,@required this.loginStatus });

  @override
  List<Object> get props => [login, loginStatus];
}

class LoginPikoInitial extends LoginState {
  final ResponseLogin login;

  const LoginPikoInitial({@required this.login});

  @override
  List<Object> get props => [login];
}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

// class LoginUninitialized extends LoginState {}

// class LoginAuthenticated extends LoginState {}

// class LoginUnauthenticated extends LoginState {}

// class LoginAuthLoading extends LoginState {}
