import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/login/login_bloc.dart';
import 'package:flutter_base/bloc/register/register_bloc.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/login/login_form.dart';
import 'package:flutter_base/ui_bloc/register/register_form.dart';
import 'package:flutter_base/welcome.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Welcome()
        ));
      },
      child: Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: (){
              
              // Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Welcome()
              ));
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
            return RegisterBloc(
              // authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: userRepository,
            );
          },
          child: RegisterForm(),
        ),
        // body: RegisterForm()
      ),
    );
  }
}
