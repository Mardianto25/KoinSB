import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/code_referral.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_loan_of_goods.dart';
import 'package:flutter_base/dashboard/loan_list.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'pickmi_activation_plafond.dart';

class PickmiSuccesPayment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PickmiSuccesPaymentState();
}

class _PickmiSuccesPaymentState extends State<PickmiSuccesPayment> {
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
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                    child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: SvgPicture.asset("assets/svg/ic-success-01.svg")
                            ),
                            Container(
                              padding: EdgeInsets.only(top:16, left:18, right: 18),
                              child: Text(
                                "Pembayaran Keanggotaan Diterima",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left:16.0, right: 16.0, top: 16),
                              child: Text(
                                "Mohon tunggu, data keanggotaan anda sedang kami  \nproses, setelah ini anda akan mendapatkan 4 digit PIN \nAktivasi kemudian anda bisa langsung mengajukan \npinjaman",
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
                            builder: (context) => PickmiActivationPlafond()
                          ));
                      },
                      color: Color(0xff096d5c),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "KEMBALI KE DASHBOARD",
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
