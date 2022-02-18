import 'dart:async';
import 'dart:convert';

import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail/sbmax_simulasi_detail_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail/sbmax_simulasi_detail_state.dart';
import 'package:flutter_base/model/response/sbmax_simulasi_detail_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SbmaxSimulasiDetailBloc extends Bloc<SbmaxSimulasiDetailEvent, SbmaxSimulasiDetailState> {
  final UserRepository userRepository;

  SbmaxSimulasiDetailBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  SbmaxSimulasiDetailState get initialState => SbmaxSimulasiDetailInitial();

  @override
  Stream<SbmaxSimulasiDetailState> mapEventToState(SbmaxSimulasiDetailEvent event) async* {
    if (event is SubmittedSbmaxSimulasiDetail) {
      yield SbmaxSimulasiDetailLoading();
      SbmaxSimulasiDetailResponse sbmaxDetail;
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        sbmaxDetail = await userRepository.sbmaxSimulasiDetail(
          event.param,_token, event.no
        ); 
        if (sbmaxDetail.response.respCode == "00"){
          yield SbmaxSimulasiDetailInitial(sbmaxSimulasiDetail: sbmaxDetail);          
        }
        if (sbmaxDetail.response.respCode != "00"){
          yield SbmaxSimulasiDetailFailure(error: sbmaxDetail.response.respMessage, sbmaxSimulasiDetail: sbmaxDetail);
        }
        
      } catch (error) {
        yield SbmaxSimulasiDetailFailure(error: error.toString(), sbmaxSimulasiDetail: sbmaxDetail);
      }
    }
  }
  
}



      