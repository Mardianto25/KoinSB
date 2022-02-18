import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget//custom_radio.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_detail_fund_loans.dart';
import 'package:flutter_base/dashboard/komersial/komersial_data_submission.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';

class KomersialSubmission extends StatefulWidget {
  @override
  _KomersialSubmissionState createState() => _KomersialSubmissionState();
}

class _KomersialSubmissionState extends State<KomersialSubmission> {
  final formKey = new GlobalKey<FormState>();
  var _nominal;
  double _sliderValue = 10;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.arrow_back),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("Pinjaman Komersial", style: Theme.of(context).textTheme.title),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                      child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Nominal Pengajuan Pinjaman", style: CustomText.medium12),
                              ),
                              TextFormField(
                                onSaved: (val) => _nominal = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    hintText: 'Minimal nominal pinjaman Rp25 juta',
                                    hintStyle: CustomText.regular16Grey
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top:10),
                                      child: Text(
                                        "Tenor Pinjaman",
                                        style: CustomText.medium12,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "${_sliderValue.toInt()} Bulan",
                                        style: CustomText.bold12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Slider(
                                  activeColor: Theme.of(context).primaryColor,
                                  inactiveColor: Color(0xffe6c125),
                                  value: _sliderValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _sliderValue = newValue;
                                    });
                                  },
                                  min: 1,
                                  max: 50,
                                ),
                              
                              ),
                              Container(
                                padding: EdgeInsets.only(top:10),
                                child: Text("Estimasi Cicilan Bulanan", style:CustomText.bold15),
                              ),
                              Container(
                                padding: EdgeInsets.only(top:10),
                                child: Text("Angka ini hanya simulasi, hasil akhir bisa berbeda", style:CustomText.regular10),
                              ),
                              Container(
                                padding: EdgeInsets.only(top:10),
                                child: Text("RP 312.091",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Color(0xfff18314))),
                              )
                            ],
                        )
                      )
                    ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
                    child: MaterialButton(
                      onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KomersialDataSubmission()));
                      },
                      
                      color: Color(0xff096d5c),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "AJUKAN PINJAMAN",
                          textAlign: TextAlign.center,
                          style: CustomText.regular14White,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
