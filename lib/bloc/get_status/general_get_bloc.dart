import 'dart:async';

import 'package:flutter_base/bloc/get_status/general_get_event.dart';
import 'package:flutter_base/bloc/get_status/general_get_state.dart';
import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CekStatusBloc extends Bloc<CekStatusEvent, CekStatusState> {
  final UserRepository userRepository;

  CekStatusBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  CekStatusState get initialState => CekStatusEmpty();

  @override
  Stream<CekStatusState> mapEventToState(CekStatusEvent event) async* {
    if (event is CekStatusButtonPressed) {
      yield CekStatusLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String ktp = prefs.getString("ktp");
        final CekStatusResponse _general = await userRepository.cekStatus(
          ktp
        );
        if (_general.response.respCode == "00"){
          yield CekStatusInitial(status: _general);
        }else{
          yield CekStatusFailure(error: _general.response.respMessage);
        }
      } catch (error) {
        yield CekStatusFailure(error: error.toString());
      }
    }
  }
  
}
