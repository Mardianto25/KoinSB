import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login.dart';


class VerifikasiPasswordThankyou extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _VerifikasiPasswordThankyouState();
}

class _VerifikasiPasswordThankyouState extends State<VerifikasiPasswordThankyou> {

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
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          child: SvgPicture.asset("assets/svg/ic-success-01.svg")
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Password Berhasil Dipasang!",
                            style: CustomText.bold18,
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(right: 48, left: 48),
                        //   child: Text(
                        //     "Silahkan kembali masuk dengan menggunakan email atau nomor ponsel dan password anda",
                        //     textAlign: TextAlign.center,
                        //     style: CustomText.regular13,
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(top: 12, right: 48, left: 48),
                          child: Text(
                            "Untuk user baru anda akan diharuskan mengisi data calon keanggotaan terlebih dahulu",
                            textAlign: TextAlign.center,
                            style: CustomText.regular13,
                          ),
                        )

                      ],
                    ),
                 
                  ],
                )
              ),
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
                        builder: (context) => MemberData()
                      ));
                  },
                  color: Color(0xff096d5c),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "ISI DATA KEANGGOTAAN ",
                      textAlign: TextAlign.center,
                      style: CustomText.medium15White,
                    ),
                  ),
                ),
              ))
          ],
        ),
      )
    );
  }

}
