import 'dart:async';

import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/login/login_event.dart';
import 'package:flutter_base/bloc/login/login_state.dart';
import 'package:flutter_base/model/response/login_cek_status.dart';
import 'package:flutter_base/model/response/response_login.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null)
  , assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Submitted) {
      yield LoginLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int _pikoStatus = prefs.getInt("pikoStatus");
        String ktp = prefs.getString("ktp");
        if(_pikoStatus == 1){
          ResponseLogin tokenPiko = await userRepository.loginPiko(
            ktp, event.username, event.password, event.imei, _pikoStatus
          ); 
          if (tokenPiko.response.respCode == "00"){
            String tokenAddPiko = tokenPiko.response.data.token;
            prefs.setString('token', tokenAddPiko);
            prefs.setString('password', event.password);
            prefs.setString("imei", event.imei);
            yield LoginPikoInitial(login: tokenPiko);
          }
          else {
            yield LoginFailure(error: tokenPiko.response.respMessage.toString());
          }
        }else{
          ResponseLogin token = await userRepository.login(
            event.username, event.password, event.imei
          ); 
          if (token.response.respCode == "00"){
            String tokenAdd = token.response.data.token;
            prefs.setString('token', tokenAdd);
            prefs.setString("imei", event.imei);            
            String tokenAccess = prefs.getString("token");
            // yield LoginInitial(login: token);
            
            LoginCekStatusResponse cekStatus = await userRepository.cekStatusLogin(
              tokenAccess
            ); 
            if (cekStatus.response.respCode =="00"){
              print(tokenAccess);
              authenticationBloc.add(LoggedIn(token: tokenAccess));
              yield LoginInitial(login: token, loginStatus: cekStatus);

            }else{
              yield LoginFailure(error: token.response.respMessage.toString());
              
            }
                        
          }
          else {
            yield LoginFailure(error: token.response.respMessage.toString());
          }

        }
        
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
  
}
