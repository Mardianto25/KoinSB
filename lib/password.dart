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
import 'package:flutter_base/verifikasi_password_thankyou.dart';
import 'package:flutter_base/welcome.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/widget/custom_registration_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Password extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PasswordState();
}

class _PasswordState extends State<Password> {
  var passKey = GlobalKey<FormFieldState>();
  var cpassKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _enable = false;
  String password, cpassword;

  double bottomSheetTopPosition = 50;
  bool passwordVisible = true;
  bool passwordVisibleConfirmation = true;
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        bottomSheetTopPosition = 0;
      });
    });
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
          autovalidate: _autoValidate,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Container(
                  color: Colors.white,
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: CustomBoxDecoration.registrationBox,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: SvgPicture.asset(
                                "assets/svg/ic-set-password.svg",
                              ),
                            ),
                            Container(
                              margin:
                              EdgeInsets.only(left: 34, right: 34, top: 34),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Set Password Akun",
                                        style: CustomText.regular24White,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                              EdgeInsets.only(left: 34, right: 34, top: 22),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Password",
                                        style: CustomText.bold14White,
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    key: passKey,
                                    keyboardType: TextInputType.text,
                                    obscureText: passwordVisible,
                                    style: CustomText.regular16White,
                                    onChanged: (String string){
                                      setState(() {
                                        _enable = false;
                                      });
                                      if(string != "" || cpassKey.currentState.value) {
                                        if (string ==
                                            cpassKey.currentState.value) {
                                          setState(() {
                                            _enable = !_enable;
                                          });
                                        }
                                      }
                                    },
                                    validator: (String string){
                                      setState(() {
                                        _enable = false;
                                      });
                                      if(string != "" || cpassKey.currentState.value) {
                                        if (string == cpassKey.currentState.value) {
                                          setState(() {
                                            _enable = !_enable;
                                          });
                                        }
                                      }
                                    },
                                    onSaved: (String val){
                                      password = val;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Cth: Dimas123",
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              passwordVisible = !passwordVisible;
                                            });
                                          },
                                          child: Icon(
                                            passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.white,
                                          ),
                                        ),
                                        hintStyle: CustomText.registrationHint,
                                        enabledBorder: new UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.white))),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin:
                              EdgeInsets.only(left: 34, right: 34, top: 22),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Konfirmasi Password",
                                        style: CustomText.bold14White,
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    key: cpassKey,
                                    keyboardType: TextInputType.text,
                                    obscureText: passwordVisibleConfirmation,
                                    style: CustomText.regular16White,
                                    onChanged: (String string){
                                      setState(() {
                                        _enable = false;
                                      });
                                      if(string == passKey.currentState.value){
                                        setState(() {
                                          _enable = !_enable;
                                        });
                                      }
                                    },
                                    validator: (String string){
                                      setState(() {
                                        _enable = false;
                                      });
                                      if(string == passKey.currentState.value){
                                        setState(() {
                                          _enable = !_enable;
                                        });
                                      }
                                    },
                                    onSaved: (String val){
                                      cpassword = val;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Cth: Dimas123",
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              passwordVisibleConfirmation = !passwordVisibleConfirmation;
                                            });
                                          },
                                          child: Icon(
                                            passwordVisibleConfirmation
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.white,
                                          ),
                                        ),
                                        hintStyle: CustomText.registrationHint,
                                        enabledBorder: new UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.white))),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin:
                              EdgeInsets.only(left: 34, right: 34, top: 16),
                              child: Text(
                                "Password minimal 8 karakter terdiri dari huruf, angka dan wajib menggunakan satu huruf besar",
                                style: CustomText.regular12White,
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
              GestureDetector(
                onTap: _validateInputs,
                child: Container(
                    color: Color(0xff71ab3c),
                    padding: EdgeInsets.all(30),
                    child: CustomRegistrationButton("SET PASSWORD", _enable)),
              )
            ],
          ),
        )
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if(password == cpassword) {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder:(context) => VerifikasiPasswordThankyou()
            )
        );
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }

  }
}
