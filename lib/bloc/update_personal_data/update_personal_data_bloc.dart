import 'dart:async';

import 'package:flutter_base/bloc/update_personal_data/update_personal_data_event.dart';
import 'package:flutter_base/bloc/update_personal_data/update_personal_data_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UpdatePersonalDataBloc extends Bloc<UpdatePersonalDataEvent, UpdatePersonalDataState> {
  final UserRepository userRepository;

  UpdatePersonalDataBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  UpdatePersonalDataState get initialState => UpdatePersonalDataInitial();

  @override
  Stream<UpdatePersonalDataState> mapEventToState(UpdatePersonalDataEvent event) async* {
    if (event is UpdatePersonalDataButtonPressed) {
      yield UpdatePersonalDataLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        String _publicId = prefs.getString('publicId');
        LoginResponse token = await userRepository.updatePersonalData(
          event.dataPersonal,_publicId, _token
        );
        if (token.response.respCode =="00"){
          yield UpdatePersonalDataInitial();

        }else{
          UpdatePersonalDataFailure(error: token.response.respMessage);
        }
      } catch (error) {
        yield UpdatePersonalDataFailure(error: error.toString());
      }
    }
  }
  
}
