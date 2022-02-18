import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/code_referral.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login.dart';

class MemberDataSaved extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MemberDataSavedState();
}

class _MemberDataSavedState extends State<MemberDataSaved> {
  double bottomSheetTopPosition = 50;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 32),
                        child: SvgPicture.asset("assets/svg/ic-success-01.svg")),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Data Keanggotaan Berhasil Disimpan",
                        style: CustomText.bold18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
                      child: Text(
                        "Silahkan masuk ke dashboard untuk mulai memanfaatkan "
                        " penawaran produk simpanan kami",
                        textAlign: TextAlign.center,
                        style: CustomText.regular13,
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CodeReferral()));

                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: CustomRegistrationButton("DASHBOARD", true)),
                ),
              ],
            )));
  }
}
