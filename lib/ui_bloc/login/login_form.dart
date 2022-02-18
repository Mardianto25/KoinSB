import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/login/login_bloc.dart';
import 'package:flutter_base/bloc/login/login_event.dart';
import 'package:flutter_base/bloc/login/login_state.dart';
import 'package:flutter_base/dashboard/home.dart';
import 'package:flutter_base/dashboard/main.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/email_otp/email_page.dart';
import 'package:flutter_base/ui_bloc/phone_otp/phone_otp_page.dart';
import 'package:flutter_base/ui_bloc/referral/referral_page.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  bool passwordVisible = true;
  bool _enable = false;
  bool _autoValidate=false;
  bool _loading=false;
  
  LoginBloc _loginBloc;
  String _platformImei = 'Unknown', _cek;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();

  Future<void> initPlatformState() async {
    String platformImei;
    try {
      platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
    } on PlatformException {
      platformImei = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformImei = platformImei;
    });
  }


  @override
  void initState() {
    super.initState();
    initPlatformState();
    // delete();
    // getDataLogin();
  }

  delete() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("pikoStatus");
    
  }
  

  void getDataLogin(data) async{
    print(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(data =="done"){
      prefs.setString("loginStatus", data);    
    }else{
      prefs.setString("loginStatus", null);          
    }
  }

  void _setPhone()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phonenumber', _usernameController.text);
  }

  _onLoginButtonPressed() {
    _setPhone();
      BlocProvider.of<LoginBloc>(context).add(
        Submitted(
          username: _usernameController.text,
          password: _passwordController.text,
          imei: _platformImei
          // imei: "354921076706315"
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {

        if (state is LoginLoading) {
          // // return LoadingIndicator();

          setState(() {
            _loading = true;
            // success2();          
          });
        }
        if (state is LoginFailure) {
          setState(() {
            _loading = false;                      
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
         
        }
        if (state is LoginInitial) {
            // Navigator.pop(context);
            setState(() {
              _loading = false; 
            });
            _cek = state.loginStatus.response.data.status;                     
            getDataLogin(_cek);
            //             
            // BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            if (_cek == null || _cek.isEmpty){
             Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (_){
                    return MemberData();
                    }
                )
             );

            }
            else if (_cek == "done"){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_){
                        return Main();
                      }
                  )
                
              );
            }else{
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (_){
                    return MemberData();
                    }
                )
             );
            }
          // }
        }

        if (state is LoginPikoInitial){
          setState(() {
            _loading = false;                      
          });
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_){
                  return EmailPage();
                }
            ));
        }
       
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return _loading ? Center(child: CircularProgressIndicator(),):Column(
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: SvgPicture.asset(
                                "assets/svg/ic-login.svg",
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
                                        "Hi! Selamat Datang",
                                        style: CustomText.regular24White,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Kembali",
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
                                        "Nomor Ponsel",
                                        style: CustomText.regular12White,
                                      ),
                                    ],
                                  ), 
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    style: CustomText.regular16White,
                                    controller: _usernameController,
                                    focusNode: _phoneFocus,
                                    onFieldSubmitted: (term){
                                      _fieldFocusChange(context, _phoneFocus, _passFocus);
                                    },
                                    validator: Validator.validatePhoneNumber,
                                    decoration: InputDecoration(
                                        hintText: "Cth: 081234567890",
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
                                        "Password",
                                        style: CustomText.regular12White,
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    // key: passKey,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    obscureText: passwordVisible,
                                    focusNode: _passFocus,
                                    style: CustomText.regular16White,
                                    controller: _passwordController,
                                    onFieldSubmitted: (value){
                                      _passFocus.unfocus();
                                      _saved();
                                    },
                                    validator:Validator.validatePassword,
                                    onChanged: (_){
                                      setState(() {
                                        _enable = false;
                                      });
                                      if(_.length >= 8){
                                        _enable = !_enable;
                                      }
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
                          ],
                        ),
                      ),
                    )),
              ),
            ),

            GestureDetector(
                onTap:() {
                   _saved();
                  //  Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (_){
                  //         return MemberData();
                  //       }
                  //   ));
                  },
                child: Container(
                    color: Color(0xff71ab3c),
                    padding: EdgeInsets.all(30),
                    child: CustomRegistrationButton("LOGIN", _enable)),
            ),
          ],
        );
        },
      ),
    );
  }

  success2(){
    return showDialog(
      context: context,
      barrierDismissible: false,      
      builder: (context) => new AlertDialog(
            content:
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.4, 
            child: Center(
              child:!_loading ? CircularProgressIndicator() : Navigator.of(context).pop(),
            ),
          )
        ),
    ) ??
    false;
  }

  void _saved(){
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
        _setLastPage();
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) => Main()
        // ));
         _onLoginButtonPressed();
    
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _setLastPage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last', "login");
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
  }

  


}
