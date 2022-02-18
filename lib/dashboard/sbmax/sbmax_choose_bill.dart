import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_product.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_rekening_coin.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_rekening_coin_param.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SBMaxChooseBill extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _SBMaxChooseBillState();
  }
}

class _SBMaxChooseBillState extends State<SBMaxChooseBill> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _visible = true;
  var _listText = [
    "BBB1100020",
    "BBB1100021",
    "BBB1100022",
    "BBB1100023",
    "BBB1100023"
  ];

  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: Text("Pilih Rekening Koin",
              style: Theme.of(context).textTheme.title),
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: 
              Container(
                height: MediaQuery.of(context).size.height * 1,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                color: Colors.white,
                child: ListView.builder(
                  itemCount: _listText.length,
                  itemBuilder: (context, index) {
                    return MaterialButton(
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SBMaxRekeningCoinParam()));
                      },
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color:Color(0xff27a08b))
                          ),
                          padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
                          margin: EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: SvgPicture.asset("assets/svg/dashboard/ai-svg/ic-dashboard-active.svg"),
                              ),
                              Container(
                                child: Text(
                                  _listText[index],
                                  style: CustomText.regular12,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Rp.1000.000.000",
                                  style: CustomText.bold14,
                                ),
                              )
                              
                            ],
                          ),
                        )
                        ],
                      ),
                    );
                  },
                  
                ),
              ),
            )
          ],
        )
          
        );
  }
}
