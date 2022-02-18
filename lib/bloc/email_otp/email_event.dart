import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class EmailEvent extends Equatable {
  const EmailEvent();

  @override
  List<Object> get props => [];
}

class EmailStarted extends EmailEvent {}

class EmailSuccess extends EmailEvent {
  final String phone;

  const EmailSuccess({@required this.phone});

  @override
  List<Object> get props => [phone];

  @override
  String toString() => 'EmailIn { token: $phone }';
}

class EmailError extends EmailEvent {}
class EmailChanged extends EmailEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}


class SubmittedEmail extends EmailEvent {
  final String email;
  final String ktp;
  final String imei;
  // final String otpCode;

  const SubmittedEmail({
    @required this.email,
    @required this.ktp,
    @required this.imei,
    // @required this.otpCode,
  });

  @override
  List<Object> get props => [email, ktp, imei];

  @override
  String toString() {
    return 'SubmittedEmail { email: $email, ktp: $ktp, imei: $imei }';
  }
}
