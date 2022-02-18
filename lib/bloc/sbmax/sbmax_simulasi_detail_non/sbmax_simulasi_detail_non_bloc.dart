import 'dart:async';
import 'dart:convert';


import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail_non/sbmax_simulasi_detail_non_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail_non/sbmax_simulasi_detail_non_state.dart';
import 'package:flutter_base/model/response/sbmax_simulasi_detail_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SbmaxSimulasiDetailNonBloc extends Bloc<SbmaxSimulasiDetailNonEvent, SbmaxSimulasiDetailNonState> {
  final UserRepository userRepository;

  SbmaxSimulasiDetailNonBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  SbmaxSimulasiDetailNonState get initialState => SbmaxSimulasiDetailNonInitial();

  @override
  Stream<SbmaxSimulasiDetailNonState> mapEventToState(SbmaxSimulasiDetailNonEvent event) async* {
    if (event is SubmittedSbmaxSimulasiDetailNon) {
      yield SbmaxSimulasiDetailNonLoading();
      SbmaxSimulasiDetailResponse sbmaxDetail;
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        sbmaxDetail = await userRepository.sbmaxSimulasiDetailNon(
          event.param,_token
        ); 
        if (sbmaxDetail.response.respCode == "00"){
          yield SbmaxSimulasiDetailNonInitial(sbmaxSimulasiDetailNon: sbmaxDetail);          
        }
        if (sbmaxDetail.response.respCode != "00"){
          yield SbmaxSimulasiDetailNonFailure(error: sbmaxDetail.response.respMessage, sbmaxSimulasiDetailNon: sbmaxDetail);
        }
        
      } catch (error) {
        yield SbmaxSimulasiDetailNonFailure(error: error.toString(), sbmaxSimulasiDetailNon: sbmaxDetail);
      }
    }
  }
  
}



      