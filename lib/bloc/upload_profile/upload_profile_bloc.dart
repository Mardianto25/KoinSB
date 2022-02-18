import 'dart:async';

import 'package:flutter_base/bloc/upload_profile/upload_profile_event.dart';
import 'package:flutter_base/bloc/upload_profile/upload_profile_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UploadProfileBloc extends Bloc<UploadProfileEvent, UploadProfileState> {
  final UserRepository userRepository;

  UploadProfileBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  UploadProfileState get initialState => UploadProfileInitial();

  @override
  Stream<UploadProfileState> mapEventToState(UploadProfileEvent event) async* {
    if (event is UploadProfileButtonPressed) {
      yield UploadProfileLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        LoginResponse token = await userRepository.uploadProfile(
          event.uploadProfile, _token
        );
        yield UploadProfileLoading();  
        if (token.response.respCode == "00"){
          yield UploadProfileInitial();
        }
        else {
          yield UploadProfileFailure(error: token.response.respMessage);
        }
          // yield UploadProfileInitial();
      } catch (error) {
        yield UploadProfileFailure(error: error.toString());
      }
    }
  }
  
}
