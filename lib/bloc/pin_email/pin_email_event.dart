import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PinEmailEvent extends Equatable {
  const PinEmailEvent();
  @override
  List<Object> get props => [];
}

class PinStarted extends PinEmailEvent {}

class PinEmailSuccess extends PinEmailEvent {
  final String email;

  const PinEmailSuccess({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailIn { token: $email }';
}

class PinEmailError extends PinEmailEvent {}


class PinEmailButtonPressed extends PinEmailEvent {
  final String email;
  final String ktp;
  final String imei;
  final String otpCode;
  final int otpId;

  const PinEmailButtonPressed({
    @required this.email,
    @required this.ktp,
    @required this.imei,
    @required this.otpCode,
    @required this.otpId,
  });

  @override
  List<Object> get props => [email, ktp, imei, otpCode, otpId];

  @override
  String toString() {
    return 'SubmittedEmail { email: $email, ktp: $ktp, imei: $imei, otpCode:$otpCode, otpId:$otpId }';
  }
  
}




