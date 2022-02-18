import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/main.dart';
import 'package:flutter_base/onboarding.dart';
import 'package:flutter_base/phonenumber.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/user_widget.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_pilih_rekening/sbmax_pilih_rekening_page.dart';
import 'package:flutter_base/welcome.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_view/pin_view.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_bill.dart';
import 'package:pin_code_view/pin_code_view.dart';

class SbmaxPin extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SbmaxPinState();
}

class _SbmaxPinState extends State<SbmaxPin> {

  double bottomSheetTopPosition = 50;
  Timer _timer;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    // startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body:
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          child: PinCode(
            title: Text(
              "PIN Transaksi",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            
            subTitle: Text(
              "Masukan PIN Transaksi yang digunakan sebagai \nsecurity code setiap transaksi yang akan dilakukan",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            codeLength: 6,
            // you may skip correctPin and plugin will give you pin as
            // call back of [onCodeFail] before it clears pin
            correctPin: "123456",
            onCodeSuccess: (code) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SbmaxPilihRekeningPage()));
            },
            onCodeFail: (code) {
              print(code); 
            }, 
          )
        )
          
        
        // Container(
        //   color: Colors.white,
        //   height: MediaQuery.of(context).size.height,
        //   child: SingleChildScrollView(
        //       child:Container(
        //         color: Colors.white,
        //         padding: EdgeInsets.all(20),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: <Widget>[
        //             // SvgPicture.asset("assets/svg/ic-verifikasi-email.svg"),
        //             Container(
        //               width: MediaQuery.of(context).size.width,
        //               child: Text(
        //                 "PIN Transaksi",
        //                 style: CustomText.bold18,
        //               ),
        //             ),
        //             Container(
        //               width: MediaQuery.of(context).size.width,
        //               margin: EdgeInsets.only(top: 16),
        //               child: Text(
        //                 "Masukan PIN Transaksi yang digunakan sebagai \nsecurity code setiap transaksi yang akan dilakukan",
        //                 style: CustomText.regular12,
        //               ),
        //             ),
        //             Container(
        //               padding: EdgeInsets.only(right: 16, left: 16),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                       child: PinView (
        //                           count: 6,
        //                           autoFocusFirstField: false,
        //                           enabled: true, // this makes fields not focusable
        //                           submit: (String pin){
        //                             Navigator.push(
        //                               context,
        //                               MaterialPageRoute(
        //                                   builder: (context) => SBMaxChooseBill()));
        //                           }
        //                       )
        //                   ),
        //                 ],
        //               )
        //             )
        //           ],
        //         ),

        //       )
        //   ),
        // )
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

}
