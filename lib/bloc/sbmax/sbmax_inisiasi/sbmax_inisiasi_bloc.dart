import 'dart:async';
import 'dart:convert';

import 'package:flutter_base/bloc/sbmax/sbmax_inisiasi/sbmax_inisiasi_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_inisiasi/sbmax_inisiasi_state.dart';
import 'package:flutter_base/model/response/sbmax_detail.dart';
import 'package:flutter_base/model/response/sbmax_simulasi_detail_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SbmaxInisiasiBloc extends Bloc<SbmaxInisiasiEvent, SbmaxInisiasiState> {
  final UserRepository userRepository;

  SbmaxInisiasiBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  SbmaxInisiasiState get initialState => SbmaxInisiasiInitial();

  @override
  Stream<SbmaxInisiasiState> mapEventToState(SbmaxInisiasiEvent event) async* {
    if (event is SubmittedSbmaxInisiasi) {
      yield SbmaxInisiasiLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        SbmaxSimulasiDetailResponse sbmaxDetail = await userRepository.sbmaxInisiasi(
          event.param,_token, event.no
        ); 
        if (sbmaxDetail.response.respCode == "00"){
          yield SbmaxInisiasiInitial(sbmaxInisiasi: sbmaxDetail);          
        }
        if (sbmaxDetail.response.respCode != "00"){
          yield SbmaxInisiasiFailure(error: sbmaxDetail.response.respMessage);
        }
        
      } catch (error) {
        yield SbmaxInisiasiFailure(error: error.toString());
      }
    }
  }
  
}



      