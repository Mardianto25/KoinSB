import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/code_referral.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_loan_of_goods.dart';
import 'package:flutter_base/dashboard/loan_list.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_view/pin_view.dart';

import 'dashboard_pickmi/pickmi_dashboard.dart';
import 'pickmi_successful_payment.dart';

class PickmiActivationPlafond extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PickmiActivationPlafondState();
}

class _PickmiActivationPlafondState extends State<PickmiActivationPlafond> {
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
                                margin: EdgeInsets.only(top: 40),
                                child: SvgPicture.asset("assets/svg/ic_pin_activation.svg")
                            ),
                            Container(
                              padding: EdgeInsets.only(top:32, bottom: 16, left:41, right: 41),
                              child:  PinView (
                              count: 4,
                              autoFocusFirstField: false,
                              enabled: true, // this makes fields not focusable
                              submit: (String pin){
                                // Navigator.of(context).push(
                                //   SlideRightRoute(
                                //       page: PhoneNumber()
                                //   )
                                // );
                              }
                            )
                            ),
                            Container(
                              padding: EdgeInsets.only(top:39, left:18, right: 18),
                              child: Text(
                                "Masukkan PIN Aktivasi Akun Anda",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left:16.0, right: 16.0, top: 23),
                              child: Text(
                                "Masukkan nomor PIN yang telah kami kirimkan \nke email dan nomor ponsel anda",
                                textAlign: TextAlign.center,
                                style: CustomText.regular12,
                              ),
                            ),
                            
                          ],
                        ),
                      ],
                    )),
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
                            builder: (context) => PickmiDashboard()
                          ));
                      },
                      color: Color(0xff096d5c),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "AKTIFKAN",
                          textAlign: TextAlign.center,
                          style: CustomText.medium15White,
                        ),
                      ),
                    ),
                  ))
            ],
            
          ),
        ));
  }
}
