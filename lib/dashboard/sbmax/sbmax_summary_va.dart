import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/komersial/komersial_success.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_rekening_coin.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_success.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SBMaxSummaryVa extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SBMaxSummaryVaState();
  }
}

class _SBMaxSummaryVaState extends State<SBMaxSummaryVa> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  var passKey = GlobalKey<FormFieldState>();
  final formKey = new GlobalKey<FormState>();
  var _pass;
  bool _obscureTextOld = true;
  bool passwordVisible = true;

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
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 9, top: 10),
                      child: Text(
                        "Periksa kembali penempatan produk SBmax",
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
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    child: Text("Besar penempatan dana Simpanan Berjangka",
                                        style: CustomText.regular12Grey),
                                  ),
                                )
                              ],
                            )),
                            Container(
                                margin: EdgeInsets.only(top: 9),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        child: Text("Hingga 15 Okt 2020",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ),
                                    ),
                                    Container(
                                      child: Container(
                                        child: Text("Rp 1.000.000",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                              child: Row(
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Text("Pendapatan jasa (sebelum Pajak)",
                                        style: CustomText.regular12Grey),
                                  ),
                                )
                              ],
                            )),
                            Container(
                                margin: EdgeInsets.only(top: 9),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        child: Text("00% p.a",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ),
                                    ),
                                    Container(
                                      child: Container(
                                        child: Text("Rp 90.000",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Row(
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    child: Text("Dana bertumbuh menjadi (ini hanya hitungan indikatif)",
                                        style: CustomText.regular12Grey),
                                  ),
                                )
                              ],
                            )),
                            Container(
                                margin: EdgeInsets.only(top: 13),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        child: Text("",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ),
                                    ),
                                    Container(
                                      child: Container(
                                        child: Text("Rp 1.090.000",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff71ab3c),
                                                fontSize: 14)),
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    

                    Container(
                      margin: EdgeInsets.only(top:12),
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
                                    child: Text("Biaya Keanggotaan",
                                        style: CustomText.regular10Grey),
                                  ),
                                )
                              ],
                            )),
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        child: Text("Simpanan Pokok, Simpanan Wajib, \nsaldo awal rekening  KOIN-SB",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ),
                                    ),
                                    Container(
                                      child: Container(
                                        child: Text("Rp 120.000",
                                            style: TextStyle(
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
                      margin: EdgeInsets.only(top:12),
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
                                    child: Text("Total dana untuk penempatan ini sebesar(setelah ditambah biaya)",
                                        style: CustomText.regular10Grey),
                                  ),
                                )
                              ],
                            )),
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        child: Text("Rp 1.120.000",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                              child: Row(
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 14),
                                    child: Text("Rekening KOIN-SB yang dipilih untuk transaksi ini",
                                        style: CustomText.regular10Grey),
                                  ),
                                )
                              ],
                            )),
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        child: Text("0000000000000000 VA BNI",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ),
                                    )
                                   
                                  ],
                                )),
                            
                          ],
                        ),
                      ),
                    ),
                    
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {
                          _showDialog();
                        },
                        child: Container(
                            width: double.infinity,
                            child: CustomRegistrationButton("BUKA SIMPANAN BERJANGKA", true)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),                      
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => SBMaxRekeningCoin()));
                        },
                        child: Container(
                           decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xff068675)),
                            borderRadius: BorderRadius.circular(8.0)),
                            padding: EdgeInsets.all(16),
                            width: double.infinity,
                            child: Text("UBAH RENCANA INI", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),),
                      ),
                    )
                  ],
                ),
              ),
            ),
           
          ],
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
                              key: passKey,
                              keyboardType: TextInputType.text,
                              obscureText: passwordVisible,
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
                                            color: Colors.black,
                                          ),
                                        ),),
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
                        )
                      )
                    ),
                
                Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => SBMaxSuccess()));
                      },
                      child: Container(
                          // padding: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          child: CustomRegistrationButton("KONFIRMASI", true)),
                    )),
              ],
            ));
      },
    );
  }
}
