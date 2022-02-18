import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/main.dart';
import 'package:flutter_base/onboarding.dart';
import 'package:flutter_base/password.dart';
import 'package:flutter_base/phonenumber.dart';
import 'package:flutter_base/pin_phonenumber.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/user_widget.dart';
import 'package:flutter_base/ui_bloc/email_otp/email_page.dart';
import 'package:flutter_base/ui_bloc/login/login_main.dart';
import 'package:flutter_base/ui_bloc/login/login_page.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/welcome.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'email.dart';
import 'login.dart';


class VerifikasiThankyouRegistration extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _VerifikasiThankyouRegistratoinState();
}

class _VerifikasiThankyouRegistratoinState extends State<VerifikasiThankyouRegistration> {

  double bottomSheetTopPosition = 50;

  @override
  void initState() {
    super.initState();
  }

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
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset("assets/svg/ic-already-member.svg"),
                Container(
                  margin: EdgeInsets.only(top: 28),
                  child: Text(
                      "Kamu Sudah Terdaftar",
                    style: CustomText.bold18,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    "Nomor e-KTP kamu sudah terdaftar di aplikasi PIKO-SB "+
                    "Silahkan masuk dengan menggunakan nomor ponsel "+
                  "atau alamat email dan password yang "+
                  "kamu gunakan di aplikasi PIKO-SB",
                    textAlign: TextAlign.center,
                    style: CustomText.regular13,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (_){
                          return LoginMain();
                        }
                    )
                );
              },
              child: CustomRegistrationButton("MASUK", true),
            ),
          ],
        )
      )
    );
  }

}
