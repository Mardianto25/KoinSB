import 'dart:async';

import 'package:flutter_base/bloc/personal_data/personal_data_event.dart';
import 'package:flutter_base/bloc/personal_data/personal_data_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PersonalDataBloc extends Bloc<PersonalDataEvent, PersonalDataState> {
  final UserRepository userRepository;

  PersonalDataBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  PersonalDataState get initialState => PersonalDataInitial();

  @override
  Stream<PersonalDataState> mapEventToState(PersonalDataEvent event) async* {
    if (event is PersonalDataButtonPressed) {
      yield PersonalDataLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        String _publicId = prefs.getString('publicId');
        String _type = prefs.getString('typePersonal');

        if(_type == "data_personal"){
          LoginResponse tokenUpdate = await userRepository.changePersonalData(
            event.dataPersonal,_publicId, _token
          );

          if (tokenUpdate.response.respCode =="00"){
            yield PersonalDataUpdateInitial();
            prefs.remove("typePersonal");

          }else{
            PersonalDataFailure(error: tokenUpdate.response.respMessage);
          }
        }else{
          LoginResponse token = await userRepository.updatePersonalData(
            event.dataPersonal,_publicId, _token
          );
          if (token.response.respCode =="00"){
            yield PersonalDataInitial();

          }else{
            PersonalDataFailure(error: token.response.respMessage);
          }

        }        

      } catch (error) {
        yield PersonalDataFailure(error: error.toString());
      }
    }
  }
  
}
