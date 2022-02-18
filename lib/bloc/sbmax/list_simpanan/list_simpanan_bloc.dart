import 'dart:async';
import 'dart:convert';

import 'package:flutter_base/bloc/sbmax/list_simpanan/list_simpanan_event.dart';
import 'package:flutter_base/bloc/sbmax/list_simpanan/list_simpanan_state.dart';
import 'package:flutter_base/model/response/list_simpanan.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ListSimpananBloc extends Bloc<ListSimpananEvent, ListSimpananState> {
  final UserRepository userRepository;

  ListSimpananBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  ListSimpananState get initialState => ListSimpananInitial();

  @override
  Stream<ListSimpananState> mapEventToState(ListSimpananEvent event) async* {
    if (event is SubmittedListSimpanan) {
      yield ListSimpananLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        ListSimpanan listSimpanan = await userRepository.listSimpanan(
          _token
        ); 
        // print(listSimpanan.response.respCode);
        if (listSimpanan.response.respCode == "00"){
          yield ListSimpananInitial(listSimpanan: listSimpanan);          
        }
        if (listSimpanan.response.respCode != "00"){
          yield ListSimpananFailure(error: listSimpanan.response.respMessage);
        }
        
      } catch (error) {
        yield ListSimpananFailure(error: error.toString());
      }
    }
  }
  
}



      