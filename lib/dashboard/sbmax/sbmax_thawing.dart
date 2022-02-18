import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_detail_saving.dart';
import 'package:flutter_base/dashboard/home.dart';



class SBMaxThawing extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SBMaxThawingState();
}

class _SBMaxThawingState extends State<SBMaxThawing> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  var _pass;
  bool _obscureTextOld = true;
  double bottomSheetTopPosition = 50;

  @override
  void initState() {
    super.initState();

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
        title: Text("Atur SB Maximal",
              style: Theme.of(context).textTheme.title),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: SvgPicture.asset("assets/svg/ic-success-01.svg")
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Cairkan SB Maximal",
                    textAlign: TextAlign.center,
                    style: CustomText.bold18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    "Pencairan sebelum tanggal jatuh tempo akan dikenakan \nbiaya pinalti sebesar 5% dari besar penempatan \nSimpanan Berjangka Maximal",
                    textAlign: TextAlign.center,
                    style: CustomText.regular12,
                  ),
                )

              ],
            ),
            GestureDetector(
              onTap: (){
                _showDialog();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                child: CustomRegistrationButton("CAIRKAN SIMPANAN BERJANGKA INI", true)
              ),
            ),
          ],
        )
      )
    );
  }
   void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 15.0, bottom: 18.0),
                              child: Text(
                                "Password Transaksi",
                                style: CustomText.bold16,
                              ),
                            ),
                            TextFormField(
                              obscureText: _obscureTextOld,
                              onSaved: (val) => _pass = val,
                              decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff707070), width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff707070), width: 1.0),
                                  ),
                                  hintStyle: CustomText.regular16,
                                  fillColor: Theme.of(context).primaryColor,
                                  hintText: '',
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.remove_red_eye),
                                      onPressed: () {
                                        setState(() {
                                          _obscureTextOld = !_obscureTextOld;
                                        });
                                      })),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16, bottom: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(""),
                                  ),
                                  Container(
                                    child: Text("Lupa password transaksi?", style: CustomText.regular14,),
                                  ),
                                ],
                              )
                            )
                            
                          ],
                        ))),
                
                Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => Home()));
                       _showDialogSuccess();
                       
                      },
                      child: Container(
                          padding: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          child: CustomRegistrationButton("KONFIRMASI", true)),
                    )),
              ],
            ));
      },
    );
  }

  void _showDialogSuccess() {
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
                  "Transaksi Berhasil",
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
