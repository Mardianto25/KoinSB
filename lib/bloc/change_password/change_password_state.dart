import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordEmpty extends ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {
  // final LoginResponse changePassword;

  // const ChangePasswordInitial({@required this.changePassword});

  // @override
  // List<Object> get props => [changePassword];
}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordFailure extends ChangePasswordState {
  final String error;

  const ChangePasswordFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ChangePasswordFailure { error: $error }';
}
