import 'dart:async';


import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_event.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_state.dart';
import 'package:flutter_base/bloc/set_password/set_password_event.dart';
import 'package:flutter_base/bloc/set_password/set_password_state.dart';
import 'package:flutter_base/bloc/upload_ktp/upload_ktp_event.dart';
import 'package:flutter_base/bloc/upload_ktp/upload_ktp_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UploadKtpBloc extends Bloc<UploadKtpEvent, UploadKtpState> {
  final UserRepository userRepository;

  UploadKtpBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  UploadKtpState get initialState => UploadKtpInitial();

  @override
  Stream<UploadKtpState> mapEventToState(UploadKtpEvent event) async* {
    if (event is UploadKtpButtonPressed) {
      yield UploadKtpLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        print("Ini Bloc"+_token);
        LoginResponse token = await userRepository.uploadKtp(
          event.usersFile, _token
        );
        yield UploadKtpLoading();  
        if (token.response.respCode == "00"){
          yield UploadKtpInitial();
        }
        else {
          yield UploadKtpFailure(error: token.response.respMessage);
        }

      } catch (error) {
        yield UploadKtpFailure(error: error.toString());
      }
    }
  }
  
}
