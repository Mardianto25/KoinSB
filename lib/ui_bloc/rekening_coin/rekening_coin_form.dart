import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/email_otp/email_page.dart';
import 'package:flutter_base/ui_bloc/referral/referral_page.dart';
import 'package:flutter_base/ui_bloc/store_rekening_coin/store_rekening_coin_page.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/widget/custom_roundrec_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RekeningCoinForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RekeningCoinFormState();
}

class _RekeningCoinFormState extends State<RekeningCoinForm> {
  double bottomSheetTopPosition = 50;

  @override
  void initState() {
    super.initState();
  }

  setIsAnggota(data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('isAnggota', data);          
  }

  @override
  Widget build(BuildContext context) {
   return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 40, right: 40, top: 10),
                      margin: EdgeInsets.only(bottom: 28.7),
                      child: SvgPicture.asset("assets/svg/ic-rek-koin.svg")),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Sudah Punya Rekening KOIN",
                        style: CustomText.bold18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16, left: 16, bottom: 16),
                      child: Text(
                        "Apakah anda sudah memiliki rekening tabungan KOIN Koperasi Simpan Pinjam Sejahtera Bersama",
                        textAlign: TextAlign.center,
                        style: CustomText.regular12,
                      ),
                    )
                  ],
                ),
                
              ],
            ),
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
                      setIsAnggota(0);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => EmailPage()
                      ));
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => Main()),
                      //     ModalRoute.withName('/'));
                    },
                    child: Container(
                        width: double.infinity,
                        child: CustomRoundRecButton("TIDAK", false)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => StoreRekeningCoinPage()
                      ));
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 12, bottom: 16),
                        width: double.infinity,
                        child: CustomRoundRecButton("YA", true)),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  
}
