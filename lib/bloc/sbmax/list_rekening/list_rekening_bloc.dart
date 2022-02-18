import 'dart:async';
import 'dart:convert';


import 'package:flutter_base/bloc/sbmax/list_rekening/list_rekening_event.dart';
import 'package:flutter_base/bloc/sbmax/list_rekening/list_rekening_state.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_nominal/sbmax_nominal_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_nominal/sbmax_nominal_state.dart';
import 'package:flutter_base/model/response/list_rekening.dart';
import 'package:flutter_base/model/response/otp_response.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ListRekeningBloc extends Bloc<ListRekeningEvent, ListRekeningState> {
  final UserRepository userRepository;

  ListRekeningBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  ListRekeningState get initialState => ListRekeningInitial();

  @override
  Stream<ListRekeningState> mapEventToState(ListRekeningEvent event) async* {
    if (event is SubmittedListRekening) {
      yield ListRekeningLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        ListRekening token = await userRepository.listRekeningKoin(
          _token
        ); 
        print(token.response.respCode);
        if (token.response.respCode == "00"){
          yield ListRekeningInitial(listRekening: token);          
        }
        if (token.response.respCode != "00"){
          yield ListRekeningFailure(error: token.response.respMessage);
        }
        
      } catch (error) {
        yield ListRekeningFailure(error: error.toString());
      }
    }
  }
  
}



      