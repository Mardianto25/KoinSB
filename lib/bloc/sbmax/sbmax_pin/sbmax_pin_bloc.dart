import 'dart:async';
import 'dart:convert';
import 'package:flutter_base/bloc/sbmax/sbmax_pin/sbmax_pin_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pin/sbmax_pin_state.dart';
import 'package:flutter_base/model/response/otp_response.dart';
import 'package:flutter_base/model/response/sbmax_pin_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SbmaxPinBloc extends Bloc<SbmaxPinEvent, SbmaxPinState> {
  final UserRepository userRepository;

  SbmaxPinBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  SbmaxPinState get initialState => SbmaxPinInitial();

  @override
  Stream<SbmaxPinState> mapEventToState(SbmaxPinEvent event) async* {
    if (event is SubmittedPin) {
      yield SbmaxPinLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        SbmaxPinResponse token = await userRepository.pinVerify(
          event.imei, event.pin, _token
        ); 
        print(token.response.respCode);
        if (token.response.respCode == "00"){
          yield SbmaxPinInitial();          
        }
        if (token.response.respCode != "00"){
          yield SbmaxPinFailure(error: token.response.respMessage);
        }
        
      } catch (error) {
        yield SbmaxPinFailure(error: error.toString());
      }
    }
  }
  
}



      