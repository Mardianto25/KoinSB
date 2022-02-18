import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_bloc.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_event.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_handle_bloc.dart';
import 'package:flutter_base/bloc/phone_otp/phone_otp_state.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_bloc.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_state.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_success_bloc.dart';
import 'package:flutter_base/phonenumber.dart';
import 'package:flutter_base/resource/strings.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/pin_phone/pin_phone_page.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_view/pin_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneOtpForm extends StatefulWidget {
  @override
  State<PhoneOtpForm> createState() => _PhoneOtpFormState();

}

class _PhoneOtpFormState extends State<PhoneOtpForm> {
  final _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _no_ktp, _email, _imei, _pin;
  bool _enable = false;
  bool _autoValidate=false, _loading = false;

  @override
  void initState() {  
    super.initState();
      _getEmail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _no_ktp = prefs.getString('ktp');
    _email = prefs.getString('email');
    _imei = prefs.getString('imei');
    _phoneController.text = prefs.getString('phonenumber');
    if( _phoneController.text == null || _phoneController.text.isEmpty){
      _phoneController.text ="";
    }
  }

  
  
  @override
  Widget build(BuildContext context) {
    _onPhoneOtpButtonPressed() {
      BlocProvider.of<PhoneOtpBloc>(context).add(
        PhoneOtpButtonPressed(
          phone: _phoneController.text,
          ktp: _no_ktp,
          imei: _imei
          // otpCode: _pin
        ),
      );
    }


    return BlocListener<PhoneOtpBloc, PhoneOtpState>(
      listener: (context, state) {
        if (state is PhoneOtpLoading){
          success2();
        }
        if (state is PhoneOtpFailure) {
          var timer = Timer(Duration(seconds: 1), () {
            Navigator.pop(context);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
        if (state is PhoneOtpInitial) {

          var timer = Timer(Duration(seconds: 1), () {
            Navigator.pop(context);
            Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_){
                  return PinPhonePage(phone: _phoneController.text,);
                }
            ));
          });
          
        }
       
      },
      child: BlocBuilder<PhoneOtpBloc, PhoneOtpState>(
        builder: (context, state) {
          return Form(
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
                            SvgPicture.asset("assets/svg/ic-verifikasi.svg"),
                            Container(
                              padding: EdgeInsets.only(bottom: 32),
                              child: Column(
                                children: <Widget>[
                                  Center(
                                      child: Container(
                                        padding: EdgeInsets.all(16),
                                        child: Text(
                                            "Masukkan Nomor Ponsel",
                                            style: CustomText.bold14
                                        ),
                                      )
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.done,
                                      style: CustomText.regular16,
                                      onChanged: (text) {
                                        setState(() {
                                          _enable = false;
                                        });
                                        if (Validator.validatePhoneNumber(text) == null) {
                                          _enable = true;
                                        }
                                      },
                                      controller: _phoneController,
                                      validator: Validator.validatePhoneNumber,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE6C125)),),
                                          hintText: "Cth : 085695393166"
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
                      onTap:(){
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          state is! PhoneOtpLoading ? _onPhoneOtpButtonPressed() : Container();
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder:(context) => PinPhonenumber()
                          //     )
                          // );
                        } else {
                          setState(() {
                            _autoValidate = true;
                          });
                        }
                      },
                       
                      child: CustomRegistrationButton("KIRIM KODE OTP", _enable)
                  ),
                ],
              ),
            ),
          );        
        },
      ),
    );
  }
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // Navigator.of(context).push(
      //     MaterialPageRoute(
      //         builder:(context) => PinPhonenumber()
      //     )
      // );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  success2(){
    return showDialog(
      context: context,
      barrierDismissible: false, 
      useRootNavigator: false,     
      builder: (context) => new AlertDialog(
            content:
            Container(

            width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height, 
            child: Container(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Loading ...", style: CustomText.bold12Black,),
                  )
                ],
              ),
            ),
          )
        ),
    ) ??
    false;
  }

}
