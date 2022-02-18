import 'dart:async';

import 'package:flutter_base/bloc/show_data/show_data_event.dart';
import 'package:flutter_base/bloc/show_data/show_data_state.dart';
import 'package:flutter_base/model/response/show.dart';
import 'package:flutter_base/model/response/spesimen_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ShowDataBloc extends Bloc<ShowDataEvent, ShowDataState> {
  final UserRepository userRepository;

  ShowDataBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  ShowDataState get initialState => ShowDataEmpty();

  @override
  Stream<ShowDataState> mapEventToState(ShowDataEvent event) async* {
    if (event is ShowDataButtonPressed) {
      yield ShowDataLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        String _publicId = prefs.getString('publicId');
        final ShowAll _general = await userRepository.getDataAll(
          event.publicId, _token
        );
        final SpesimenResponse _general2 = await userRepository.getSpesimen(
          _token
        );
        print("tess ${_general.response.respCode}");
        if (_general.response.respCode == "00" && _general2.response.respCode =="00"){
          yield ShowDataInitial(showAll: _general, spesimen: _general2);
        }else{
          yield ShowDataFailure(error: _general.response.respMessage);
        }
      } catch (error) {
        yield ShowDataFailure(error: error.toString());
      }
    }
  }
  
}
