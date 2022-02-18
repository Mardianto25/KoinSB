import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/model/response/otp_response.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ChangeEmailState extends Equatable {
  const ChangeEmailState();

  @override
  List<Object> get props => [];
}

class ChangeEmailEmpty extends ChangeEmailState {}

class ChangeEmailInitial extends ChangeEmailState {
  final OtpResponse dataRes;

  const ChangeEmailInitial({@required this.dataRes});

  @override
  List<Object> get props => [dataRes];
}

class ChangeEmailLoading extends ChangeEmailState {}

class ChangeEmailFailure extends ChangeEmailState {
  final String error;

  const ChangeEmailFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ChangeEmailFailure { error: $error }';
}
