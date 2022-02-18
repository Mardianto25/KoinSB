import 'dart:async';

import 'package:flutter_base/bloc/get_foto_profile/get_foto_profile_event.dart';
import 'package:flutter_base/bloc/get_foto_profile/get_foto_profile_state.dart';
import 'package:flutter_base/bloc/get_status/general_get_event.dart';
import 'package:flutter_base/bloc/get_status/general_get_state.dart';

import 'package:flutter_base/model/response/cek_status.dart';

import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/model/response/spesimen_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetFotoProfileBloc extends Bloc<GetFotoProfileEvent, GetFotoProfileState> {
  final UserRepository userRepository;

  GetFotoProfileBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  GetFotoProfileState get initialState => GetFotoProfileEmpty();

  @override
  Stream<GetFotoProfileState> mapEventToState(GetFotoProfileEvent event) async* {
    
    if (event is GetFotoProfileButtonPressed) {
      SpesimenResponse _general;
      yield GetFotoProfileLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
         _general = await userRepository.getFotoProfile(
          _token
        );
        if (_general.response.respCode == "00"){
          yield GetFotoProfileInitial(getFotoProfile: _general);
        }else if(_general.response.respCode == "04"){
          prefs.remove("token");
          yield GetFotoProfileFailure(error: _general.response.respMessage);
        }else{
          yield GetFotoProfileFailure(error: _general.response.respMessage);          
        }
      } catch (error) {
        yield GetFotoProfileFailure(error: error.toString());
      }
    }
  }
  
}
