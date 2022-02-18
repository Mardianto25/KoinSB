import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_product.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_choose_type.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickmiDesc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PickmiDescState();
  }
}

class _PickmiDescState extends State<PickmiDesc> {
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
          backgroundColor: Color(0xff71ab3c),
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
                  color: Color(0xff71ab3c),
                  child: Center(
                    child: Image.asset(
                      "assets/images/ic_success.png",
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
                          "Pinjaman Pickmi",
                          style: CustomText.bold18Teal,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text(
                          "Simpanan Cerdas untuk Karyawan dan Mahasiswa Indonesia."
                          " Miliki plafon pinjaman hingga 25 juta rupiah untuk pembelian"
                          " barang atau pinjaman dana tunai",
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
                          "Nikmati jasa ringan mulai dari 2.25% per bulan",
                          style: CustomText.regular12,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Text(
                          "Proses Cepat dan Mudah ",
                          style: CustomText.bold18Teal,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text(
                          "Mudahnya miliki plafon pinjaman hanya dalam waktu kurang"
                          " dari 24 jam. Sertakan identitas diri dan dokumen lainnya"
                          " cukup melalui smartphone",
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
                        builder: (context) => PickmiChooseType()));
              },
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  width: double.infinity,
                  child: CustomRegistrationButton("AYO KITA MULAI", true)),
            ),
          )
        ],
      )
    );
  }
}