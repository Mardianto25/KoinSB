import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/member_data_save/member_data_save_bloc.dart';
import 'package:flutter_base/bloc/set_password/set_password_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/member_data_save/member_data_save_form.dart';
import 'package:flutter_base/ui_bloc/set_password/set_password_form.dart';

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


class MemberSavePage extends StatelessWidget {
  final UserRepository userRepository =UserRepository();

  // SetPasswordPage({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
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
          return MemberDataSaveBloc(
            userRepository: userRepository,
          );
        },
        child: MemberDataForm(),
      ),
    );
  }
}
