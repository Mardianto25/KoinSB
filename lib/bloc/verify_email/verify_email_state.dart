import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class VerifyEmailState extends Equatable {
  const VerifyEmailState();

  @override
  List<Object> get props => [];
}

class VerifyEmailEmpty extends VerifyEmailState {}

class VerifyEmailInitial extends VerifyEmailState {
  // final String email;

  // const VerifyEmailInitial({@required this.email});

  // @override
  // List<Object> get props => [email];
}

class VerifyEmailLoading extends VerifyEmailState {}

class VerifyEmailFailure extends VerifyEmailState {
  final String error;

  const VerifyEmailFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'VerifyEmailFailure { error: $error }';
}
