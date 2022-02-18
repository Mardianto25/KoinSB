import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/komersial/komersial_success.dart';
import 'package:flutter_base/dashboard/loan_detail/payment_koinsb.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentBankDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaymentBankDetailState();
  }
}

class _PaymentBankDetailState extends State<PaymentBankDetail> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  var _pass;
  bool _obscureTextOld = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          leading: IconButton(
              icon: Icon(Icons.close),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              }),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title:
              Text("Transfer Bank", style: Theme.of(context).textTheme.title),
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
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 19),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,  // has the effect of extending the shadow
                            offset: Offset(
                              0.0, // horizontal, move right 10
                              3.0, // vertical, move down 10
                            ),
                          )
                        ],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.teal)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {

                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 16, bottom: 16, left: 24, right: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "Transfer ke virtual account ini:",
                                    style: CustomText.regular12Teal,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 14),
                                  child: Text(
                                    "7310 3020 2101 1174",
                                    style: CustomText.medium26,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Nama perusahaaan/produk: ',
                                      style: CustomText.regular12Teal,
                                      children: <TextSpan>[
                                        TextSpan(text: 'Piko', style: TextStyle(fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: Text(
                                    "Jumlah yang perlu dibayar:",
                                    style: CustomText.regular12Teal,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Rp 312.091",
                                    style: CustomText.medium22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 23),
                      child: Text("Instruksi Pembayaran", style: CustomText.medium20Teal,),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.teal)),
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
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
                                    "ATM",
                                    style: CustomText.regular16,
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                                color: Colors.teal,
                              )
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
                        onTap: () {},
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
                                      "assets/images/ic_logo_bank_mandiri.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Internet Banking",
                                    style: CustomText.regular16,
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                                color: Colors.teal,
                              )
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
                        onTap: () {},
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
                                      "assets/images/ic_logo_bank_mandiri.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Mobile Banking",
                                    style: CustomText.regular16,
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                                color: Colors.teal,
                              )
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
