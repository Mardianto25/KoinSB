import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_event.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_state.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinPhoneHandleBloc extends Bloc<PinPhoneEvent, PinPhoneState> {
  final UserRepository userRepository;

  PinPhoneHandleBloc({@required this.userRepository}): assert(userRepository != null);

  @override
  // TODO: implement initialState
  PinPhoneState get initialState => PinPhoneUninitialized();

  @override
  Stream<PinPhoneState> mapEventToState(PinPhoneEvent event) async* {
    if (event is PinPhoneStarted) {
    final bool hasPhone = await userRepository.hasPhone();

    if (hasPhone) {
        yield PinPhoneAuthenticated();
      } else {
        yield PinPhoneUnauthenticated();
      }
    }

    if (event is PinPhoneSuccess) {
      yield PinPhoneAuthLoading();
      await userRepository.persistPhone(event.phone);
      yield PinPhoneAuthenticated();
    }

    if (event is PinPhoneError) {
      yield PinPhoneAuthLoading();
      await userRepository.deleteToken();
      yield PinPhoneUnauthenticated();
    }
  }
}
