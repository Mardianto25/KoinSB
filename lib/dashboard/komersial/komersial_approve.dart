import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/code_referral.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_loan_of_goods.dart';


class KomersialApprove extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _KomersialApproveState();
}

class _KomersialApproveState extends State<KomersialApprove> {
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
                        "Pinjaman Disetujui!",
                        textAlign: TextAlign.center,
                        style: CustomText.bold18,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Silahkan melanjutkan Proses",
                        textAlign: TextAlign.center,
                        style: CustomText.bold18,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Akad Pinjaman",
                        textAlign: TextAlign.center,
                        style: CustomText.bold18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:16.0, right: 16.0, top: 26),
                      child: Text(
                        "Proses Akad Pinjaman Komersial/Mikro di lakukan di Kantor Cabang KSP Sejahtera Bersama",
                        textAlign: TextAlign.center,
                        style: CustomText.regular13,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:16.0, right: 16.0, top: 12),
                      child: Text(
                        "Lokasi Akad Pinjaman",
                        textAlign: TextAlign.center,
                        style: CustomText.bold18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:16.0, right: 16.0, top: 12),
                      child: Text(
                        "CABANG XXX",
                        textAlign: TextAlign.center,
                        style: CustomText.bold14,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:16.0, right: 16.0, top: 12),
                      child: Text(
                        "SELASA, 00-00-0000",
                        textAlign: TextAlign.center,
                        style: CustomText.bold14,
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
