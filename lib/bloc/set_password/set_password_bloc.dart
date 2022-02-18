import 'dart:async';


import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_event.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_state.dart';
import 'package:flutter_base/bloc/set_password/set_password_event.dart';
import 'package:flutter_base/bloc/set_password/set_password_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/model/response/response_login.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SetPasswordBloc extends Bloc<SetPasswordEvent, SetPasswordState> {
  final UserRepository userRepository;
  // final AuthenticationBloc authenticationBloc;

  SetPasswordBloc({
    @required this.userRepository,
    // @required this.authenticationBloc,
  })  : assert(userRepository != null);
  // , assert(authenticationBloc != null);
  SetPasswordState get initialState => SetPasswordInitial();

  @override
  Stream<SetPasswordState> mapEventToState(SetPasswordEvent event) async* {
    if (event is SetPasswordButtonPressed) {
      yield SetPasswordLoading();

      try {
        ResponseLogin token = await userRepository.setPassword(
          event.ktp, event.imei, event.phone, event.email, event.name, event.password, event.isAnggota
        );

        yield SetPasswordLoading();
        if (token.response.respCode == "00"){
          yield SetPasswordInitial();
          
          String tokenAdd = token.response.data.token;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', tokenAdd);
          prefs.setString('publicId', token.response.data.publicId);
          
          // authenticationBloc.add(LoggedIn(token: tokenAdd.toString()));
        }
        else {
          yield SetPasswordFailure(error: token.response.respMessage.toString());
        }
        
      } catch (error) {
        yield SetPasswordFailure(error: error.toString());
      }
    }
  }
  
}
