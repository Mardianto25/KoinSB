import 'dart:async';

import 'package:flutter_base/bloc/verify_email/verify_email_event.dart';
import 'package:flutter_base/bloc/verify_email/verify_email_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final UserRepository userRepository;

  VerifyEmailBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  VerifyEmailState get initialState => VerifyEmailEmpty();

  @override
  Stream<VerifyEmailState> mapEventToState(VerifyEmailEvent event) async* {
    if (event is VerifyEmailButtonPressed) {
      yield VerifyEmailLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        final LoginResponse _general = await userRepository.verifyEmail(
          event.email, event.otpCode, event.otpId, _token
        );
        if (_general.response.respCode == "00"){
          yield VerifyEmailInitial();
        }else{
          yield VerifyEmailFailure(error: _general.response.respMessage);
        }
      } catch (error) {
        yield VerifyEmailFailure(error: error.toString());
      }
    }
  }
  
}
