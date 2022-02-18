import 'dart:async';

import 'package:flutter_base/bloc/member_data_save/member_data_save_event.dart';
import 'package:flutter_base/bloc/member_data_save/member_data_save_state.dart';
import 'package:flutter_base/bloc/show_data/show_data_event.dart';
import 'package:flutter_base/bloc/show_data/show_data_state.dart';
import 'package:flutter_base/model/response/login_cek_status.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/model/response/register_done.dart';
import 'package:flutter_base/model/response/show.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MemberDataSaveBloc extends Bloc<MemberDataSaveEvent, MemberDataSaveState> {
  final UserRepository userRepository;

  MemberDataSaveBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  MemberDataSaveState get initialState => MemberDataSaveInitial();

  @override
  Stream<MemberDataSaveState> mapEventToState(MemberDataSaveEvent event) async* {
    if (event is MemberDataButtonPressed) {
      yield MemberDataSaveLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        final LoginCekStatusResponse _general = await userRepository.cekStatusLogin(
          _token
        );
        print("tess ${_general.response.respCode}");
        if (_general.response.respCode == "00"){
          prefs.setString("loginStatus", _general.response.data.status);
          yield MemberDataSaveInitial();
        }else{
          yield MemberDataSaveFailure(error: _general.response.respMessage);
        }
      } catch (error) {
        yield MemberDataSaveFailure(error: error.toString());
      }
    }
  }
  
}
