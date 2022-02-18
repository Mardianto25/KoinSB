import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/main.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_roundrec_button.dart';

class CodeReferral extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CodeReferralState();
}

class _CodeReferralState extends State<CodeReferral> {
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
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08,
                    left: 16,
                    right: 16),
                child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Kode Referral",
                            style: CustomText.bold18,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Text(
                            "Undang teman untuk bergabung bersama kami di Koperasi Simpan Pinjam Sejahtera Bersama dengan menggunakan kode referral & dapatkan bonus spesial ",
                            style: CustomText.regular13,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 58.5),
                          child: Text(
                            "Masukan Kode Referal",
                            style: CustomText.bold14,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 68.5, right: 68.5),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                fillColor: Theme.of(context).accentColor,
                                hintText: 'Cth :  XXX000'),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Main()),
                              ModalRoute.withName('/'));
                        },
                        child: Container(
                            width: double.infinity,
                            child: CustomRoundRecButton("LANJUT", true)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Main()),
                              ModalRoute.withName('/'));
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 12, bottom: 23),
                            width: double.infinity,
                            child: CustomRoundRecButton("LEWATI", false)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
