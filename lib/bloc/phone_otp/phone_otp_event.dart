import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PhoneOtpEvent extends Equatable {
  const PhoneOtpEvent();
  @override
  List<Object> get props => [];
}

class PhoneOtpStarted extends PhoneOtpEvent {}

class PhoneOtpSuccess extends PhoneOtpEvent {
  final String phone;

  const PhoneOtpSuccess({@required this.phone});

  @override
  List<Object> get props => [phone];

  @override
  String toString() => 'EmailIn { token: $phone }';
}

class PhoneOtpError extends PhoneOtpEvent {}


class PhoneOtpButtonPressed extends PhoneOtpEvent {
  final String phone;
  final String ktp;
  final String imei;
  // final String otpCode;

  const PhoneOtpButtonPressed({
    @required this.phone,
    @required this.ktp,
    @required this.imei,
    // @required this.otpCode,
  });

  @override
  List<Object> get props => [phone, ktp, imei];

  @override
  String toString() {
    return 'SubmittedPhoneOtp { email: $phone, ktp: $ktp, imei: $imei }';
  }
  
}




