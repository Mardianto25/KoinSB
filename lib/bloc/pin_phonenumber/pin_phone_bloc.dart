import 'dart:async';


import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_event.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PinPhoneBloc extends Bloc<PinPhoneEvent, PinPhoneState> {
  final UserRepository userRepository;

  PinPhoneBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  PinPhoneState get initialState => PinPhoneInitial();

  @override
  Stream<PinPhoneState> mapEventToState(PinPhoneEvent event) async* {
    if (event is PinPhoneButtonPressed) {
      yield PinPhoneLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int _pikoStatus = prefs.getInt("pikoStatus");
        String _email = prefs.getString("email");
        String _password = prefs.getString("password");
        
        if(_pikoStatus == 1){
          LoginResponse tokenLogin = await userRepository.storeLoginOtp(
            event.phone, event.ktp, event.imei, event.otpCode, event.otpId, _pikoStatus, _email, _password
          );
          if(tokenLogin.status != 200){
            yield PinPhoneFailure(error: "internal error");            
          }else{
            if (tokenLogin.response.respCode == "00" || tokenLogin.response.respCode == "01"){
              yield PinPhonePikoInitial();
              prefs.remove("pikoStatus");
              
            }
            else {
              yield PinPhoneFailure(error: tokenLogin.response.respMessage);
            }

          }  
        }else{
          LoginResponse token = await userRepository.storePhoneOtp(
            event.phone, event.ktp, event.imei, event.otpCode, event.otpId
          );

          if (token.response.respCode == "00" || token.response.respCode == "01"){
            yield PinPhoneInitial();
          }
          else{
            yield PinPhoneFailure(error: token.response.respMessage);
          }
        }
        // yield PinPhoneInitial();
      } catch (error) {
        yield PinPhonePikoInitial();
        // yield PinPhoneFailure(error: error.toString());
      }
    }
  }
  
}
