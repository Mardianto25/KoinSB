import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/main.dart';
import 'package:flutter_base/onboarding.dart';
import 'package:flutter_base/pin_email.dart';
import 'package:flutter_base/pin_phonenumber.dart';
import 'package:flutter_base/style/custom_input_decoration.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/user_widget.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/welcome.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PhoneNumber extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Verifikasi Nomor Ponsel",
                            style: CustomText.bold18,
                          ),
                          padding: EdgeInsets.all(16),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Kami akan mengirimkan anda ",
                              textAlign: TextAlign.center,
                              style: CustomText.regular13,
                            ),
                            Text(
                              "One Time Password",
                              textAlign: TextAlign.center,
                              style: CustomText.bold13,
                            ),
                          ],
                        ),
                        Text(
                          "pada nomor ponsel ini",
                          textAlign: TextAlign.center,
                          style: CustomText.regular13,
                        ),
                        Container(
                          child: SvgPicture.asset("assets/svg/ic-verifikasi.svg"),
                          margin: EdgeInsets.all(16),
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 32),
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Text(
                                  "Masukkan Nomor Ponsel",
                                  style: CustomText.bold14,
                                ),
                              ),
                              SizedBox(
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  onChanged: (text) {
                                    setState(() {
                                      _enable = false;
                                    });
                                    if (Validator.validatePhoneNumber(text) == null) {
                                      _enable = true;
                                    }
                                  },
                                  validator: Validator.validatePhoneNumber,
                                  decoration: InputDecoration(
                                      hintText: "Cth : 081234567890",
                                      hintStyle: CustomText.regular16
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ),
              GestureDetector(
                  onTap: _validateInputs,
                  child: CustomRegistrationButton("KIRIM KODE OTP", _enable)
              ),
            ],
          ),
        ),
      )
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).push(
          MaterialPageRoute(
              builder:(context) => PinPhonenumber()
          )
      );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

}
