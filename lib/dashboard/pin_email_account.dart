import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/main.dart';
import 'package:flutter_base/onboarding.dart';
import 'package:flutter_base/phonenumber.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/user_widget.dart';
import 'package:flutter_base/welcome.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_view/pin_view.dart';
import 'package:pinput/pin_put/pin_put.dart';


class PinEmailAccount extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _PinEmailAccountState();
}

class _PinEmailAccountState extends State<PinEmailAccount> {

  double bottomSheetTopPosition = 50;
  Timer _timer;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
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
        body:Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child:Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset("assets/svg/ic-verifikasi-email.svg"),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 28),
                      child: Text(
                        "Kode verifikasi OTP sudah di kirim",
                        style: CustomText.bold18,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 16),
                      child: Text(
                        "4-digit kode verifikasi OTP telah dikirimkan ke alamat email dimas@email.com",
                        style: CustomText.regular13,
                      ),
                    ),

                    Row(
                      children: <Widget>[
                        Expanded(
                            child: PinView (
                                count: 4,
                                autoFocusFirstField: false,
                                enabled: true, // this makes fields not focusable
                                submit: (String pin){
                                  Navigator.pop(context);
                                }
                            )
                        ),
                        Expanded(
                            child: Text(
                              "00."+_start.toString(),
                              style: CustomText.regular12,
                            )
                        ),
                        GestureDetector(
                          child: Text(
                            "Kirim ulang OTP",
                            style: CustomText.regular12,
                          ),

                        )

                      ],
                    )

                  ],
                ),

              )
          ),
        )
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
