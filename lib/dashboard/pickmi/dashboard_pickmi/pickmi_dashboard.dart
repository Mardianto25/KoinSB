import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/menu_webview.dart';
import 'package:flutter_base/dashboard/pickmi/dashboard_pickmi/pickmi_settings.dart';
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

class PickmiDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PickmiDashboardState();
  }
}

class _PickmiDashboardState extends State<PickmiDashboard> {
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
                child: Text("Pengaturan Pickmi", style: Theme.of(context).textTheme.title),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PickmiSetting()
                  ));
                },
                child: SvgPicture.asset("assets/svg/dashboard/ai-svg/ic-notification.svg"),
              )
              
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                    _sliderSection(),
                    _cardSection(),
                    _title(),
                    _select()
              ],
            ),
          ),
        )
      );
  }

  
  
  Widget _sliderSection() {
    List imageList = [
      "assets/svg/dashboard/ai-svg/banner-sbmax.svg",
      "assets/svg/dashboard/ai-svg/banner-sbmax.svg",
      "assets/svg/dashboard/ai-svg/banner-sbmax.svg",
      "assets/svg/dashboard/ai-svg/banner-sbmax.svg",
    ];
    return Container(
      margin: EdgeInsets.only(top:12),
      child: Column(
        children: <Widget>[
          CarouselSlider(
            height: 100,
            autoPlay: true,
            viewportFraction: 0.7,
            items: imageList.map((image){
              return Builder(
                builder: (BuildContext context){
                  return Container(
                    padding: EdgeInsets.only(left: 6),
                    child: SvgPicture.asset(image,fit:BoxFit.fill),
                  );
                },
              );
            }).toList(),
            onPageChanged: (index) {
              setState(() {
                this._current = index;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(imageList, (index, url) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: this._current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4)
                ),
              );
            }),
          )

        ],

      ),
    );
  }
  
  
  
  Widget _cardSection() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // SvgPicture.asset("assets/svg/dashboard/ai-svg/banner-cs-1.svg"),
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Color(0xff02554a),
              border: Border.all(color: Color(0xff02554a)),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Limit Pinjaman',
                          textAlign: TextAlign.left,
                          style: CustomText.bold16White,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:12),
                        child: Text(
                          'Rp. 8.500.000',
                          textAlign: TextAlign.left,
                          style: CustomText.bold24White,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: FlatButton(
                    color: Colors.white,
                    textColor: Colors.black,
                    splashColor: Color(0xff02554a),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)
                    ),
                    onPressed: () {
                      /*...*/
                    },
                    child: Text(
                      "INFO",
                      style: TextStyle(fontSize: 10.0),
                    ),
                  )
                )
              ],
            )
          )

        ],
      ),
    );
  }

  Widget _title(){
    return Container(
      margin: EdgeInsets.only(top: 35, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Text(
              "Ajukan Pinjaman",
              textAlign: TextAlign.left,
              style: CustomText.bold14,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              "Pilih Pinjaman Dana atau Pinjaman Barang",
              textAlign: TextAlign.start,
              style: CustomText.regular12,
            ),
          )
        ],
      ),
    );
  }

  Widget _select(){
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PickmiFundLoans()));
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff02554a)),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.only(top: 21, bottom: 20, left: 24, right: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      // child: SvgPicture.asset("assets/svg/ic-loan-regular.svg"),
                        child: Image.asset("assets/images/ic_loan_regular.png"),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 6),
                            child: Text(
                              "Pinjaman Dana",
                              style: CustomText.bold16Primary,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          
                          Container(
                            child: Text(
                              "Sesuai dengan keperluanmu",
                              style: CustomText.regular13Primary,
                            ),
                          )
                          
                        ],
                      ) 
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => PickmiLoanOfGoods()
              ));
            },
            child: Container(
              margin: EdgeInsets.only(top: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff02554a)),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(23),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      // child: SvgPicture.asset("assets/svg/ic-loan-student.svg"),
                      child: Image.asset("assets/images/ic_loan_student.png"),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 6),
                            child: new Text(
                              "Pinjaman Barang",
                              style: CustomText.bold16Primary,
                            ),
                          ),
                          Container(
                            child: new Text(
                              "Dari seluruh e-Commerce Indonesia",
                              style: CustomText.regular13Primary,
                            ),
                          )
                          
                        ],
                      ) 
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
}
