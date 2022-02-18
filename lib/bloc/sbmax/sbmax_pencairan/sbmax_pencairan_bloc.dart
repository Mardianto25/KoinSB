import 'dart:async';
import 'dart:convert';

import 'package:flutter_base/bloc/sbmax/sbmax_pencairan/sbmax_pencairan_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pencairan/sbmax_pencairan_state.dart';
import 'package:flutter_base/model/response/sbmax_detail.dart';
import 'package:flutter_base/model/response/sbmax_simulasi_detail_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SbmaxPencairanBloc extends Bloc<SbmaxPencairanEvent, SbmaxPencairanState> {
  final UserRepository userRepository;

  SbmaxPencairanBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  SbmaxPencairanState get initialState => SbmaxPencairanInitial();

  @override
  Stream<SbmaxPencairanState> mapEventToState(SbmaxPencairanEvent event) async* {
    if (event is SubmittedSbmaxPencairan) {
      yield SbmaxPencairanLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        SbmaxSimulasiDetailResponse sbmaxDetail = await userRepository.sbmaxPencairan(
          event.imei,event.noac, event.password, _token
        ); 
        if (sbmaxDetail.response.respCode == "00"){
          yield SbmaxPencairanInitial();          
        }
        if (sbmaxDetail.response.respCode != "00"){
          yield SbmaxPencairanFailure(error: sbmaxDetail.response.respMessage);
        }
        
      } catch (error) {
        yield SbmaxPencairanFailure(error: error.toString());
      }
    }
  }
  
}



      