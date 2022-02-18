import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/komersial/komersial_success.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum paymentChar { a, b, c }

class PaymentKoinSB extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaymentKoinSBState();
  }
}

class _PaymentKoinSBState extends State<PaymentKoinSB> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  var _pass;
  bool _obscureTextOld = true;

  paymentChar _char = paymentChar.a;

  List<String> _listBillNum = ["8881100020", "8881100021", "8881100022"];
  List<String> _listBalance = ["500.000", "300.000", "300.000"];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("KOIN-SB", style: Theme.of(context).textTheme.title),
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
                        "Menggunakan tabungan KOIN-SB",
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
                      margin: EdgeInsets.only(top: 12),
                      decoration: new BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0))),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 20, top: 13, bottom: 13),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              width: 54,
                              height: 22,
                              child: Image.asset(
                                  "assets/images/ic_splash_koin_white.png"),
                            ),
                            Text(
                              "Pilih Rekening KOIN-SB",
                              style: CustomText.regular16White,
                            ),
                          ],
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
                        child: _radioList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                        padding: EdgeInsets.only(bottom: 0),
                        width: double.infinity,
                        child: CustomRegistrationButton("BAYAR", true)),
                  ),
                ))
          ],
        ));
  }

  Widget _radioList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: paymentChar.values.length,
        itemBuilder: (context, index) {
          return Container(
            child: RadioListTile<paymentChar>(
              activeColor: Colors.teal,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'KOIN-SB',
                        style: CustomText.regular12,
                      ),
                      Text(_listBillNum[index], style: CustomText.regular12),
                      (_char == paymentChar.values[index])
                          ? _checkBalanceText(index)
                          : Container()
                    ],
                  ),
                  (_char == paymentChar.values[index])
                      ? _checkBalance(index)
                      : Text('Rp ' + _listBalance[index].toString(),
                          style: CustomText.medium14)
                ],
              ),
              value: paymentChar.values[index],
              groupValue: _char,
              onChanged: (paymentChar value) {
                setState(() {
                  _char = value;
                });
              },
            ),
          );
        });
  }

  Widget _checkBalance(int index) {
    if (double.parse(_listBalance[index]) < 500.000) {
      return Text('Rp ' + _listBalance[index].toString(),
          style: TextStyle(
              color: Color(0xffff0000),
              fontSize: 14,
              fontFamily: 'NeoSansW1GMedium'));
    } else {
      return Text('Rp ' + _listBalance[index].toString(),
          style: CustomText.medium14Teal);
    }
  }

  Widget _checkBalanceText(int index) {
    if (double.parse(_listBalance[index]) < 500.000) {
      return Text('Saldo Tidak Cukup',
          style: TextStyle(
              color: Color(0xffff0000),
              fontSize: 10));
    } else {
      return Text('Saldo Cukup', style: CustomText.regular10Teal);
    }
  }

}
