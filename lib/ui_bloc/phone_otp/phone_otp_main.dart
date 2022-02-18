import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/auth/auth_state.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_event.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_handle_bloc.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_state.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_state.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_success_bloc.dart';
import 'package:flutter_base/bloc/register/register_bloc.dart';
import 'package:flutter_base/email.dart';
import 'package:flutter_base/phonenumber.dart';
import 'package:flutter_base/pin_phonenumber.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/login/login_page.dart';
import 'package:flutter_base/ui_bloc/phone_otp/phone_otp_page.dart';
import 'package:flutter_base/ui_bloc/pin_email/pin_email_page.dart';
import 'package:flutter_base/ui_bloc/pin_phone/pin_phone_main.dart';
import 'package:flutter_base/ui_bloc/register/register_page.dart';
import 'package:flutter_base/ui_bloc/set_password/set_password_main.dart';
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


class PhoneOtpMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PhoneOtpMainState();
}

class _PhoneOtpMainState extends State<PhoneOtpMain> {
  
  final userRepository = UserRepository();

  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomPadding: false,
     body:  BlocProvider<PhoneOtpHandleBloc>(
        create: (context) {
          return PhoneOtpHandleBloc(userRepository: userRepository)
          ..add(PhoneOtpStarted());
        },
        child: PhoneOtpWidget(userRepository: userRepository),
      )
    );
  }

}

class PhoneOtpWidget extends StatelessWidget {
  final UserRepository userRepository;

  PhoneOtpWidget({Key key, @required this.userRepository}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<PhoneOtpHandleBloc, PhoneOtpState>(
        builder: (context, state) {
          // if (state is PhoneOtpUninitialized) {
          //   // return LoadingIndicator();
          //   return PhoneOtpPage(userRepository: userRepository);
            
          // }
          // if (state is PhoneOtpAuthenticated) {
          //   return PinPhoneMain();
          // }
          // if (state is PhoneOtpUnauthenticated) {
          //   return PhoneOtpPage(userRepository: userRepository);
          // }
          // if (state is PhoneOtpLoading) {
          //   return LoadingIndicator();
          // }
        },
      ),
    );
  }
  
}