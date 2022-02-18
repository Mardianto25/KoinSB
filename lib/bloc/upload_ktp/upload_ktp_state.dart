import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UploadKtpState extends Equatable {
  const UploadKtpState();

  @override
  List<Object> get props => [];
}

class UploadKtpInitial extends UploadKtpState {}

class UploadKtpLoading extends UploadKtpState {}

class UploadKtpFailure extends UploadKtpState {
  final String error;

  const UploadKtpFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UploadKtpFailure { error: $error }';
}

class UploadKtpUninitialized extends UploadKtpState {}

class UploadKtpAuthenticated extends UploadKtpState {}

class UploadKtpUnauthenticated extends UploadKtpState {}

class UploadKtpAuthLoading extends UploadKtpState {}
