import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/komersial/komersial_success.dart';
import 'package:flutter_base/dashboard/loan_detail/payment_bank.dart';
import 'package:flutter_base/dashboard/loan_detail/payment_koinsb.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChoosePayMentInstallment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChoosePayMentInstallmentState();
  }
}

class _ChoosePayMentInstallmentState extends State<ChoosePayMentInstallment> {
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
          title: Text("Pembayaran Cicilan",
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
                        "Pilih Metode Pembayaran",
                        style: CustomText.medium18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      child: Text(
                        "Silahkan pilih metode pembayaran cicilan",
                        style: CustomText.regular12,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      decoration: new BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0))),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 20, top: 13, bottom: 13),
                        child: Text(
                          "Pinjaman NAMA PRODUK",
                          style: CustomText.regular15White,
                        ),
                      ),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.teal),
                          borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0))),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20, top: 13, bottom: 13, right: 20),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "No. Pinjaman",
                                      style: CustomText.medium12Teal,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 3),
                                      child: Text(
                                        "0000000000",
                                        style: CustomText.medium11,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Cicilan Ke",
                                      style: CustomText.medium11Teal,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 3),
                                      child: Text(
                                        "1",
                                        style: CustomText.medium11,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Pinjaman Selesai",
                                      style: CustomText.medium11Teal,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 3),
                                      child: Text(
                                        "DD/MM/YYYY",
                                        style: CustomText.medium11,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.5, bottom: 13),
                              color: Colors.teal,
                              height: 0.5,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Nominal Cicilan",
                                    style: CustomText.medium16Teal,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 6),
                                    child: Text(
                                      "Rp0.000.000",
                                      style: CustomText.medium16,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentKoinSB()));
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
                                    child: SvgPicture.asset(
                                        "assets/svg/dashboard/ai-svg/ic-koin-dashboard.svg"),
                                  ),
                                  Text(
                                    "KOIN-SB",
                                    style: CustomText.regular16,
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios, size: 24,)
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentBank()));
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
                                        "assets/images/ic_bank_transfer.png", fit: BoxFit.cover,),
                                  ),
                                  Text(
                                    "Transfer Bank",
                                    style: CustomText.regular16,
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios, size: 24,)
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

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: Text(
                                "Password Transaksi",
                                style: CustomText.bold16,
                              ),
                            ),
                            TextFormField(
                              obscureText: _obscureTextOld,
                              onSaved: (val) => _pass = val,
                              decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  hintStyle: CustomText.regular16,
                                  fillColor: Theme.of(context).primaryColor,
                                  hintText: '',
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.remove_red_eye),
                                      onPressed: () {
                                        setState(() {
                                          _obscureTextOld = !_obscureTextOld;
                                        });
                                      })),
                            ),
                          ],
                        ))),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: Text(
                    "Lupa Password Transaksi?",
                    textAlign: TextAlign.end,
                    style: CustomText.regular14,
                  ),
                ),
                Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => MikroSummary()));
                      },
                      child: Container(
                          padding: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          child: CustomRegistrationButton("KONFIRMASI", true)),
                    )),
              ],
            ));
      },
    );
  }
}
