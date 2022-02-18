import 'dart:async';

import 'package:flutter_base/bloc/change_password/change_password_event.dart';
import 'package:flutter_base/bloc/change_password/change_password_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserRepository userRepository;

  ChangePasswordBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  ChangePasswordState get initialState => ChangePasswordEmpty();

  @override
  Stream<ChangePasswordState> mapEventToState(ChangePasswordEvent event) async* {
    if (event is ChangePasswordButtonPressed) {
      yield ChangePasswordLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        String _imei = prefs.getString("imei");
        final LoginResponse _general = await userRepository.changePass(
          _imei, event.oldPass, event.newPass, _token
        );
        if (_general.response.respCode == "00"){
          yield ChangePasswordInitial();
        }else{
          yield ChangePasswordFailure(error: _general.response.respMessage);
        }
      } catch (error) {
        yield ChangePasswordFailure(error: error.toString());
      }
    }
  }
  
}
