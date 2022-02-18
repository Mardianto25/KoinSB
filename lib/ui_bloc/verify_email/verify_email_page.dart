import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/verify_email/verify_email_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/pin_email/pin_email_form.dart';
import 'package:flutter_base/ui_bloc/verify_email/verify_email_form.dart';

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


class VerifyEmailPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  final String email;
  final int otpId;
  
  VerifyEmailPage({Key key, @required this.email, @required this.otpId}) : super(key: key);

  // PinEmailPage({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body: BlocProvider(
        create: (context) {
          return VerifyEmailBloc(
            userRepository: userRepository,
          );
        },
        child: VerifyEmailForm(email: email, otpId: otpId,),
      ),
    );
  }
}
