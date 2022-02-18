import 'dart:async';

import 'package:flutter_base/bloc/member_data_save/member_data_save_event.dart';
import 'package:flutter_base/bloc/referral/referral_event.dart';
import 'package:flutter_base/bloc/referral/referral_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ReferralBloc extends Bloc<ReferralEvent, ReferralState> {
  final UserRepository userRepository;

  ReferralBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  ReferralState get initialState => ReferralInitial();

  @override
  Stream<ReferralState> mapEventToState(ReferralEvent event) async* {
    if (event is ReferralButtonPressed) {
      yield ReferralLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        final LoginResponse _general = await userRepository.referralCode(
          event.publicId, event.refcode, _token
        );
        print("tess ${_general.response.respCode}");
        if (_general.response.respCode == "00"){
          yield ReferralInitial();
        }else{
          yield ReferralFailure(error: _general.response.respMessage);
        }
      } catch (error) {
        yield ReferralFailure(error: error.toString());
      }
    }
  }
  
}
