import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_bloc.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_bloc.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_success_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/phone_otp/phone_otp_form.dart';
import 'package:flutter_base/ui_bloc/pin_email/pin_email_form.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}


class PhoneOtpPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  // PhoneOtpPage({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            // BlocProvider.of<PinEmailSuccessBloc>(context).add(PinEmailSuccess());
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body: BlocProvider(
        create: (context) {
          return PhoneOtpBloc(
            userRepository: userRepository,
          );
        },
        child: PhoneOtpForm(),
      ),
    );
  }
}
