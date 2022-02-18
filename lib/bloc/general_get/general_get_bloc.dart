import 'dart:async';

import 'package:flutter_base/bloc/general_get/general_get_event.dart';
import 'package:flutter_base/bloc/general_get/general_get_state.dart';
import 'package:flutter_base/bloc/personal_data/personal_data_event.dart';
import 'package:flutter_base/bloc/personal_data/personal_data_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GeneralGetBloc extends Bloc<GeneralGetEvent, GeneralGetState> {
  final UserRepository userRepository;

  GeneralGetBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  GeneralGetState get initialState => GeneralGetEmpty();

  @override
  Stream<GeneralGetState> mapEventToState(GeneralGetEvent event) async* {
    if (event is GetGeneralButtonPressed) {
      yield GeneralGetLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        String _publicId = prefs.getString('publicId');
        final General _general = await userRepository.getGeneral(
          event.choose, _publicId, _token
        );
        print("tess ${_general.response.respCode}");
        if (_general.response.respCode == "00"){
          yield GeneralGetInitial(general: _general.response);
        }else{
          yield GeneralGetFailure(error: _general.response.respMessage);
        }
      } catch (error) {
        yield GeneralGetFailure(error: error.toString());
      }
    }
  }
  
}
