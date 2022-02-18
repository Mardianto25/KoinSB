import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/email_otp/email_bloc.dart';
import 'package:flutter_base/bloc/login/login_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/email_otp/email_form.dart';
import 'package:flutter_base/ui_bloc/login/login_form.dart';
import 'package:flutter_base/verifikasi_thankyou.dart';
import 'package:flutter_base/verifikasi_thankyou_registration.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class EmailPage extends StatelessWidget {
  final UserRepository userRepository =UserRepository();

  // EmailPage({Key key, @required this.userRepository})
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
              Navigator.of(context).pop();
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) => VerifikasiThankyouRegistration()
              // ));
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
          return EmailBloc(
            // authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: EmailForm(),
      ),
    );
  }
}
