import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/auth/auth_state.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_event.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_state.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_state.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneOtpHandleBloc extends Bloc<PhoneOtpEvent, PhoneOtpState> {
  final UserRepository userRepository;

  PhoneOtpHandleBloc({@required this.userRepository}): assert(userRepository != null);

  @override
  // TODO: implement initialState
  PhoneOtpState get initialState => PhoneOtpUninitialized();

  @override
  Stream<PhoneOtpState> mapEventToState(PhoneOtpEvent event) async* {
    if (event is PhoneOtpStarted) {
    final bool hasEmail = await userRepository.hasEmail();

    if (hasEmail) {
        yield PhoneOtpAuthenticated();
      } else {
        yield PhoneOtpUnauthenticated();
      }
    }

    if (event is PhoneOtpSuccess) {
      yield PhoneOtpAuthLoading();
      await userRepository.persistEmail(event.phone);
      yield PhoneOtpAuthenticated();
    }

    if (event is PhoneOtpError) {
      yield PhoneOtpAuthLoading();
      await userRepository.deleteToken();
      yield PhoneOtpUnauthenticated();
    }
  }
}
