import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/auth/auth_state.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_state.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_success_bloc.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_event.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_handle_bloc.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_state.dart';
import 'package:flutter_base/bloc/register/register_bloc.dart';
import 'package:flutter_base/email.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/login/login_page.dart';
import 'package:flutter_base/ui_bloc/phone_otp/phone_otp_main.dart';
import 'package:flutter_base/ui_bloc/pin_email/pin_email_page.dart';
import 'package:flutter_base/ui_bloc/pin_phone/pin_phone_page.dart';
import 'package:flutter_base/ui_bloc/register/register_page.dart';
import 'package:flutter_base/ui_bloc/set_password/set_password_main.dart';
import 'package:flutter_base/verifikasi_thankyou.dart';
import 'package:flutter_base/verifikasi_thankyou_registration.dart';
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


class PinPhoneMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PinPhoneMainState();
}

class _PinPhoneMainState extends State<PinPhoneMain> {
  
  final userRepository = UserRepository();

  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomPadding: false,
      
     body:  BlocProvider<PinPhoneHandleBloc>(
        create: (context) {
          return PinPhoneHandleBloc(userRepository: userRepository)
          ..add(PinPhoneStarted());
        },
        child: PinPhoneWidget(userRepository: userRepository),
      )
    );
  }

}

class PinPhoneWidget extends StatelessWidget {
  final UserRepository userRepository;

  PinPhoneWidget({Key key, @required this.userRepository}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<PinPhoneHandleBloc, PinPhoneState>(
        builder: (context, state) {
          // if (state is PinPhoneUninitialized) {
          //   // return LoadingIndicator();
          //   return PinPhonePage(userRepository: userRepository);
          
          // }
          // if (state is PinPhoneAuthenticated) {
          //   return SetPasswordMain();
          // }
          // if (state is PinPhoneUnauthenticated) {
          //   return PinPhonePage(userRepository: userRepository);
          // }
          // if (state is PinPhoneLoading) {
          //   return LoadingIndicator();
          // }
        },
      ),
    );
  }
  
}