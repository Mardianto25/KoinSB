import 'dart:async';

import 'package:flutter_base/bloc/personal_data/personal_data_event.dart';
import 'package:flutter_base/bloc/personal_data/personal_data_state.dart';
import 'package:flutter_base/model/response/data_personal_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetPersonalDataBloc extends Bloc<PersonalDataEvent, PersonalDataState> {
  final UserRepository userRepository;

  GetPersonalDataBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  PersonalDataState get initialState => GetPersonalDataDataInitial();

  @override
  Stream<PersonalDataState> mapEventToState(PersonalDataEvent event) async* {
    if (event is GetPersonalDataButtonPressed) {
      yield GetPersonalDataDataLoading();
      PersonalDataResponse _general;

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        _general = await userRepository.getPersonalData(
          event.type, _token
        );
        if (_general.response.respCode == "00"){
          yield GetPersonalDataDataInitial(dataPersonal: _general);
        }else{
          yield GetPersonalDataDataFailure(error: _general.response.respMessage, dataPersonal: _general);
        }
      } catch (error) {
        yield GetPersonalDataDataFailure(error: error.toString(), dataPersonal: _general);
      }
    }
  }
  
}
