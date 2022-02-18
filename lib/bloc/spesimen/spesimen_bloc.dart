import 'dart:async';
import 'package:flutter_base/bloc/spesimen/spesimen_event.dart';
import 'package:flutter_base/bloc/spesimen/spesimen_state.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SpesimenBloc extends Bloc<SpesimenEvent, SpesimenState> {
  final UserRepository userRepository;

  SpesimenBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  SpesimenState get initialState => SpesimenInitial();

  @override
  Stream<SpesimenState> mapEventToState(SpesimenEvent event) async* {
    if (event is SpesimenButtonPressed) {
      yield SpesimenLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        LoginResponse token = await userRepository.uploadSpesimen(
          event.spesimen, _token
        );
        yield SpesimenLoading();  
        if (token.response.respCode == "00"){
          yield SpesimenInitial();
        }
        else {
          yield SpesimenFailure(error: token.response.respMessage);
        }
          // yield SpesimenInitial();
      } catch (error) {
        yield SpesimenFailure(error: error.toString());
      }
    }
  }
  
}
