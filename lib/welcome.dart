import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/ektp.dart';
import 'package:flutter_base/main.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/onboarding.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/user_widget.dart';
import 'package:flutter_base/ui_bloc/login/login_main.dart';
import 'package:flutter_base/ui_bloc/login/login_page.dart';
import 'package:flutter_base/ui_bloc/register/register_main.dart';
import 'package:flutter_base/ui_bloc/register/register_page.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login.dart';

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  double bottomSheetTopPosition = 50;

  @override
  void initState() {
    super.initState();
    
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        bottomSheetTopPosition = 0;
      });
    });
  }

   Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Apakah anda yakin?'),
            content: new Text('Anda akan Keluar'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: FlatButton(
                  child: Text(
                    "No",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: FlatButton(
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: SvgPicture.asset(
                    'assets/svg/ic-splash-koin.svg',
                    width: 132,
                    height: 54,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 32),
                  child: SvgPicture.asset(
                    'assets/svg/ic-welcome.svg',
                    width: 320,
                    height: 164,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff71ab3c),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 32),
                          child: Text(
                            "Selamat Datang",
                            textAlign: TextAlign.center,
                            style: CustomText.bold24White,
                          ),
                        ),
                        Container(
                          width: 286,
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            "Semua kebutuhan simpanan anggota Koperasi Simpan Pinjam Sejahtera Bersama dalam satu aplikasi",
                            textAlign: TextAlign.center,
                            style: CustomText.regular12White,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.pop(context);                          
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_){
                                    return RegisterPage();
                                  }
                                )
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 16,right: 16, top: 23),
                            child: CustomRegistrationButton("MENJADI ANGGOTA", true),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_){
                                      return LoginMain();
                                    }
                                ));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 16,right: 16),
                            child:
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: MaterialButton(
                                padding: EdgeInsets.all(16),
                                child:Text(
                                  "MASUK",
                                  style: TextStyle(fontSize: 14,color: Colors.black, fontFamily: "NeoSansW1gMedium"),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20,right: 20, bottom: 20, top: 25),
                          child: Text(
                            "Dengan masuk atau mendaftar, kamu menyetujui ketentuan layanan dan kebijakan Privasi",
                            textAlign: TextAlign.center,
                            style: CustomText.regular11White,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          )
      ),
    );
  }
}
