// import 'package:flutter/material.dart';
// import 'package:flutter_base/bloc/email_otp/email_event.dart';
// import 'package:flutter_base/bloc/email_otp/email_state.dart';
// import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
// import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_event.dart';
// import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_state.dart';
// import 'package:flutter_base/repository/user/user_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class EmailHandleBloc extends Bloc<EmailEvent, EmailState> {
//   final UserRepository userRepository;

//   EmailHandleBloc({@required this.userRepository}): assert(userRepository != null);

//   @override
//   // TODO: implement initialState
//   EmailState get initialState => EmailUninitialized();

//   @override
//   Stream<EmailState> mapEventToState(EmailEvent event) async* {
//     if (event is EmailStarted) {
//     final bool hasPhone = await userRepository.hasPhone();

//     if (hasPhone) {
//         yield EmailAuthenticated();
//       } else {
//         yield EmailUnauthenticated();
//       }
//     }

//     if (event is EmailSuccess) {
//       yield EmailAuthLoading();
//       // await userRepository.persistPhone(event.phone);
//       yield EmailAuthenticated();
//     }

//     if (event is EmailError) {
//       yield EmailAuthLoading();
//       // await userRepository.deleteToken();
//       yield EmailUnauthenticated();
//     }
//   }
// }
