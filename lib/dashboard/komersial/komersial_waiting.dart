import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/code_referral.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_loan_of_goods.dart';


class KomersialWaiting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _KomersialWaitingState();
}

class _KomersialWaitingState extends State<KomersialWaiting> {
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
                        margin: EdgeInsets.only(bottom: 5),
                        child: Image.asset("assets/images/ic_success.png")
                    ),
                    Container(
                      padding: EdgeInsets.only(top:18, left:18, right: 18),
                      child: Text(
                        "Silahkan selesaikan Terlebih",
                        textAlign: TextAlign.center,
                        style: CustomText.bold18,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Dahulu pinjaman Anda yang",
                        textAlign: TextAlign.center,
                        style: CustomText.bold18,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Sebelumnya",
                        textAlign: TextAlign.center,
                        style: CustomText.bold18,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PickmiLoanOfGoods()));

                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: CustomRegistrationButton("LIST PRODUCK PINJAMAN", true)),
                ),
              ],
            )));
  }
}
