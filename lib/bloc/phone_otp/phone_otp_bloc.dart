import 'dart:async';

import 'package:flutter_base/bloc/phone_otp/phone_otp_event.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/model/response/otp_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PhoneOtpBloc extends Bloc<PhoneOtpEvent, PhoneOtpState> {
  final UserRepository userRepository;

  PhoneOtpBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  PhoneOtpState get initialState => PhoneOtpInitial();

  @override
  Stream<PhoneOtpState> mapEventToState(PhoneOtpEvent event) async* {
    if (event is PhoneOtpButtonPressed) {
      yield PhoneOtpLoading();

      try {
        OtpResponse token = await userRepository.phoneOtp(
          event.phone, event.ktp, event.imei
        );
        yield PhoneOtpLoading();  
        if (token.response.respCode == "00"){
          yield PhoneOtpInitial();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('phonenumber', event.phone);
          prefs.setInt("otpIdPhone", token.response.data.otpId);
        }
        if (token.response.respCode != "00") {
          yield PhoneOtpFailure(error: token.response.respMessage);
        }
          
          // yield PhoneOtpInitial();
      } catch (error) {
        yield PhoneOtpFailure(error: error.toString());
      }
    }
  }
  
}
