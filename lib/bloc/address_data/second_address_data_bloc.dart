import 'dart:async';

import 'package:flutter_base/bloc/address_data/address_data_event.dart';
import 'package:flutter_base/bloc/address_data/address_data_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SecondAddressDataBloc extends Bloc<AddressDataEvent, AddressDataState> {
  final UserRepository userRepository;

  SecondAddressDataBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  AddressDataState get initialState => AddressDataInitial();

  @override
  Stream<AddressDataState> mapEventToState(AddressDataEvent event) async* {
    if (event is SecondAddressButtonPressed) {
      yield SecondAddressDataLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        String _publicId = prefs.getString('publicId');
        String _type = prefs.getString('second_address');

        if (_type == "second_address"){
          LoginResponse tokenAddress = await userRepository.changeSecondAddress(
            event.dataAddress,_publicId, _token
          );
          if (tokenAddress.response.respCode =="00"){
            yield SecondAddressDataUpdateInitial();
            prefs.remove("second_address");
          }else{
            yield SecondAddressDataFailure(error: tokenAddress.response.respMessage);
          }
        }else{
          LoginResponse token = await userRepository.updateSecondAddress(
            event.dataAddress,_publicId, _token
          );
          if (token.response.respCode =="00"){
            yield SecondAddressDataInitial();
          }else{
            yield SecondAddressDataFailure(error: token.response.respMessage);
          }
        }
      } catch (error) {
        yield SecondAddressDataFailure(error: error.toString());
      }
    }
  }
  
}
