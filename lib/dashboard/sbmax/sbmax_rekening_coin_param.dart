import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_product.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_bill.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_summary.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_pin.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SBMaxRekeningCoinParam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SBMaxRekeningCoinParamState();
  }
}

class _SBMaxRekeningCoinParamState extends State<SBMaxRekeningCoinParam> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();


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
          title: Text("Rekening Sumber Dana",
              style: Theme.of(context).textTheme.title),
        ),
        body:
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                         Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 32),
                                child: SvgPicture.asset("assets/svg/ic-no-product-01.svg"),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 32),
                                child: Text("Rekening KOIN asal", style: CustomText.bold18, textAlign: TextAlign.center,),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SBMaxChooseBill()
                                ));
                          },
                          child: Container(
                              margin: EdgeInsets.only(top:32, left: 16, right: 16),
                              padding: EdgeInsets.only(left: 16, top: 13, bottom: 13, right: 16),
                              decoration: BoxDecoration(
                              color: Color(0xff71ab3c),
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      color: Color(0xff71ab3c)
                                  )
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("KOIN-SB NO. 00000000"
                                            , style: CustomText.bold16White, textAlign: TextAlign.start), 
                                          // ,
                                        ),
                                        Container(
                                          // padding: EdgeInsets.only(top: 10),
                                          child: Icon(Icons.navigate_next, color: Colors.white,)
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("RP 000.000.000"
                                            , style: CustomText.bold16White, textAlign: TextAlign.start),
                                        )
                                      ],
                                    ),
                                  ),      
                                  
                                ],
                              )
                          )
                        ),
                        
                      ],
                    ),
                  ),
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
                            builder: (context) => SBMaxSummary()
                          ));
                      },
                      color: Color(0xff096d5c),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "KONFIRMASI ASAL REKENING",
                          textAlign: TextAlign.center,
                          style: CustomText.medium15White,
                        ),
                      ),
                    ),
                  ))
              ],
            ),
          ),

        );
  }
}
