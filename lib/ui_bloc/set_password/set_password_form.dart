import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_base/bloc/set_password/set_password_bloc.dart';
import 'package:flutter_base/bloc/set_password/set_password_event.dart';
import 'package:flutter_base/bloc/set_password/set_password_state.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/verifikasi_password_thankyou.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_view/pin_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetPasswordForm extends StatefulWidget {
  @override
  State<SetPasswordForm> createState() => _SetPasswordFormState();

}

class _SetPasswordFormState extends State<SetPasswordForm> {
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  var passKey = GlobalKey<FormFieldState>();
  var cpassKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _enable = false, _loading = false;
  // String password, cpassword;

  double bottomSheetTopPosition = 50;
  bool passwordVisible = true;
  bool passwordVisibleConfirmation = true;
  
  String _no_ktp, _email, _imei, _name, _phone;
  int _isAnggota;

  @override
  void initState() {  
    super.initState();
      _getEmail();
  }

  getDataLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loginStatus", null);    
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
    _name = prefs.getString('name');
    _phone = prefs.getString('phonenumber');
    _isAnggota = prefs.getInt('isAnggota');
  }

  
  
  @override
  Widget build(BuildContext context) {
    _onSetPasswordButtonPressed() {
      BlocProvider.of<SetPasswordBloc>(context).add(
        SetPasswordButtonPressed(
          ktp: _no_ktp,
          imei: _imei,
          phone: _phone,
          email: _email,
          name: _name,
          password: _passwordController.text,
          isAnggota: _isAnggota
        ),
      );
    }


    return BlocListener<SetPasswordBloc, SetPasswordState>(
      listener: (context, state) {
        if (state is SetPasswordLoading){
          success2();
        }
        if (state is SetPasswordFailure) {          
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
        if (state is SetPasswordInitial) {
          // BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          setState(() {
            getDataLogin();
          });
          var timer = Timer(Duration(seconds: 1), () {
            Navigator.pop(context);
            Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_){
                  return VerifikasiPasswordThankyou();
                }
            ));
          });
          
        }
       
      },
      child: BlocBuilder<SetPasswordBloc, SetPasswordState>(
        builder: (context, state) {
          return  Form(
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
                                    controller: _passwordController,
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
                                    controller: _rePasswordController,
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
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    if(_passwordController.text == _rePasswordController.text) {
                      _onSetPasswordButtonPressed();
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //         builder:(context) => VerifikasiPasswordThankyou()
                      //     )
                      // );
                    }
                  } else {
                    setState(() {
                      _autoValidate = true;
                    });
                  }
                },
                child: Container(
                    color: Color(0xff71ab3c),
                    padding: EdgeInsets.all(30),
                    child: CustomRegistrationButton("SET PASSWORD", _enable)),
              )
            ],
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
