import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/address_data/address_data_page.dart';
import 'package:flutter_base/ui_bloc/job_data/job_data_page.dart';
import 'package:flutter_base/ui_bloc/personal_data/personal_data_page.dart';
import 'package:flutter_base/ui_bloc/show_data/show_data_page.dart';
import 'package:flutter_base/ui_bloc/spesimen/spesimen_page.dart';
import 'package:flutter_base/ui_bloc/upload_ktp/upload_ktp_main.dart';
import 'package:flutter_base/ui_bloc/upload_ktp/upload_ktp_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberData extends StatefulWidget {
  MemberData({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MemberDataState createState() => _MemberDataState();
}

class _MemberDataState extends State<MemberData> {
  int _counter = 0;
  String _upload, _personal, _address, _jobs, _spesimen, _cek = "";
  bool _statusButton = false;
  var _btnTxt = [
    "Upload KTP + Selfie",
    "Informasi Pribadi",
    "Data Alamat",
    "Data Pekerjaan",
    "Spesimen Tanda Tangan"
  ];

  var _btnPage = [
    UploadKtpPage(),
    PersonalDataPage(type: ""),
    AddressDataPage(type: ""),
    JobDataPage(type: ""),
    SpesimenPage(
      type: "",
    )
  ];

  @override
  void initState() {
    _getPreference();
    super.initState();
  }

  _getPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // prefs.remove("uploadKtp");
      // prefs.remove("personalSimpan");
      // prefs.remove("addressSimpan");
      // prefs.remove("jobSimpan");
      // prefs.remove("spesimenSimpan");
      

      // prefs.setString("addressSimpan", "done");
      // prefs.setString("personalSimpan", "done");
      // prefs.setString("jobSimpan", "done");
      // prefs.setString("uploadKtp", "done");
      // prefs.setString("spesimenSimpan", "done");
      
      _upload = prefs.getString("uploadKtp");
      _personal = prefs.getString("personalSimpan");
      _address = prefs.getString("addressSimpan");
      _jobs = prefs.getString("jobSimpan");
      _spesimen = prefs.getString("spesimenSimpan");
      _cek = "ada";

      // if (_upload != null &&
      //     _personal != null &&
      //     _address != null &&
      //     _jobs != null &&
      //     _spesimen != null) {
      //   _statusButton = true;
      // } else {
      //   _statusButton = false;
      // }

      if (_upload == null || _personal == null || _address==null || _jobs == null || _spesimen == null){
        _statusButton = false;
      }else{
        _statusButton = true;
      }
    });

    print(_personal);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.close),
              color: Colors.black,
              onPressed: (){ BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()); }),
          title: Text(
            "Data Keanggotaan",
            style: Theme.of(context).textTheme.title,
          ),
        ),
        body: _cek.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  Center(
                      child: Container(
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: Colors.white,
                    ),
                    child:
                        // ListView.builder(
                        //   itemCount: _btnTxt.length,
                        //   itemBuilder: (context, index) {
                        Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 12.0, left: 20.0, right: 20.0),
                            child: new MaterialButton(
                                color: _upload == "done"
                                    ? Colors.teal
                                    : Colors.white,
                                child: new Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: 32.0, left: 10.0, bottom: 32.0),
                                  child: Text(
                                    "Upload KTP + Selfie",
                                    style: _upload == "done"
                                        ? CustomText.regular15White
                                        : CustomText.regular15Teal,
                                  ),
                                ),
                                onPressed: () {
                                    if(_upload != null){
                                      
                                    }else{
                                      Navigator.pop(context); 
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UploadKtpPage()));
                                    }

                                },
                                elevation: 5.0,
                                shape: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.5))),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 12.0, left: 20.0, right: 20.0),
                            child: new MaterialButton(
                                color: _personal == "done"
                                    ? Colors.teal
                                    : Colors.white,
                                child: new Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: 32.0, left: 10.0, bottom: 32.0),
                                  child: Text(
                                    "Informasi Pribadi",
                                    style: _personal == "done"
                                        ? CustomText.regular15White
                                        : CustomText.regular15Teal,
                                  ),
                                ),
                                onPressed: () {
                                  if(_personal != null){
                                      
                                  }else{
                                    Navigator.pop(context); 
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PersonalDataPage(type: "",)));
                                  }
                                },
                                elevation: 5.0,
                                shape: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.5))),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 12.0, left: 20.0, right: 20.0),
                            child: new MaterialButton(
                                color: _address == "done"
                                    ? Colors.teal
                                    : Colors.white,
                                child: new Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: 32.0, left: 10.0, bottom: 32.0),
                                  child: Text(
                                    "Data Alamat",
                                    style: _address == "done"
                                        ? CustomText.regular15White
                                        : CustomText.regular15Teal,
                                  ),
                                ),
                                onPressed: () {
                                  if(_address != null){
                                      
                                  }else{
                                    Navigator.pop(context); 
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddressDataPage(type: "",)));
                                  }
                                },
                                elevation: 5.0,
                                shape: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.5))),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 12.0, left: 20.0, right: 20.0),
                            child: new MaterialButton(
                                color: _jobs == "done"
                                    ? Colors.teal
                                    : Colors.white,
                                child: new Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: 32.0, left: 10.0, bottom: 32.0),
                                  child: Text(
                                    "Data Pekerjaan",
                                    style: _jobs == "done"
                                        ? CustomText.regular15White
                                        : CustomText.regular15Teal,
                                  ),
                                ),
                                onPressed: () {
                                  if(_jobs != null){
                                      
                                  }else{
                                    Navigator.pop(context); 
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JobDataPage(type: "",)));
                                  }
                                },
                                elevation: 5.0,
                                shape: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.5))),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 12.0, left: 20.0, right: 20.0),
                            child: new MaterialButton(
                                color: _spesimen == "done"
                                    ? Colors.teal
                                    : Colors.white,
                                child: new Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: 32.0, left: 10.0, bottom: 32.0),
                                  child: Text(
                                    "Spesimen Tanda Tangan",
                                    style: _spesimen == "done"
                                        ? CustomText.regular15White
                                        : CustomText.regular15Teal,
                                  ),
                                ),
                                onPressed: () {
                                  if(_spesimen != null){
                                      
                                  }else{
                                    Navigator.pop(context); 
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SpesimenPage(type: "",)));
                                  }
                                },
                                elevation: 5.0,
                                shape: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.5))),
                          ),
                        ),
                      ],
                    ),
                    //   },
                    // )
                  )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: MaterialButton(
                          onPressed: () {
                            if(_statusButton == false){

                            }else{
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowDataPage()));

                            }
                          },
                          color: _statusButton == true
                              ? Colors.teal
                              : Color(0xff727272),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "LANJUT",
                              textAlign: TextAlign.center,
                              style: CustomText.medium15White,
                            ),
                          ),
                        ),
                      ))
                ],
              ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Apakah anda yakin?'),
            content: new Text('Anda akan Keluar'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: FlatButton(
                  child: Text(
                    "No",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ),
              new GestureDetector(
                onTap:() => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),                  
                child: FlatButton(
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _back() {
    print("tes");
    // BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    Navigator.pop(context);
  }
}
