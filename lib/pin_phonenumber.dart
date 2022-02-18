import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/verifikasi_thankyou.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_view/pin_view.dart';
class PinPhonenumber extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _PinPhonenumberState();
}

class _PinPhonenumberState extends State<PinPhonenumber> {

  double bottomSheetTopPosition = 50;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SvgPicture.asset("assets/svg/ic-verifikasi-ponsel.svg"),
                Container(
                  child: Text(
                    "Kode verifikasi OTP sudah di kirim",
                    style: CustomText.bold18,
                  ),
                  padding: EdgeInsets.only(top: 28),
                  alignment: Alignment.topLeft,
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "4-digit kode verifikasi OTP telah dikirimkan ke nomor",
                            style: CustomText.regular13,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "+6281234567890",
                            style: CustomText.bold13,
                          ),
                          GestureDetector(
                            child: Text(
                              "    Ganti Nomor Ponsel",
                              style: CustomText.regular13Primary,
                            ),
                            onTap: (){
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                        child: PinView (
                            count: 4,
                            autoFocusFirstField: false,
                            enabled: true, // this makes fields not focusable
                            submit: (String pin){
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder:(context) => VerifikasiThankyou()
                                  )
                              );
                            }
                        )
                    ),
                    Expanded(
                      child: Text("00.30"),
                    ),
                    GestureDetector(
                      child: Opacity(
                        opacity: 0.5,
                        child:Text("Kirim ulang OTP")
                      ),
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder:(context) => VerifikasiThankyou()
                            )
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )


    );
  }

}
