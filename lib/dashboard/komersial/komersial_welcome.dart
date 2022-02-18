import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_product.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_choose_type.dart';
import 'package:flutter_base/dashboard/komersial/komersial_submission.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KomersialWelcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _KomersialWelcomeState();
  }
}

class _KomersialWelcomeState extends State<KomersialWelcome> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xff197e8c),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Color(0xff197e8c),
                    child: Center(
                      child: Image.asset(
                        "assets/images/ic_komersial.png",
                        scale: 2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            "Pinjaman Komersial",
                            style: CustomText.bold18Teal,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text(
                            "Pinjaman untuk memenuhi kebutuhan modal kerja dan atau"
                            " modal usaha dengan jaminan bergerak atau tidak bergerak."
                            " Diperuntukan untuk karyawan/pegawai dengan penghasilan"
                            " tetap, pengusaha/pedagang yang usahanva sudah berjalan"
                            " minimal 2 tahun.",
                            style: CustomText.regular12,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Text(
                            "Jasa Pinjaman",
                            style: CustomText.bold18Teal,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text(
                            "Nikmati jasa ringan mulai dari 2.00% per bulan",
                            style: CustomText.regular12,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Text(
                            "Plafon Pinjaman",
                            style: CustomText.bold18Teal,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Text(
                            "Plafond pinjaman minimal sebesar Rp25.000.000 sampai"
                            " dengan setinggi-tingginya sebesar Rp100.000.000",
                            style: CustomText.regular12,
                          ),
                        ),
                        
                      ],
                    ),
                  )
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
                          builder: (context) => KomersialSubmission()));
                },
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    width: double.infinity,
                    child: CustomRegistrationButton("AYO KITA MULAI", true)),
              ),
            )
          ],
        ));
  }
}