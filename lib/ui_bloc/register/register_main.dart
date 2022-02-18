import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/auth/auth_state.dart';
import 'package:flutter_base/bloc/register/register_bloc.dart';
import 'package:flutter_base/bloc/register/register_event.dart';
import 'package:flutter_base/bloc/register/register_handle_bloc.dart';
import 'package:flutter_base/bloc/register/register_state.dart';
import 'package:flutter_base/email.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/login/login_page.dart';
import 'package:flutter_base/ui_bloc/register/register_page.dart';
import 'package:flutter_base/verifikasi_thankyou_registration.dart';
import 'package:flutter_base/welcome.dart';
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


class RegisterMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterMainState();
}

class _RegisterMainState extends State<RegisterMain> {
  
  final userRepository = UserRepository();

  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    // resizeToAvoidBottomPadding: false,
    
     body:  BlocProvider<RegisterHandleBloc>(
        create: (context) {
          return RegisterHandleBloc(userRepository: userRepository)
          ..add(RegisterStarted());
        },
        child: RegisterWidget(userRepository: userRepository),
      )
    );
  }

}

class RegisterWidget extends StatelessWidget {
  final UserRepository userRepository;

  RegisterWidget({Key key, @required this.userRepository}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<RegisterHandleBloc, RegisterState>(
        builder: (context, state) {
          // if (state is RegisterUninitialized) {
          //   return RegisterPage(userRepository: userRepository);
          // }
          // if (state is RegisterAuthenticated) {
          //   return VerifikasiThankyouRegistration();
          // }
          // if (state is RegisterUnauthenticated) {
          //   return RegisterPage(userRepository: userRepository);
          // }
          // if (state is RegisterLoading) {
          //   return LoadingIndicator();
          // }
        },
      ),
    );
  }
  
}