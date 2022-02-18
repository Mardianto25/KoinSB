import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/change_email/change_email_bloc.dart';
import 'package:flutter_base/bloc/change_email/change_email_event.dart';
import 'package:flutter_base/bloc/change_email/change_email_state.dart';
import 'package:flutter_base/bloc/profile/profile_bloc.dart';
import 'package:flutter_base/bloc/profile/profile_event.dart';
import 'package:flutter_base/bloc/profile/profile_state.dart';
import 'package:flutter_base/bloc/verify_email/verify_email_event.dart';
import 'package:flutter_base/model/response/profile.dart';

import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/verify_email/verify_email_page.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ChangeEmailForm extends StatefulWidget {
  final String email;
  
  ChangeEmailForm({Key key, @required this.email}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ChangeEmailFormState();
  }
}

class _ChangeEmailFormState extends State<ChangeEmailForm> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  TextEditingController _emailController = TextEditingController();
  String _newName;
  var passKey = GlobalKey<FormFieldState>();
  final formKey = new GlobalKey<FormState>();
  bool passwordVisible = true, _loading = false;
  bool _enable = false, _autoValidate = false;
  ResponseProfile list ;
  
  
  @override
  void initState() {
    super.initState();
  }

  _onSubmited() {
    BlocProvider.of<ChangeEmailBloc>(context).add(
      ChangeEmailButtonPressed(
        email: _emailController.text
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeEmailBloc, ChangeEmailState>(
      listener: (context, state) {
        if(state is ChangeEmailLoading){
          setState(() {
             _loading = true;         
          });
        }
        if(state is ChangeEmailFailure){
          setState(() {
             _loading = false;         
          });
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if(state is ChangeEmailInitial){
          // Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyEmailPage(email:_emailController.text, otpId: state.dataRes.response.data.otpId,)));
          setState(() {
             _loading = false;         
          });
        }
      },
      child: 
        Container(
        padding: EdgeInsets.all(16.0),
        child:_loading ? Center(child: CircularProgressIndicator(),) : Stack(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Email Terdaftar",
                      style: CustomText.medium12,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.email,
                      style: CustomText.regular16,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 24.0),
                    child: Text(
                      "Email Baru",
                      style: CustomText.medium12,
                    ),
                  ),
                  TextFormField(
                    // onSaved: (val) => _newName = val,
                    keyboardType: TextInputType.emailAddress,
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
                      hintStyle: CustomText.regular13Grey,
                      fillColor: Theme.of(context).primaryColor,
                      hintText: 'Masukkan email baru anda',
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      _onSubmited();
                    
                    } else {
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  },
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => VerifyEmailPage()));
                  
                  child: CustomRegistrationButton("VERIFIKASI EMAIL", _enable),
                ),
              ),
            )
          ],
        )
      )
    );
  }

  
  
}
