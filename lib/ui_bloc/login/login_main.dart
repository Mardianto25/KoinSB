import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/auth/auth_state.dart';
import 'package:flutter_base/dashboard/main.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/login/login_page.dart';
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


class LoginMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  
  final userRepository = UserRepository();
  
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = SimpleBlocDelegate();
    final userRepository = UserRepository();
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body:  BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
        },
        child: LoginWidget(userRepository: userRepository),
      )
    );
  }

}

class LoginWidget extends StatelessWidget {
  final UserRepository userRepository;

  LoginWidget({Key key, @required this.userRepository}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            // return LoginPage(userRepository: userRepository);
            // return LoadingIndicator();
            // loading(context);
            // return success2(context);
            return LoginPage(userRepository: userRepository);
          }
          if (state is AuthenticationAuthenticated) {
            return Main();
          }
          if (state is MemberAuthenticationAuthenticated) {
            return MemberData();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
  Widget loading(ctx){
    return showDialog(
      context: ctx,
      barrierDismissible: false,  
      useRootNavigator: false,    
      builder: (context) => new AlertDialog(
            content:
            Container(

            width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height, 
            child: Container(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Loading ...", style: CustomText.bold12Black,),
                  )
                ],
              ),
            ),
          )
        ),
    ) ??
    false;
  }

  success2(context){
    return showDialog(
      context: context,
      barrierDismissible: false, 
      useRootNavigator: false,     
      builder: (context) => new AlertDialog(
            content:
          Container(

            width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height, 
            child: Container(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Loading ...", style: CustomText.bold12Black,),
                  )
                ],
              ),
            ),
          )
        ),
    ) ??
    false;
  }
}