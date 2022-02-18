import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PhoneOtpState extends Equatable {
  const PhoneOtpState();

  @override
  List<Object> get props => [];
}

class PhoneOtpInitial extends PhoneOtpState {}

class PhoneOtpLoading extends PhoneOtpState {}

class PhoneOtpFailure extends PhoneOtpState {
  final String error;

  const PhoneOtpFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PhoneOtpFailure { error: $error }';
}

class PhoneOtpUninitialized extends PhoneOtpState {}

class PhoneOtpAuthenticated extends PhoneOtpState {}

class PhoneOtpUnauthenticated extends PhoneOtpState {}

class PhoneOtpAuthLoading extends PhoneOtpState {}
