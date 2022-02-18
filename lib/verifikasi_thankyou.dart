import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/main.dart';
import 'package:flutter_base/onboarding.dart';
import 'package:flutter_base/password.dart';
import 'package:flutter_base/phonenumber.dart';
import 'package:flutter_base/pin_phonenumber.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/user_widget.dart';
import 'package:flutter_base/ui_bloc/set_password/set_password_page.dart';
import 'package:flutter_base/welcome.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';


class VerifikasiThankyou extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _VerifikasiThankyouState();
}

class _VerifikasiThankyouState extends State<VerifikasiThankyou> {

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
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                SvgPicture.asset("assets/svg/ic-success-01.svg"),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                      "Terima Kasih",
                    style: CustomText.bold18,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Nomor ponsel dan alamat email anda sudah berhasil diverifikasi silahkan lanjutkan ke proses selanjutnya",
                    textAlign: TextAlign.center,
                    style: CustomText.regular13,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_){
                          return SetPasswordPage();
                        }
                    )
                );
              },
              child: CustomRegistrationButton("SET PASSWORD", true),
            ),
          ],
        )
      )
    );
  }

}
