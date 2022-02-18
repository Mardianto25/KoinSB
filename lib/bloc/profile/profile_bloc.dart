import 'dart:async';

import 'package:flutter_base/bloc/get_status/general_get_event.dart';
import 'package:flutter_base/bloc/get_status/general_get_state.dart';
import 'package:flutter_base/bloc/profile/profile_event.dart';
import 'package:flutter_base/bloc/profile/profile_state.dart';
import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/profile.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/model/response/spesimen_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  ProfileState get initialState => ProfileEmpty();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    
    if (event is ProfileButtonPressed) {
      ProfileResponse _general;
      SpesimenResponse _foto;
      yield ProfileLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
         _general = await userRepository.getProfile(
          _token
        );
        _foto = await userRepository.getFotoProfile(
          _token
        );
        
        if (_general.response.respCode == "00" && _foto.response.respCode == "00"){
          yield ProfileInitial(profile: _general, foto: _foto);
        }else if(_general.response.respCode == "00" && _foto.response.respCode == "03"){
          yield ProfileInitial(profile: _general, foto: _foto);
        }else if(_general.response.respCode == "04"){
          prefs.remove("token");
          yield ProfileFailure(error: _general.response.respMessage, profile: _general);
        }else{
          yield ProfileFailure(error: _general.response.respMessage, profile: _general);          
        }
      } catch (error) {
        yield ProfileFailure(error: error.toString(), profile: _general);
      }
    }
  }
  
}
