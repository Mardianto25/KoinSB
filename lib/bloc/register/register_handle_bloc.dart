import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_event.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_state.dart';
import 'package:flutter_base/bloc/register/register_event.dart';
import 'package:flutter_base/bloc/register/register_state.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterHandleBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterHandleBloc({@required this.userRepository}): assert(userRepository != null);

  @override
  // TODO: implement initialState
  RegisterState get initialState => RegisterUninitialized();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterStarted) {
    final bool hasPhone = await userRepository.hasPhone();

    if (hasPhone) {
        yield RegisterAuthenticated();
      } else {
        yield RegisterUnauthenticated();
      }
    }

    if (event is RegisterSuccess) {
      yield RegisterAuthLoading();
      // await userRepository.persistPhone(event.phone);
      yield RegisterAuthenticated();
    }

    if (event is RegisterError) {
      yield RegisterAuthLoading();
      // await userRepository.deleteToken();
      yield RegisterUnauthenticated();
    }
  }
}
