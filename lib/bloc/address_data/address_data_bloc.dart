import 'dart:async';

import 'package:flutter_base/bloc/address_data/address_data_event.dart';
import 'package:flutter_base/bloc/address_data/address_data_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddressDataBloc extends Bloc<AddressDataEvent, AddressDataState> {
  final UserRepository userRepository;

  AddressDataBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  AddressDataState get initialState => AddressDataInitial();

  @override
  Stream<AddressDataState> mapEventToState(AddressDataEvent event) async* {
    if (event is AddressDataButtonPressed) {
      yield AddressDataLoading();

      try {
        print("bis"+event.dataAddress.alamatLengkap);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        String _publicId = prefs.getString('publicId');
        String _type = prefs.getString('typeAddress');

        if (_type == "address"){
          LoginResponse tokenAddress = await userRepository.changeAddressData(
            event.dataAddress,_publicId, _token
          );
          if (tokenAddress.response.respCode =="00"){
            yield AddressDataUpdateInitial();
            prefs.remove("typeAddress");

          }else{
            AddressDataFailure(error: tokenAddress.response.respMessage);
          }
        }else{
          LoginResponse token = await userRepository.updateAddressData(
            event.dataAddress,_publicId, _token
          );

          if (token.response.respCode =="00"){
            yield AddressDataInitial();

          }else{
            AddressDataFailure(error: token.response.respMessage);
          }

        }


      } catch (error) {
        yield AddressDataFailure(error: error.toString());
      }
    }
  }
  
}
