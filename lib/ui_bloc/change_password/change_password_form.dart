import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/change_password/change_password_bloc.dart';
import 'package:flutter_base/bloc/change_password/change_password_event.dart';
import 'package:flutter_base/bloc/change_password/change_password_state.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordFormState();
  }
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  String _oldPassword, _newPassword, _rePassword;
  bool _obscureTextOld = true;
  bool _obscureTextNew = true;
  bool _obscureTextRe = true;
  bool _loading =false, _enable=false;

  TextEditingController _oldController = TextEditingController();
  TextEditingController _newController = TextEditingController();
  TextEditingController _rePassController = TextEditingController();
  
  
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  ChangePasswordBloc _changeBloc;
  
  @override
  void initState() {
      // TODO: implement initState
    _changeBloc = BlocProvider.of<ChangePasswordBloc>(context);      
    super.initState();
  }
  _onLoginButtonPressed() {
    BlocProvider.of<ChangePasswordBloc>(context).add(
      ChangePasswordButtonPressed(
       imei: "",
       oldPass: _oldController.text,
       newPass: _newController.text
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
          body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
            listener: (context, state) {
              if (state is ChangePasswordLoading){
                // loading();
                setState(() {
                  _loading = true;     
                });
              }
              if (state is ChangePasswordFailure) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
                setState(() {
                  _loading = false;     
                });
              }
              if (state is ChangePasswordInitial) {
                setState(() {
                  _loading = false;     
                });
                _showDialog();
                Navigator.pop(context);  
                              
                // success();
                // BlocProvider.of<AddressDataHandleBloc>(context).add(AddressDataSuccess());
              }
            },
            child:_loading ? Center(child: CircularProgressIndicator(),) : Container(
              padding: EdgeInsets.all(16.0),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Password Lama",
                          style: CustomText.medium12,
                        ),
                      ),
                      TextFormField(
                        obscureText: _obscureTextOld,
                        // onSaved: (val) => _oldPassword = val,
                        controller: _oldController,
                        onChanged: (_){
                          setState(() {
                             if(_.length >= 8 && _newController.text == _rePassController.text ){
                               _enable = true;
                             }else{
                               _enable=false;
                             }                     
                          });
                        },
                        validator: Validator.validatePassword,
                        decoration: InputDecoration(
                            hintStyle: CustomText.regular13Grey,
                            fillColor: Theme.of(context).primaryColor,
                            hintText: 'Masukkan password lama',
                            suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    _obscureTextOld = !_obscureTextOld;
                                  });
                                })),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Password Baru",
                          style: CustomText.medium12,
                        ),
                      ),
                      TextFormField(
                        obscureText: _obscureTextNew,
                        // onSaved: (val) => _newPassword = val,
                        
                        validator: Validator.validatePassword,   
                        controller: _newController,
                        onChanged: (_){
                          setState(() {
                             if(_oldController.text.length >= 8 && _ == _rePassController.text ){
                               _enable = true;
                             }else{
                               _enable=false;
                             }                     
                          });
                        },                     
                        
                        decoration: InputDecoration(
                            hintStyle: CustomText.regular13Grey,
                            fillColor: Theme.of(context).primaryColor,
                            hintText: 'Masukkan password baru',
                            suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    _obscureTextNew = !_obscureTextNew;
                                  });
                                })),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Kata sandi minimal 8 karakter, Wajib menggunakan minimal satu huruf kapital dan angka atau tanda baca ",
                          style: CustomText.regular10Grey,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text(
                          "Ulangi Password Baru",
                          style: CustomText.medium12,
                        ),
                      ),
                      TextFormField(
                        obscureText: _obscureTextRe,
                        // onSaved: (val) => _rePassword = val,
                        validator: Validator.validatePassword,                        
                        controller: _rePassController,
                        onChanged: (_){
                          setState(() {
                             if(_oldController.text.length >= 8 && _newController.text == _ ){
                               _enable = true;
                             }else{
                               _enable=false;
                             }                     
                          });
                        },
                        decoration: InputDecoration(
                            hintStyle: CustomText.regular13Grey,
                            fillColor: Theme.of(context).primaryColor,
                            hintText: 'Ulangi password baru',
                            suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    _obscureTextRe = !_obscureTextRe;
                                  });
                                })),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          if(_enable == true){
                            _onLoginButtonPressed();

                          }
                        },
                        child: CustomRegistrationButton("UBAH PASSWORD", _enable),
                      ),
                    ),
                  )
                ],
              )
          )
        ),
       );
  }

  // user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(margin: EdgeInsets.only(top: 32),child: Image.asset("assets/images/ic_dialog_success_01.png"),),
              Container(margin: EdgeInsets.only(top: 32, bottom: 32),child: Text("Password Berhasil Disimpan", style: CustomText.medium16,),)
            ],
          ),
        );
      },
    );
  }
}
