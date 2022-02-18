import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/auth/auth_state.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_state.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinEmailSuccessBloc extends Bloc<PinEmailEvent, PinEmailState> {
  final UserRepository userRepository;

  PinEmailSuccessBloc({@required this.userRepository}): assert(userRepository != null);

  @override
  // TODO: implement initialState
  PinEmailState get initialState => PinEmailUninitialized();

  @override
  Stream<PinEmailState> mapEventToState(PinEmailEvent event) async* {
    if (event is PinStarted) {
    final bool hasEmail = await userRepository.hasEmail();

    if (hasEmail) {
        yield PinEmailAuthenticated();
      } else {
        yield PinEmailUnauthenticated();
      }
    }

    if (event is PinEmailSuccess) {
      yield PinEmailAuthLoading();
      await userRepository.persistEmail(event.email);
      yield PinEmailAuthenticated();
    }

    if (event is PinEmailError) {
      yield PinEmailAuthLoading();
      await userRepository.deleteToken();
      yield PinEmailUnauthenticated();
    }
  }
}
