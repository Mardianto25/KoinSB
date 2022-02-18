import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/menu_webview.dart';
import 'package:flutter_base/dashboard/pickmi/dashboard_pickmi/pickmi_change_address.dart';
import 'package:flutter_base/dashboard/pickmi/dashboard_pickmi/pickmi_change_rekening.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_fund_loans.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_loan_of_goods.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_start.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_desc.dart';
import 'package:flutter_base/dashboard/komersial/komersial_welcome.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/circle_button.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sticky_headers/sticky_headers.dart';

class PickmiSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PickmiSettingState();
  }
}

class _PickmiSettingState extends State<PickmiSetting> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Container(
                padding: EdgeInsets.only(left: 13),
                child: Text("Pinjaman Pickmi", style: Theme.of(context).textTheme.title),
              ),
              
            ],
          ),
        ),
        body: 
          Container(
            // height: MediaQuery.of(context).size.height * 1,
            color: Colors.white,
            child: Column(
              children: <Widget>[
              _select()
                
              ],
            ),
          ),
      );
  }


  Widget _select(){
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Text(
              "Ubah Alamat Pengiriman",
              style: CustomText.bold14,
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
            border: Border.all(color: Color(0xff02554a)),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.only(top: 21, bottom: 20, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Jl. Pajajaran No.1",
                    style: CustomText.regular13,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Provinsi, Kota/Kab, Kecamatan, Kel",
                    style: CustomText.regular13,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Kode Pos",
                    style: CustomText.regular13,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),    
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "",
                  style: CustomText.bold14,
                ),
                FlatButton(
                  color: Colors.transparent,
                  textColor: Color(0xff096d5c),
                  splashColor: Color(0xff02554a),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.transparent)
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PickmiChangeAddress()
                    ));
                  },
                  child: Text(
                    "UBAH ALAMAT PENGIRIMAN",
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Text(
              "Rekening Bank Tujuan Peminjam",
              style: CustomText.bold14,
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
            border: Border.all(color: Color(0xff02554a)),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.only(top: 21, bottom: 20, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "NAMA BANK",
                    style: CustomText.regular13,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "NOMOR REKENING",
                    style: CustomText.regular13,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "CABANG",
                    style: CustomText.regular13,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),    
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "",
                  style: CustomText.bold14,
                ),
                FlatButton(
                  color: Colors.transparent,
                  textColor: Color(0xff096d5c),
                  splashColor: Color(0xff02554a),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.transparent)
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PickmiChangeRekening()
                    ));
                  },
                  child: Text(
                    "UBAH NOMOR REKENING",
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)
                  ),
                )
              ],
            ),
          ),
        ],
            
      ),
    );
  }

}
