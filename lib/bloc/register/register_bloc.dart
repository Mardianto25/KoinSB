import 'dart:async';
import 'dart:convert';


import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_state.dart';
import 'package:flutter_base/bloc/register/register_event.dart';
import 'package:flutter_base/bloc/register/register_state.dart';
import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/register_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  RegisterState get initialState => RegisterEmpty();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is SubmittedRegister) {
      yield RegisterLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _ktp = prefs.getString("ktp");

        // if(_ktp != "" || _ktp != null){
        //   CekStatus tokenStatus = await userRepository.cekStatus(
        //     _ktp
        //   );
        //   if (tokenStatus.response.respCode == "00"){
        //     yield StatusInitial(status: tokenStatus);
        //   }
        //   else {
        //     yield RegisterFailure(error: tokenStatus.response.respMessage);
        //   }
        // }else{
          RegisterResponse token = await userRepository.register(
            event.ktp, event.firstName, event.lastName, event.imei, event.oneSignal
          ); 
          print(token.status);
          if (token.response.respCode == "00"){
            prefs.setString("ktp", event.ktp);
            prefs.setString("imei", event.imei);
            prefs.setString("name", event.firstName +" "+ event.lastName);
            if (token.response.data == null){
              prefs.setInt("pikoStatus", 0);
            }else if(token.response.data != null){
              prefs.setInt("pikoStatus", token.response.data.pikoStatus);            
            }
            yield RegisterInitial(register: token);
          }else if(token.response.respCode == "01"){
            if(token.response.data.pikoStatus == 1){
              prefs.setString("ktp", event.ktp);
              prefs.setString("imei", event.imei);
              prefs.setString("name", event.firstName +" "+ event.lastName);
              prefs.setInt("pikoStatus", token.response.data.pikoStatus);                          
              yield RegisterInitial(register: token);
            }else{
              yield RegisterFailure(error: token.response.respMessage);

            }
          }else if(token.response.respCode == "02"){
             if(token.response.data.pikoStatus == 1){
              prefs.setString("ktp", event.ktp);
              prefs.setString("imei", event.imei);
              prefs.setString("name", event.firstName +" "+ event.lastName);
              prefs.setInt("pikoStatus", token.response.data.pikoStatus);                          
              yield RegisterInitial(register: token);
            }else{
              yield RegisterFailure(error: token.response.respMessage);

            }
          }else if(token.response.respCode == "03"){
             if(token.response.data.pikoStatus == 1){
              prefs.setString("ktp", event.ktp);
              prefs.setString("imei", event.imei);
              prefs.setString("name", event.firstName +" "+ event.lastName);
              prefs.setInt("pikoStatus", token.response.data.pikoStatus);                          
              yield RegisterInitial(register: token);
            }else{
              yield RegisterFailure(error: token.response.respMessage);

            }
          }else if(token.response.respCode == "04"){
             if(token.response.data.pikoStatus == 1){
              prefs.setString("ktp", event.ktp);
              prefs.setString("imei", event.imei);
              prefs.setString("name", event.firstName +" "+ event.lastName);
              prefs.setInt("pikoStatus", token.response.data.pikoStatus);                          
              yield RegisterInitial(register: token);
            }else{
              yield RegisterFailure(error: token.response.respMessage);

            }
          }

        // }
        
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
    }
  }
  
}



      