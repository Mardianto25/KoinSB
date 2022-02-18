import 'dart:async';
import 'dart:convert';


import 'package:flutter_base/bloc/sbmax/sbmax_nominal/sbmax_nominal_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_nominal/sbmax_nominal_state.dart';
import 'package:flutter_base/model/response/otp_response.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SbmaxNominalBloc extends Bloc<SbmaxNominalEvent, SbmaxNominalState> {
  final UserRepository userRepository;

  SbmaxNominalBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  SbmaxNominalState get initialState => SbmaxNominalInitial();

  @override
  Stream<SbmaxNominalState> mapEventToState(SbmaxNominalEvent event) async* {
    if (event is SubmittedNominal) {
      yield SbmaxNominalLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        print("roken"+_token);        
        SbmaxSimulasiResponse sbmaxData = await userRepository.sbmaxSimulasi(
          event.nominal, _token
        ); 
        print(sbmaxData.response.respCode);
        if (sbmaxData.response.respCode == "00"){
          yield SbmaxNominalInitial(dataSbmax: sbmaxData.response);          
        }
        if (sbmaxData.response.respCode != "00"){
          yield SbmaxNominalFailure(error: sbmaxData.response.respMessage);
        }
        
      } catch (error) {
        yield SbmaxNominalFailure(error: error.toString());
      }
    }
  }
  
}



      