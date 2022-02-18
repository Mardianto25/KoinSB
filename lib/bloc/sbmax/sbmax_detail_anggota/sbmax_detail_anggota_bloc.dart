import 'dart:async';
import 'dart:convert';


import 'package:flutter_base/bloc/sbmax/sbmax_detail_anggota/sbmax_detail_anggota_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_detail_anggota/sbmax_detail_anggota_state.dart';
import 'package:flutter_base/model/response/list_rekening.dart';
import 'package:flutter_base/model/response/otp_response.dart';
import 'package:flutter_base/model/response/sbmax_detail.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SbmaxDetailAnggotaBloc extends Bloc<SbmaxDetailAnggotaEvent, SbmaxDetailAnggotaState> {
  final UserRepository userRepository;

  SbmaxDetailAnggotaBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  SbmaxDetailAnggotaState get initialState => SbmaxDetailAnggotaInitial();

  @override
  Stream<SbmaxDetailAnggotaState> mapEventToState(SbmaxDetailAnggotaEvent event) async* {
    if (event is SubmittedSbmaxDetailAnggota) {
      yield SbmaxDetailAnggotaLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        SbmaxDetail sbmaxDetail = await userRepository.sbmaxDetailAnggota(
          event.noac,_token
        ); 
        print(sbmaxDetail.response.respCode);
        if (sbmaxDetail.response.respCode == "00"){
          yield SbmaxDetailAnggotaInitial(sbmaxDetailAnggota: sbmaxDetail);          
        }
        if (sbmaxDetail.response.respCode != "00"){
          yield SbmaxDetailAnggotaFailure(error: sbmaxDetail.response.respMessage);
        }
        
      } catch (error) {
        yield SbmaxDetailAnggotaFailure(error: error.toString());
      }
    }
  }
  
}



      