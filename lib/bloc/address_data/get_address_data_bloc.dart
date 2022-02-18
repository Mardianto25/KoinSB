import 'dart:async';

import 'package:flutter_base/bloc/address_data/address_data_event.dart';
import 'package:flutter_base/bloc/address_data/address_data_state.dart';
import 'package:flutter_base/model/response/address_data_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetAddressDataBloc extends Bloc<AddressDataEvent, AddressDataState> {
  final UserRepository userRepository;

  GetAddressDataBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  AddressDataState get initialState => GetAddressDataDataEmpty();

  @override
  Stream<AddressDataState> mapEventToState(AddressDataEvent event) async* {
    if (event is GetAddressDataButtonPressed) {
      yield GetAddressDataDataLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        
        AddressDataResponse _general = await userRepository.getAddressData(
          event.type, _token
        );

        AddressDataResponse _general2 = await userRepository.getSecondAddressData(
          "second_address", _token
        );
        
        // if (_general2.response.respCode == "00"){
        //   yield GetSecondAddressDataDataInitial(dataAddress: _general);
        // }else{
        //   yield GetAddressDataDataFailure(error: _general2.response.respMessage);
        // }

        if (_general.response.respCode == "00" && _general2.response.respCode == "00"){
          yield GetAddressDataDataInitial(dataAddress: _general, secondAddress: _general2);
        }else{
          yield GetAddressDataDataFailure(error: _general.response.respMessage);
        }
      } catch (error) {
        yield GetAddressDataDataFailure(error: error.toString());
      }
    }
  }
  
}
