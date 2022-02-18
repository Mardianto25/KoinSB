import 'dart:async';

import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PinEmailBloc extends Bloc<PinEmailEvent, PinEmailState> {
  final UserRepository userRepository;

  PinEmailBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  PinEmailState get initialState => PinEmailInitial();

  @override
  Stream<PinEmailState> mapEventToState(PinEmailEvent event) async* {
    if (event is PinEmailButtonPressed) {
      yield PinEmailLoading();

      try {
        LoginResponse token = await userRepository.storeEmailOtp(
          event.email, event.ktp, event.imei, event.otpCode, event.otpId
        );
        
        if (token.response.respCode == "00" || token.response.respCode == "01"){
          yield PinEmailInitial();
        }
        else  {
          yield PinEmailFailure(error: token.response.respMessage);
        }
      } catch (error) {
        yield PinEmailFailure(error: error.toString());
      }
    }
  }
  
}
