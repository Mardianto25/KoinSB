import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/auth/auth_state.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository}): assert(userRepository != null);

  @override
  // TODO: implement initialState
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{
    if (event is AppStarted) {
    String hasToken = await userRepository.hasToken();
    String loginData = await userRepository.loginData();
    print(hasToken);
      if (hasToken == null && loginData == null) {
        yield AuthenticationUnauthenticated();
      } else if(hasToken != null && loginData != null){
        yield AuthenticationAuthenticated();
      }else if(hasToken == null && loginData != null){
        yield AuthenticationUnauthenticated();
      }else if(hasToken != null && loginData == null){
        yield MemberAuthenticationAuthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
