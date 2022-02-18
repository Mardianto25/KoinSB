import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}


class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends LoginEvent {
  final String username;
  final String password;
  final String imei;

  const Submitted({
    @required this.username,
    @required this.password,
    @required this.imei,
  });

  @override
  List<Object> get props => [username, password, imei];

  @override
  String toString() {
    return 'Submitted { email: $username, password: $password, imei: $imei }';
  }
}
