import 'dart:async';

import 'package:flutter_base/bloc/show_data/show_data_event.dart';
import 'package:flutter_base/bloc/show_data/show_data_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/model/response/show.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PostDataBloc extends Bloc<ShowDataEvent, ShowDataState> {
  final UserRepository userRepository;

  PostDataBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  ShowDataState get initialState => PostDataInitial();

  @override
  Stream<ShowDataState> mapEventToState(ShowDataEvent event) async* {
    if (event is PostDataButtonPressed) {
      yield PostDataLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        final LoginResponse _general = await userRepository.storeDataAll(
          event.publicId, _token
        );
        print("tess ${_general.response.respCode}");
        if (_general.response.respCode == "00"){
          yield PostDataInitial();
        }else{
          yield PostDataFailure(error: _general.response.respMessage);
        }
      } catch (error) {
        yield PostDataFailure(error: error.toString());
      }
    }
  }
  
}
