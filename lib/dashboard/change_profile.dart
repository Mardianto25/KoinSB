import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/change_email.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';

class ChangeProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangeProfileState();
  }
}

class _ChangeProfileState extends State<ChangeProfile> {
  String _oldPassword, _newPassword, _rePassword;
  bool _obscureTextOld = true;
  bool _obscureTextNew = true;
  bool _obscureTextRe = true;

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("Ubah Profil", style: Theme.of(context).textTheme.title),
        ),
        body: Container(
            padding: EdgeInsets.all(18.0),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.account_circle,
                              size: 60,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text(
                              "Perbarui Foto Profil",
                              style: CustomText.medium16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text(
                        "Nama Lengkap",
                        style: CustomText.medium12,
                      ),
                    ),
                    TextFormField(
                      onSaved: (val) => _newPassword = val,
                      decoration: InputDecoration(
                          hintStyle: CustomText.regular13Grey,
                          fillColor: Theme.of(context).primaryColor,
                          hintText: 'Nama Lengkap User'),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Email",
                        style: CustomText.medium12,
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Text(
                              "email@email.com",
                              style: CustomText.regular16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangeEmail()));
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text(
                                "Ubah",
                                style: CustomText.medium14Teal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        _showDialog();
                      },
                      child: CustomRegistrationButton("SIMPAN", true),
                    ),
                  ),
                )
              ],
            )));
  }

  // user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 32),
                child: Image.asset("assets/images/ic_dialog_success_01.png"),
              ),
              Container(
                margin: EdgeInsets.only(top: 32, bottom: 32),
                child: Text(
                  "Profil Berhasil Diubah",
                  style: CustomText.medium16,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
