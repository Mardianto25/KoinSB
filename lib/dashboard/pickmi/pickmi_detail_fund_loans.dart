import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_product.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_choose_type.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_success_loan.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickmiDetailFundLoans extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PickmiDetailFundLoansState();
  }
}

class _PickmiDetailFundLoansState extends State<PickmiDetailFundLoans> {
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
        body:  Stack(
          children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width * 0.3,
            color: Color(0xff068675),
          ),
          SingleChildScrollView(
            child: Padding(
            padding: EdgeInsets.all(16),
            child: 
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom:9, top: 10),
                  child: Text(
                    "Periksa kembali pengajuan Pickmi Barang",
                    style: CustomText.regular14White,
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(width: 1.0, color: Color(0xff068675))),
                  child: Padding(
                    padding: EdgeInsets.only(top:16.0, bottom: 17, left: 16, right: 16),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Container(
                                  child: Text("Tanggal Pengajuan Pinjaman", style: CustomText.regular12Grey),
                                ),
                              )
                            ],
                          )  
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 9),
                            child: Row(
                            children: <Widget>[
                              Container(
                                child: Container(
                                  child: Text("DD/MM/YYYY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                ),
                              )
                            ],
                          )  
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Container(
                                  child: Text("Total Pinjaman", style: CustomText.regular12Grey),
                                ),
                              ),
                              Container(
                                child: Container(
                                  child: Text("Tenor Pinjaman", style: CustomText.regular12Grey),
                                ),
                              ),
                            ],
                          )  
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Container(
                                  child: Text("Rp 0.000.000", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                ),
                              ),
                              Container(
                                child: Container(
                                  child: Text("12 Bulan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
                      color: Colors.teal,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0))),
                  child: Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Row(
                      
                      children: <Widget>[
                        Container(
                          // margin: EdgeInsets.only(left: 10.0),
                          // child: Image.asset("assets/images/ic_sbmax_white.png"),
                        ),
                        Container(
                          // margin: EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Pinjaman Pickmi Dana",
                            style: CustomText.regular15White,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.teal),
                      borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(10.0),
                          bottomRight: const Radius.circular(10.0))),
                  child: Container(
                    padding: EdgeInsets.only(top:12.0, bottom: 13, left: 16, right: 16),
                    child: Column(
                      
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Cicilan Perbulan",
                                style: CustomText.medium12Teal,
                              ),
                            ),
                            Container(
                              child: Text(
                                "Rp.0.000.000.000",
                                style: CustomText.medium14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top:11),
                              child: Text(
                                "Tanggal Jatuh Tempo",
                                style: CustomText.medium12Teal,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 11),
                              child: Text(
                                "00/00/0000",
                                style: CustomText.medium14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Setiap Bulan",
                                style: CustomText.medium12Teal,
                              ),
                            ),
                            
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                Container(
                    margin: EdgeInsets.only(top: 25.0),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/ic_secure_shield.png",
                          fit: BoxFit.cover,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            "Denda keterlambatan 0.1% per hari dan nilai denda akan ditagihkan pada cicilan pinjaman di bulan berikutnya",
                            style: TextStyle(fontSize: 10.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 60),
                  //   child: Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Container(
                  //     color: Colors.white,
                  //     padding:
                  //         EdgeInsets.only(left: 16.0, right: 16.0),
                  //     child: MaterialButton(
                  //       onPressed: () {
                  //         _showDialog();
                  //       },
                  //       color: Color(0xff096d5c),
                  //       shape: new RoundedRectangleBorder(
                  //           borderRadius: new BorderRadius.circular(10.0)),
                  //       child: Container(
                  //         width: double.infinity,
                  //         padding: EdgeInsets.all(16.0),
                  //         child: Text(
                  //           "PROSES",
                  //           textAlign: TextAlign.center,
                  //           style: CustomText.regular14White,
                  //         ),
                  //       ),
                  //     ),
                  //   )
                  //   ),
                  // )

              ],
            )
          ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  _showDialog();
                },
                child: Container(
                    padding: EdgeInsets.only(bottom: 0),
                    width: double.infinity,
                    child: CustomRegistrationButton("PROSES", true)),
              ),
            ))
          
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
            // title: new Text(
            //   "Password Transaksi",
            //   style: CustomText.medium16,
            // ),
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
                        )
                      )
                    ),
                GestureDetector(
                  onTap: () {
                    
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PickmiSuccessLoan()));
                  },
                  child: Container(
                      width: double.infinity,
                      child: Container(
                        height: 38,
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Color(0xff096d5c),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: MaterialButton(
                          child: Text(
                            "KONFIRMASI",
                            style: CustomText.bold14White,
                          ),
                        ),
                      )),
                ),
                
              ],
            ));
      },
    );
  }
}
