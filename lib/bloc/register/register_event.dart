import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterStarted extends RegisterEvent {}

class RegisterSuccess extends RegisterEvent {
  final String phone;

  const RegisterSuccess({@required this.phone});

  @override
  List<Object> get props => [phone];

  @override
  String toString() => 'EmailIn { token: $phone }';
}

class RegisterError extends RegisterEvent {}


class KtpChanged extends RegisterEvent {
  final String ktp;

  const KtpChanged({@required this.ktp});

  @override
  List<Object> get props => [ktp];

  @override
  String toString() => 'KtpChanged { ktp :$ktp }';
}

class FirstNameChanged extends RegisterEvent {
  final String firstName;

  const FirstNameChanged({@required this.firstName});

  @override
  List<Object> get props => [firstName];

  @override
  String toString() => 'FirstNameChanged { firstName: $firstName }';
}

class LastNameChanged extends RegisterEvent {
  final String lastName;

  const LastNameChanged({@required this.lastName});

  @override
  List<Object> get props => [lastName];

  @override
  String toString() => 'LastNameChanged { firstName: $lastName }';
}

class SubmittedRegister extends RegisterEvent {
  final String ktp;
  final String firstName;
  final String lastName;  
  final String imei;
  final String oneSignal;

  const SubmittedRegister({
    @required this.ktp,
    @required this.firstName,
    @required this.lastName,
    @required this.imei,
    @required this.oneSignal,
    
  });

  @override
  List<Object> get props => [ktp, firstName, lastName , imei, oneSignal];

  @override
  String toString() {
    return 'Submitted { email: $lastName, firstName: $firstName, lastName: $lastName, imei: $imei. onesignal: $oneSignal }';
  }
}
