import 'package:flutter_base/model/content/personal_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class VerifyEmailEvent extends Equatable {
  const VerifyEmailEvent();
  @override
  List<Object> get props => [];
}

class VerifyEmailStarted extends VerifyEmailEvent {}

class VerifyEmailSuccess extends VerifyEmailEvent {
  
}

class VerifyEmailError extends VerifyEmailEvent {}


class VerifyEmailButtonPressed extends VerifyEmailEvent {
  final String email;
  final String otpCode;
  final int otpId;
  

  const VerifyEmailButtonPressed({
    @required this.email,
    @required this.otpCode,
    @required this.otpId    
  });

  @override
  List<Object> get props => [email, otpCode, otpId];

  @override
  String toString() {
    return 'Submitted { param: $email, $otpCode, $otpId}';
  }
}



