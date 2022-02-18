import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/email.dart';
import 'package:flutter_base/main.dart';
import 'package:flutter_base/onboarding.dart';
import 'package:flutter_base/password.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/user_widget.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/verifikasi_thankyou_registration.dart';
import 'package:flutter_base/welcome.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/widget/custom_registration_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Ektp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _EktpState();
}

class _EktpState extends State<Ektp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _enable = false;
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

  void validateEktpField() {

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
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Container(
                      padding: EdgeInsets.all(32),
                      // alignment: Alignment.bottomCenter,
                      decoration: CustomBoxDecoration.registrationBox,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Container(
                            //   child: SvgPicture.asset(
                            //     "assets/svg/ic-signup.svg",
                            //   ),
                            // ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Ayo! Buat akun", style: CustomText.regular24White,),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 5),
                              child: Text("KoinSB", style: CustomText.regular24White,),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 22),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Nomor e-KTP", style: CustomText.bold14White,),
                                    ],
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: CustomText.regular16White,
                                    onChanged: (text) {
                                      setState(() {
                                        _enable = false;
                                      });
                                      if (Validator.validateEktp(text) == null) {
                                        _enable = true;
                                      }
                                    },
                                    validator: Validator.validateEktp,
                                    decoration: InputDecoration(
                                        hintText: "Cth: 3212345678910002",
                                        hintStyle: CustomText.registrationHint,
                                        enabledBorder: new UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.white)
                                        )
                                    ),
                                  ),
                                 
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 22),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Nama Depan", style: CustomText.bold14White,),
                                    ],
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    style: CustomText.regular16White,
                                    
                                    validator: Validator.validateEktp,
                                    decoration: InputDecoration(
                                        hintText: "Cth: Dimas",
                                        hintStyle: CustomText.registrationHint,
                                        enabledBorder: new UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.white)
                                        )
                                    ),
                                  ),
                                 
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 22),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Nama Belakang", style: CustomText.bold14White,),
                                    ],
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    style: CustomText.regular16White,
                                    validator: Validator.validateEktp,
                                    decoration: InputDecoration(
                                        hintText: "Cth: Dimas",
                                        hintStyle: CustomText.registrationHint,
                                        enabledBorder: new UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.white)
                                        )
                                    ),
                                  ),
                                 
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                ),
              ),

              GestureDetector(
                onTap: _validateInputs,
                child: Container(
                    color: Color(0xff71ab3c),
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: CustomRegistrationButton("BUAT AKUN", _enable)

                ),
              )
            ],
          ),
        )
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>  VerifikasiThankyouRegistration()
          )
      );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}