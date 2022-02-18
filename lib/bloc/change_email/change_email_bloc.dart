import 'dart:async';

import 'package:flutter_base/bloc/change_email/change_email_event.dart';
import 'package:flutter_base/bloc/change_email/change_email_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/model/response/otp_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChangeEmailBloc extends Bloc<ChangeEmailEvent, ChangeEmailState> {
  final UserRepository userRepository;

  ChangeEmailBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  ChangeEmailState get initialState => ChangeEmailEmpty();

  @override
  Stream<ChangeEmailState> mapEventToState(ChangeEmailEvent event) async* {
    if (event is ChangeEmailButtonPressed) {
      yield ChangeEmailLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        final OtpResponse _general = await userRepository.sentEmail(
          event.email,_token
        );
        if (_general.response.respCode == "00" || _general.response.respCode == "01"){
          yield ChangeEmailInitial(dataRes: _general);
        }else{
          yield ChangeEmailFailure(error: _general.response.respMessage);
        }
      } catch (error) {
        yield ChangeEmailFailure(error: error.toString());
      }
    }
  }
  
}
