import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/komersial/komersial_success.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_rekening_coin.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_success.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_thawing.dart';

class SBMaxDetailSaving extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SBMaxDetailSavingState();
  }
}

class _SBMaxDetailSavingState extends State<SBMaxDetailSaving> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  var _pass;
  bool _obscureTextOld = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xff068675),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width * 0.3,
              color: Color(0xff068675),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 9, top: 10),
                      child: Text(
                        "Detail Simpanan Berjangka Maximal",
                        style: CustomText.regular14White,
                      ),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xff068675)),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Container(
                                      child: Text("Penempatan pokok",
                                          style: CustomText.regular12Grey),
                                    ),
                                  ),
                                  Container(
                                    child: Container(
                                      child: Text("Rp0.000.000.000",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ),
                                  ),
                                ],
                              )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Container(
                                      child: Text("Jasa simpanan berjangka",
                                          style: CustomText.regular12Grey),
                                    ),
                                  ),
                                  Container(
                                    child: Container(
                                      child: Text("00% p.a.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ),
                                  )
                                ],
                              )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Container(
                                      child: Text("Jasa terbentuk",
                                          style: CustomText.regular12Grey),
                                    ),
                                  ),
                                  Container(
                                    child: Container(
                                      child: Text("Rp0.000.000.000",
                                        style: TextStyle(
                                            color: Color(0xff71ab3c),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                    ),
                                  )
                                ],
                              )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Container(
                                      child: Text("Tanggal jatuh tempo",
                                          style: CustomText.regular12Grey),
                                    ),
                                  ),
                                  Container(
                                    child: Container(
                                      child: Text("00 bulan 0000",
                                        style: TextStyle(
                                            color: Color(0xff71ab3c),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                    ),
                                  )
                                ],
                              )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Container(
                                      child: Text("Jumlah saat jatuh tempo",
                                          style: CustomText.regular12Grey),
                                    ),
                                  ),
                                  Container(
                                    child: Container(
                                      child: Text("Rp0.000.000.000",
                                        style: TextStyle(
                                            color: Color(0xff71ab3c),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                    ),
                                  )
                                ],
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:16),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xff068675)),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Padding(
                        padding: EdgeInsets.only(top:16.0, left: 16.0, right: 10.0, bottom: 13.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    child: Text("Rekening KOIN-SB yang dipilih untuk simpanan ini",
                                        style: CustomText.regular10Grey),
                                  ),
                                )
                              ],
                            )),
                            Container(
                                margin: EdgeInsets.only(top: 9),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        child: Text("000000000",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    )
                                  ],
                                )
                              ),
                            
                          ],
                        ),
                      ),
                    ),
                    
    
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SBMaxThawing()));
                  },
                  color: Colors.white,
                  shape: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.teal, width: 1.5)),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "ATUR SIMPANAN INI",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xff096d5c)),
                    ),
                  ),
                ),
              ))
          ],
        )
      );
  }

 
}
