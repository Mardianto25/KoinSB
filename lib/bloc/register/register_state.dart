import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/register_response.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterEmpty extends RegisterState {}

class RegisterInitial extends RegisterState {
  final RegisterResponse register;

  const RegisterInitial({@required this.register});

  @override
  List<Object> get props => [register];

}

class StatusInitial extends RegisterState {
  final CekStatusResponse status;

  const StatusInitial({@required this.status});

  @override
  List<Object> get props => [status];

}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RegisterFailure { error: $error }';
}

class RegisterUninitialized extends RegisterState {}

class RegisterAuthenticated extends RegisterState {}

class RegisterUnauthenticated extends RegisterState {}

class RegisterAuthLoading extends RegisterState {}
