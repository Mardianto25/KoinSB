import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/main.dart';
import 'package:flutter_base/onboarding.dart';
import 'package:flutter_base/pin_email.dart';
import 'package:flutter_base/resource/strings.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/user_widget.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/welcome.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Email extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _EmailState();
}

class _EmailState extends State<Email> {

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
      resizeToAvoidBottomPadding: false,
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
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Strings.verifikasiEmail,
                          style: CustomText.bold18,
                        ),
                        Container(
                          margin: EdgeInsets.all(16),
                          child: Text(
                            Strings.verifikasiEmailSubtitle,
                            style: CustomText.regular13,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SvgPicture.asset("assets/svg/ic-verifikasi.svg"),
                        Container(
                          padding: EdgeInsets.only(bottom: 32),
                          child: Column(
                            children: <Widget>[
                              Center(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                        "Masukkan alamat Email",
                                        style: CustomText.bold14
                                    ),
                                  )
                              ),
                              SizedBox(
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.emailAddress,
                                  style: CustomText.regular16,
                                  onChanged: (text) {
                                    setState(() {
                                      _enable = false;
                                    });
                                    if (Validator.validateEmail(text) == null) {
                                      _enable = true;
                                    }
                                  },
                                  validator: Validator.validateEmail,
                                  decoration: InputDecoration(
                                      hintText: "Cth : dimas@email.com"
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
              builder:(context) => PinEmail()
          )
      );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

}
