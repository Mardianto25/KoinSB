import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/code_referral.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_loan_of_goods.dart';
import 'package:flutter_base/dashboard/loan_list.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'pickmi_successful_payment.dart';

class PickmiSubmissionApprove extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PickmiSubmissionApproveState();
}

class _PickmiSubmissionApproveState extends State<PickmiSubmissionApprove> {
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
                                child: SvgPicture.asset("assets/svg/ic_submission.svg")
                            ),
                            Container(
                              padding: EdgeInsets.only(top:16, bottom: 16, left:18, right: 18),
                              child: Text(
                                "Pengajuan Pickmi Setujui",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Container(
                              child: Text(
                                "Silahkan membayar biaya keanggotaan. Simpanan \nPokok, Simpanan Wajib dan pembukaan rekening KOIN \n sebagai syarat menjadi anggota KSP Sejahtera",
                                textAlign: TextAlign.center,
                                style: CustomText.regular13,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left:16.0, right: 16.0, top: 28),
                              child: Text(
                                "Biaya Keanggotaan KSP Sejhatera Bersama",
                                textAlign: TextAlign.center,
                                style: CustomText.regular14,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top:17, left:18, right: 18),
                              child: Text(
                                "Rp120.000",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left:16.0, right: 16.0, top: 17),
                              child: Text(
                                "Virtual Account Pembayaran (BNI)",
                                textAlign: TextAlign.center,
                                style: CustomText.regular14,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top:17, left:18, right: 18),
                              child: Text(
                                "0000000000000000",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                            builder: (context) => PickmiSuccesPayment()
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
        ));
  }
}
