import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/change_password/change_password_bloc.dart';
import 'package:flutter_base/bloc/email_otp/email_bloc.dart';
import 'package:flutter_base/bloc/login/login_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/change_password/change_password_form.dart';
import 'package:flutter_base/ui_bloc/email_otp/email_form.dart';
import 'package:flutter_base/ui_bloc/login/login_form.dart';
import 'package:flutter_base/verifikasi_thankyou.dart';
import 'package:flutter_base/verifikasi_thankyou_registration.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class ChangePasswordPage extends StatelessWidget {
  final UserRepository userRepository =UserRepository();

  // EmailPage({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              
              Navigator.of(context).pop();
                
            }
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title:
              Text("Ubah Password", style: Theme.of(context).textTheme.title),
        ),
        body: BlocProvider(
          create: (context) {
            return ChangePasswordBloc(
              // authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: userRepository,
            );
          },
          child: ChangePasswordForm(),
        ),
      ),
    );
  }
}
