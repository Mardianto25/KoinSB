import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/list_simpanan/list_simpanan_page.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_detail_saving.dart';
import 'package:flutter_base/dashboard/loan_list.dart';

class SBMaxSuccess extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SBMaxSuccessState();
}

class _SBMaxSuccessState extends State<SBMaxSuccess> {

  double bottomSheetTopPosition = 50;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: SvgPicture.asset("assets/svg/ic-success-01.svg")
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Selamat Pembukaan SB Maximal \nsegera kami proses!",
                        textAlign: TextAlign.center,
                        style: CustomText.bold18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Text(
                        "Mohon menunggu, proses pembukaan produk Simpanan \nBerjangkja Maximal ini dilakukan dalam waktu \nminimal 1x24 jam (waktu operasional)",
                        textAlign: TextAlign.center,
                        style: CustomText.regular12,
                      ),
                    )

                  ],
                ),
              ],
            )
          ),
          Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => ListSimpananPage()
                        ));
                    },
                    color: Color(0xff096d5c),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "LIST PRODUK SIMPANAN",
                        textAlign: TextAlign.center,
                        style: CustomText.medium14White,
                      ),
                    ),
                  ),
                ))
        ],
      )
      
    );
  }

}
