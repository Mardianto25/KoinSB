import 'dart:async';


import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_event.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_state.dart';
import 'package:flutter_base/bloc/set_password/set_password_event.dart';
import 'package:flutter_base/bloc/set_password/set_password_state.dart';
import 'package:flutter_base/bloc/store_rekening_coin/store_rekening_coin_event.dart';
import 'package:flutter_base/bloc/store_rekening_coin/store_rekening_coin_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/model/response/rekeing_coin.dart';
import 'package:flutter_base/model/response/response_login.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StoreRekeningCoinBloc extends Bloc<StoreRekeningCoinEvent, StoreRekeningCoinState> {
  final UserRepository userRepository;
  // final AuthenticationBloc authenticationBloc;

  StoreRekeningCoinBloc({
    @required this.userRepository,
    // @required this.authenticationBloc,
  })  : assert(userRepository != null);
  // , assert(authenticationBloc != null);
  StoreRekeningCoinState get initialState => StoreRekeningCoinEmpty();

  @override
  Stream<StoreRekeningCoinState> mapEventToState(StoreRekeningCoinEvent event) async* {
    if (event is StoreRekeningCoinButtonPressed) {
      yield StoreRekeningCoinLoading();

      try {
        RekeningCoin token = await userRepository.cekMember(
          event.rekening
        );

        if (token.response.respCode == "00"){
          yield StoreRekeningCoinInitial(dataRekening: token);

        }
        else {
          yield StoreRekeningCoinFailure(error: token.response.respMessage.toString());
          
        }
        
      } catch (error) {
        yield StoreRekeningCoinFailure(error: error.toString());
      }
    }
  }
  
}
