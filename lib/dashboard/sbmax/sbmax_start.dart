import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/main.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_product.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SBMaxStart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SBMaxStartState();
  }
}

class _SBMaxStartState extends State<SBMaxStart> {
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
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Main()
        ));
      },
      child: new Scaffold(
          key: scaffoldKey,
          appBar: new AppBar(
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (contex) => Main() 
                  ));
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            elevation: 0.0,
            backgroundColor: Color(0xff71ab3c),
          ),
          body:Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex:4,
                    child: Container(
                      width:MediaQuery.of(context).size.width,
                      color: Color(0xff71ab3c),
                      child: Image.asset("assets/images/ic_success.png",scale: 2,),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: Text("Sejahtera Bersama MAX", style: CustomText.bold18Primary,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Text("Simpanan Berjangka pada Koperasi Simpan Pinjam Sejatera Bersama yang pembukaannya dilakukan pada aplikasi KOIN-SB", style: CustomText.regular12,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Text("Syarat & Ketentuan", style: CustomText.bold18Primary,),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            margin: EdgeInsets.only(top: 18),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          color: Color(0xff71ab3c),
                                          shape: BoxShape.circle),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 4),
                                      child: Text(
                                        _listText[index],
                                        style: CustomText.regular14,
                                      ),
                                    )
                                  ],
                                );
                              },
                              itemCount: _listText.length,
                            ),
                          ),

                        ]
                      ),
                    )
                  ),

                ],
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
                            builder: (context) => SBMaxChooseProduct()
                          ));
                      },
                      color: Color(0xff096d5c),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "AYO MULAI",
                          textAlign: TextAlign.center,
                          style: CustomText.medium14White,
                        ),
                      ),
                    ),
                  ))
            ],
          )          
        ),
    );
  }
}
