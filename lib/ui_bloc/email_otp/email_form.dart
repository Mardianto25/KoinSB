import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/email_otp/email_bloc.dart';
import 'package:flutter_base/bloc/email_otp/email_event.dart';
import 'package:flutter_base/bloc/email_otp/email_handle_bloc.dart';
import 'package:flutter_base/bloc/email_otp/email_state.dart';
import 'package:flutter_base/pin_email.dart';
import 'package:flutter_base/resource/strings.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/phone_otp/phone_otp_page.dart';
import 'package:flutter_base/ui_bloc/pin_email/pin_email_page.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class EmailForm extends StatefulWidget {
  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passwordVisible = true;
  EmailBloc _emailBloc;
  bool  _autoValidate=false, _loading = false;
  String _platformImei = 'Unknown';
  bool _enable = false;
  String _no_ktp, _imei;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();


  @override
  void initState() {
    super.initState();
    _getKtp();
  }

  void _getKtp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _no_ktp = prefs.getString('ktp');
    _imei = prefs.getString('imei');
    print(_no_ktp+_imei);
  }

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<EmailBloc>(context).add(
        SubmittedEmail(
          email: _emailController.text,
          ktp: _no_ktp,
          imei: _imei,
        ),
      );
    }

    return BlocListener<EmailBloc, EmailState>(
      listener: (context, state) {
        if (state is EmailLoading){
          success2();
        }
        if (state is EmailFailure) {
          
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
        if (state is EmailInitial) {
          var timer = Timer(Duration(seconds: 1), () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => PinEmailPage(email: _emailController.text,)
            ));
          });
          
        }
       
      },
      child: BlocBuilder<EmailBloc, EmailState>(
        builder: (context, state) {
          return  Form(
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
                                  controller: _emailController,
                                  onChanged: (_){
                                    setState(() {
                                      _enable = false;
                                    });
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                              
                                    if(regex.hasMatch(_)){
                                      _enable = !_enable;
                                    }
                                  },
                                  validator: Validator.validateEmail,
                                  decoration: InputDecoration(
                                      hintText: "Cth : dimas@email.com",
                                      focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE6C125)),),
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
                  onTap:() {
                   if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                        state is! EmailLoading ? _onLoginButtonPressed() : null;
                    
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _emailBloc.add(
      EmailChanged(email: _emailController.text),
    );
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
