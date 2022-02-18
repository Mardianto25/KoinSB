import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/code_referral.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_loan_of_goods.dart';
import 'package:flutter_base/dashboard/loan_list.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickmiSuccessLoan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PickmiSuccessLoanState();
}

class _PickmiSuccessLoanState extends State<PickmiSuccessLoan> {
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
                        child: SvgPicture.asset("assets/svg/ic-success-01.svg")
                    ),
                    Container(
                      padding: EdgeInsets.only(top:18, left:18, right: 18),
                      child: Text(
                        "Silahkan Tunggu Pinjaman Anda",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Sedang Kami Proses",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:16.0, right: 16.0, top: 16),
                      child: Text(
                        "Ketika pinjaman selesai kami proses maka akan tampil pada halaman dashboard bagian list pinjamanmu",
                        textAlign: TextAlign.center,
                        style: CustomText.regular13,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:16.0, right: 16.0, top: 5),
                      child: Text(
                        "Khusus Pickmi Barang, alamat pengiriman dikirimkan sesuai data yang  telah dimasukkan pada saat registrasi",
                        textAlign: TextAlign.center,
                        style: CustomText.regular13,
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoanList()));

                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: CustomRegistrationButton("LIST PRODUCK PINJAMAN", true)),
                ),
              ],
            )));
  }
}
