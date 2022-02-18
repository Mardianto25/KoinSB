import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PinPhoneEvent extends Equatable {
  const PinPhoneEvent();
  @override
  List<Object> get props => [];
}

class PinPhoneStarted extends PinPhoneEvent {}

class PinPhoneSuccess extends PinPhoneEvent {
  final String phone;

  const PinPhoneSuccess({@required this.phone});

  @override
  List<Object> get props => [phone];

  @override
  String toString() => 'EmailIn { token: $phone }';
}

class PinPhoneError extends PinPhoneEvent {}


class PinPhoneButtonPressed extends PinPhoneEvent {
  final String phone;
  final String ktp;
  final String imei;
  final String otpCode;
  final int otpId;
  

  const PinPhoneButtonPressed({
    @required this.phone,
    @required this.ktp,
    @required this.imei,
    @required this.otpCode,
    @required this.otpId,
    
  });

  @override
  List<Object> get props => [phone, ktp, imei, otpCode, otpId];

  @override
  String toString() {
    return 'SubmittedEmail { phone: $phone, ktp: $ktp, imei: $imei, otpCode:$otpCode }';
  }
  
}




