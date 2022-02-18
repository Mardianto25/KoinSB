import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/komersial/komersial_success.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MikroSummary extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MikroSummaryState();
  }
}

class _MikroSummaryState extends State<MikroSummary> {
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
                        "Periksa kembali pengajuann Pinjaman Komersial",
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
                                    child: Text("Tanggal Pengajuan Pinjaman",
                                        style: CustomText.regular12Grey),
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
                                        child: Text("DD/MM/YYYY",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        child: Text("Total Pinjaman",
                                            style: CustomText.regular12Grey),
                                      ),
                                    ),
                                    Container(
                                      child: Container(
                                        child: Text("Tenor Pinjaman",
                                            style: CustomText.regular12Grey),
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 9),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 3),
                                        child: Text("Rp 0.000.000",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                      ),
                                    ),
                                    Container(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 3),
                                        child: Text("12 Bulan",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      decoration: new BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0))),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: SvgPicture.asset(
                                  "assets/svg/jelajah-produk/pinjaman/ic-mikro-white.svg"),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16.0),
                              child: Text(
                                "Pinjaman Komersial",
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
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "Cicilan Perbulan",
                                    style: CustomText.medium12Teal,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "Rp.0.000.000",
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
                                  margin: EdgeInsets.only(top: 11),
                                  child: Text(
                                    "Tanggal Jatuh Tempo \nSetiap Bulan",
                                    style: CustomText.medium12Teal,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 11),
                                  child: Text(
                                    "Tanggal 00",
                                    style: CustomText.medium14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      decoration: new BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0))),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: SvgPicture.asset(
                                  "assets/svg/jelajah-produk/pinjaman/ic-mikro-white.svg"),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16.0),
                              child: Text(
                                "Biaya Pencairan",
                                style: CustomText.regular15White,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.teal),
                          borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0))),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Biaya Pencairan diambil dari pinjaman yang disetujui",
                                style: CustomText.regular12,
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(top: 16),
                                child: Text(
                                  "Lihat Detail Biaya Pencairan",
                                  style: CustomText.medium14Teal,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/ic_secure_shield.png",
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Denda keterlambatan 0.1% per hari dan nilai denda akan\n"
                              " ditagihkan pada cicilan pinjaman di bulan berikutnya dan Biaya\n"
                              " Pinalti Pinjaman dipercepat sebasar 2% dari sisa pokok pinjaman",
                              style: TextStyle(fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
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
                    )
                  ],
                ),
              ),
            ),
//            Align(
//                alignment: Alignment.bottomCenter,
//                child: Container(
//                  padding: EdgeInsets.only(left: 16, right: 16),
//                  color: Colors.white,
//                  child: GestureDetector(
//                    onTap: () {
//                      _showDialog();
//                    },
//                    child: Container(
//                        padding: EdgeInsets.only(bottom: 0),
//                        width: double.infinity,
//                        child: CustomRegistrationButton("PROSES", true)),
//                  ),
//                ))
          ],
        ));
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
                              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
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
                          ],
                        ))),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: Text(
                    "Lupa Password Transaksi?",
                    textAlign: TextAlign.end,
                    style: CustomText.regular14,
                  ),
                ),
                Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => MikroSummary()));
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
}
