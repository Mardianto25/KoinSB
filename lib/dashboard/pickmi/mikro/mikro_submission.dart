import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/pickmi/mikro/mikro_submission_data.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_product.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_choose_type.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MikroSubmission extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MikroSubmissionState();
  }
}

class _MikroSubmissionState extends State<MikroSubmission> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  double _nominal = 2000000;
  double _tenor = 1;

  var _listText = [
    "Nominal Simpanan mulai dari Rp.100.000 s.d Rp. \n15.000.000",
    "Masa Simpanan 1, 3, 6, 9 dan 12 Bulan",
    "Bagi hasil sampai dengan 12% p.a.",
    "Pembayaran Bagi Hasil bulanan",
    "Dapat memiliki lebih dari satu Simpanan Berjangka  \nMAXIMAL"
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title:
              Text("Pinjaman Mikro", style: Theme.of(context).textTheme.title),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Nominal Pengajuan Pinjaman",
                            style: CustomText.regular12,
                          ),
                        ),
                        Container(
                          child: Text(
                            "Rp. ${_nominal.toInt()}",
                            style: CustomText.medium12,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Slider(
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: Color(0xffe6c125),
                      value: _nominal,
                      onChanged: (newValue) {
                        setState(() {
                          _nominal = newValue;
                        });
                      },
                      min: 100000,
                      max: 100000000,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Tenor Pinjaman",
                            style: CustomText.regular12,
                          ),
                        ),
                        Container(
                          child: Text(
                            "${_tenor.toInt()} Bulan",
                            style: CustomText.medium12,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Slider(
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: Color(0xffe6c125),
                      value: _tenor,
                      onChanged: (newValue) {
                        setState(() {
                          _tenor = newValue;
                        });
                      },
                      min: 1,
                      max: 50,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 40),
                    child: Text(
                      "Estimasi Cicilan Bulanan",
                      style: CustomText.medium16,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      "Angka ini hanya simulasi, hasil akhir bisa berbeda",
                      style: CustomText.regular12,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 13),
                    child: Text(
                      "Rp 312.091",
                      style: TextStyle(
                          color: Color(0xfff18314),
                          fontSize: 22,
                          fontFamily: 'NeoSansW1gMedium'),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MikroSubmissionData()));
                },
                child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    width: double.infinity,
                    child: CustomRegistrationButton("AJUKAN PINJAMAN", true)),
              ),
            )
          ],
        ));
  }
}
