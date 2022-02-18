import 'dart:async';

import 'package:flutter_base/bloc/update_address_data/update_address_data_event.dart';
import 'package:flutter_base/bloc/update_address_data/update_address_data_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UpdateAddressDataBloc extends Bloc<UpdateAddressDataEvent, UpdateAddressDataState> {
  final UserRepository userRepository;

  UpdateAddressDataBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  UpdateAddressDataState get initialState => UpdateAddressDataInitial();

  @override
  Stream<UpdateAddressDataState> mapEventToState(UpdateAddressDataEvent event) async* {
    if (event is UpdateAddressDataButtonPressed) {
      yield UpdateAddressDataLoading();

      try {
        print("bis"+event.dataAddress.alamatLengkap);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        String _publicId = prefs.getString('publicId');
        LoginResponse token = await userRepository.changeAddressData(
          event.dataAddress,_publicId, _token
        );
        yield UpdateAddressDataInitial();
      } catch (error) {
        yield UpdateAddressDataFailure(error: error.toString());
      }
    }
  }
  
}
