import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/code_referral.dart';
import 'package:flutter_base/dashboard/home.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_loan_of_goods.dart';


class KomersialNoApprove extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _KomersialNoApproveState();
}

class _KomersialNoApproveState extends State<KomersialNoApprove> {
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
                        "Pengajuan Pinjaman Anda",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Ditolak",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:16.0, right: 16.0, top: 16),
                      child: Text(
                        "Jaminan atau kelengkapan data belum cukup untuk persetujuan pengajuan pinjaman ini",
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
                            builder: (context) => Home()));

                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: CustomRegistrationButton("KEMBALI KE DASHBOARD", true)),
                ),
              ],
            )));
  }
}
