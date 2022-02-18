import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/komersial/komersial_success.dart';
import 'package:flutter_base/dashboard/loan_detail/choose_payment_installment.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickmiActive extends StatefulWidget {
  final String title;

  PickmiActive({Key key, @required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PickmiActiveState(title);
  }
}

class _PickmiActiveState extends State<PickmiActive> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  var _pass;
  String title;
  bool _obscureTextOld = true;
  List<Text> _textData = [
    Text("0123456789", style: CustomText.medium14),
    Text("DD/MM/YYYY", style: CustomText.medium14),
    Text("DD/MM/YYYY", style: CustomText.medium14),
    Text("Rp00.000.000",
        style: TextStyle(
            color: Color(0xffd32e41), fontFamily: 'NeoSansW1GMedium')),
    Text("00 Bulan", style: CustomText.medium14),
    Text("DD/MM/YYYY", style: CustomText.medium14),
    Text("AKTIF",
        style:
            TextStyle(color: Color(0xff71ab3c), fontFamily: 'NeoSansW1GMedium'))
  ];
  List<String> _title = [
    "Nomor Pinjaman",
    "Tanggal Pengajuan",
    "Tanggal Persetujuan",
    "Total Pinjaman",
    "Tenor Pinjaman",
    "Pinjaman Selesai",
    "Status Pinjaman"
  ];

  _PickmiActiveState(String title) {
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: Text("Detil Pinjaman"),
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
                        "Pickmi $title",
                        style: CustomText.medium14White,
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
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _title.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Text(_title[index],
                                                  style:
                                                      CustomText.regular12Grey),
                                            ),
                                            Container(
                                              child: _textData[index],
                                            ),
                                          ],
                                        ),
                                      );
                                    })),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 12),
                      decoration: new BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0))),
                      child: Container(
                        padding:
                            EdgeInsets.only(top: 13.0, bottom: 13.0, left: 20),
                        child: Text(
                          "Riwayat Pembayaran Cicilan",
                          style: CustomText.regular15White,
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
                          padding: EdgeInsets.all(0.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    top: 16, left: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Tenor",
                                      style: CustomText.medium12Teal,
                                    ),
                                    Text("Nominal Cicilan",
                                        style: CustomText.medium12Teal),
                                    Text("Tanggal Jatuh Tempo",
                                        style: CustomText.medium12Teal),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 12, bottom: 12),
                                height: 6,
                                color: Color(0xffefefef),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 12,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Column(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                _showDialog();
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    "1/12",
                                                    style: CustomText.medium12,
                                                  ),
                                                  Text("Rp0.000.000",
                                                      style:
                                                          CustomText.medium12),
                                                  Text("DD/MM/YYYY",
                                                      style:
                                                          CustomText.medium12),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 8,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 12, bottom: 12),
                                              height: 1,
                                              color: Color(0xffefefef),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset(
                              "assets/images/ic_secure_shield.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Denda keterlambatan 0.1% per hari dan nilai denda akan\n"
                              " ditagihkan pada cicilan pinjaman di bulan berikutnya.",
                              style: TextStyle(fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      width: double.infinity,
                      color: Colors.white,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChoosePayMentInstallment()));
                        },
                        color: Color(0xff71ab3c),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Text("bayar cicilan".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: 'NeoSansW1GMedium')),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Tenor 1/12",
                        style: CustomText.medium16,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Nominal Cicilan",
                        style: CustomText.regular12,
                      ),
                      Text(
                        "Rp0.000.000",
                        style: CustomText.medium12,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Tanggal Jatuh Tempo",
                        style: CustomText.regular12,
                      ),
                      Text(
                        "DD/MM/YYYY",
                        style: CustomText.medium12,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, bottom: 12),
                  height: 2,
                  color: Color(0xffefefef),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Status Pembayaran",
                        style: CustomText.regular12,
                      ),
                      Text(
                        "BELUM SELESAI",
                        style: TextStyle(
                            color: Color(0xffd32e41),
                            fontSize: 12,
                            fontFamily: 'NeoSansW1GMedium'),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, bottom: 12),
                  height: 2,
                  color: Color(0xffefefef),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/ic_secure_shield.png",
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: 200,
                        child: Text(
                          "Denda keterlambatan 0.1% per hari dan nilai denda"
                          " akan ditagihkan pada cicilan pinjaman di bulan"
                          " berikutnya",
                          style: CustomText.regular10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
