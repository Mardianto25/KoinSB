import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/auth/auth_state.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_event.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_handle_bloc.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_state.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/phone_otp/phone_otp_page.dart';
import 'package:flutter_base/ui_bloc/pin_phone/pin_phone_main.dart';
import 'package:flutter_base/ui_bloc/set_password/set_password_page.dart';
import 'package:flutter_base/verifikasi_password_thankyou.dart';
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


class SetPasswordMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SetPasswordMainState();
}

class _SetPasswordMainState extends State<SetPasswordMain> {
  
  final userRepository = UserRepository();

  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomPadding: false,
     body:  BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
        },
        child: SetPasswordWidget(userRepository: userRepository),
      )
    );
  }

}

class SetPasswordWidget extends StatelessWidget {
  final UserRepository userRepository;

  SetPasswordWidget({Key key, @required this.userRepository}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          // if (state is AuthenticationUninitialized) {
          //   return LoadingIndicator();
          // }
          // if (state is AuthenticationAuthenticated) {
          //   return VerifikasiPasswordThankyou();
          // }
          // if (state is AuthenticationUnauthenticated) {
          //   return SetPasswordPage();
          // }
          // if (state is AuthenticationLoading) {
          //   return LoadingIndicator();
          // }
        },
      ),
    );
  }
  
}