import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/pickmi/mikro/mikro_submission.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_product.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_choose_type.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MikroWelcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MikroWelcomeState();
  }
}

class _MikroWelcomeState extends State<MikroWelcome> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

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
          elevation: 0.0,
          backgroundColor: Color(0xffa373b9),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Color(0xffa373b9),
                    child: Center(
                      child: Image.asset("assets/images/ic_komersial.png"),
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
                            "Pinjaman Mikro",
                            style: CustomText.medium18Teal,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text(
                            "Pinjaman untuk memenuhi kebutuhan modal kerja dan atau modal usaha dengan jaminan bergerak atau tidak bergerak."
                            "  Diperuntukan untuk karyawan/pegawai dengan penghasilan tetap,"
                            " pengusaha/pedagang yang usahanva sudah berjalan minimal 2 tahun.",
                            style: CustomText.regular12,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Text(
                            "Jasa Pinjaman",
                            style: CustomText.medium18Teal,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text(
                            "Nikmati jasa ringan mulai dari 2.25% per bulan",
                            style: CustomText.regular12,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Text(
                            "Plafon Pinjaman ",
                            style: CustomText.medium18Teal,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Text(
                            "Plafond pinjaman minimal sebesar Rp1.000.000"
                            " sampai dengan setinggi-tingginya sebesar Rp25.000.000",
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
                          builder: (context) => MikroSubmission()));
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
