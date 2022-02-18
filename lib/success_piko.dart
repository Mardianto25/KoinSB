import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/login/login_main.dart';
import 'package:flutter_base/ui_bloc/referral/referral_page.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login.dart';


class SuccessPiko extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SuccessPikoState();
}

class _SuccessPikoState extends State<SuccessPiko> {

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
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          child: SvgPicture.asset("assets/svg/ic-success-01.svg")
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Pengaturan Akun Selesai",
                            style: CustomText.bold18,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 48, left: 48),
                          child: Text(
                            "Akun PIKO-SB anda sudah terintegrasi dengan \nAplikasi KOIN-SB KSP Sejahtera Bersama \nSelamat melakuan transaksi semakin mudah!",
                            textAlign: TextAlign.center,
                            style: CustomText.regular13,
                          ),
                        ),
                       

                      ],
                    ),
                 
                  ],
                )
              ),
            ),
            Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => ReferralPage(type:"piko")
                            ));
                        },
                        color: Color(0xff096d5c),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "ISI KODE REFERRAL",
                            textAlign: TextAlign.center,
                            style: CustomText.medium15White,
                          ),
                        ),
                      ),
                    ))
          ],
        ),
      )
    );
  }

}
