import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/komersial/komersial_success.dart';
import 'package:flutter_base/dashboard/loan_detail/payment_bank_detail.dart';
import 'package:flutter_base/dashboard/loan_detail/payment_koinsb.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentBank extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaymentBankState();
  }
}

class _PaymentBankState extends State<PaymentBank> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  var _pass;
  bool _obscureTextOld = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("Transfer Bank",
              style: Theme.of(context).textTheme.title),
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Pembayaran Cicilan",
                        style: CustomText.medium18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      child: Text(
                        "Menggunakan metode transfer bank",
                        style: CustomText.regular12,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.teal)),
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentBankDetail()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    width: 54,
                                    height: 22,
                                    child: Image.asset(
                                        "assets/images/ic_logo_bank_mandiri.png"),
                                  ),
                                  Text(
                                    "Bank Mandiri",
                                    style: CustomText.regular16,
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios, size: 12, color: Colors.teal,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.teal)),
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentBankDetail()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Image.asset(
                                      "assets/images/ic_logo_bank_bni.png", fit: BoxFit.cover,),
                                  ),
                                  Text(
                                    "Bank BNI",
                                    style: CustomText.regular16,
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios, size: 12, color: Colors.teal,)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
//            Align(
//                alignment: Alignment.bottomCenter,
//                child: Container(
//                  padding: EdgeInsets.only(left: 16, right: 16),
//                  color: Colors.white,
//                  child: GestureDetector(
//                    onTap: () {
//                      _showDialog();
//                    },
//                    child: Container(
//                        padding: EdgeInsets.only(bottom: 0),
//                        width: double.infinity,
//                        child: CustomRegistrationButton("PROSES", true)),
//                  ),
//                ))
          ],
        ));
  }
}
