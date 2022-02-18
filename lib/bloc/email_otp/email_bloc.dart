import 'dart:async';
import 'dart:convert';


import 'package:flutter_base/bloc/email_otp/email_event.dart';
import 'package:flutter_base/bloc/email_otp/email_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/model/response/otp_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final UserRepository userRepository;

  EmailBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  EmailState get initialState => EmailInitial();

  @override
  Stream<EmailState> mapEventToState(EmailEvent event) async* {
    if (event is SubmittedEmail) {
      yield EmailLoading();

      try {
        OtpResponse token = await userRepository.emailOtp(
          event.email, event.ktp, event.imei
        ); 
        print(token.response);
        if (token.response.respCode == "00"){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("email", event.email);
          prefs.setInt("otpIdEmail", token.response.data.otpId);
          yield EmailInitial();          
          
        }
        if (token.response.respCode != "00"){
          yield EmailFailure(error: token.response.respMessage);
        }
        
      } catch (error) {
        yield EmailFailure(error: error.toString());
      }
    }
  }
  
}



      