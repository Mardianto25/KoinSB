import 'dart:async';

import 'package:flutter_base/bloc/cek_fitur_coin/cek_fitur_coin_event.dart';
import 'package:flutter_base/bloc/cek_fitur_coin/cek_fitur_coin_state.dart';
import 'package:flutter_base/bloc/get_status/general_get_event.dart';
import 'package:flutter_base/bloc/get_status/general_get_state.dart';
import 'package:flutter_base/model/response/cek_fitur_coin.dart';
import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CekFiturCoinBloc extends Bloc<CekFiturCoinEvent, CekFiturCoinState> {
  final UserRepository userRepository;

  CekFiturCoinBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  CekFiturCoinState get initialState => CekFiturCoinEmpty();

  @override
  Stream<CekFiturCoinState> mapEventToState(CekFiturCoinEvent event) async* {
    if (event is CekFiturCoinButtonPressed) {
      yield CekFiturCoinLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString("token");
        final CekFiturCoin _general = await userRepository.cekFiturCoin(
          _token
        );
        if (_general.response.respCode == "00"){
          yield CekFiturCoinInitial(status: _general);
        }else{
          yield CekFiturCoinFailure(error: _general.response.respMessage);
        }
      } catch (error) {
        yield CekFiturCoinFailure(error: error.toString());
      }
    }
  }
  
}
