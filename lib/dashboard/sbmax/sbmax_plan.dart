import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_product.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_rekening_coin.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/util/currency.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SBMaxPlan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SBMaxPlanState();
  }
}

class _SBMaxPlanState extends State<SBMaxPlan> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final money = NumberFormat("#,##0","en_US");
  bool _visible = true;
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xff068675),
        ),
        body:
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color:Color(0xff068675),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.all(Radius.circular(12)),

                  ),
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.only(left: 16, right:16),
                  child: TextFormField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly, 
                      CurrencyFormat()
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Masukkan nominal penempatan',
                        enabledBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white)
                        ),
                    ),
                    onChanged: (text){
                      setState(() {
                        if(text != "")
                          _visible = false;
                          // money.format(int.parse(text));
                        else
                          _visible = true;                          
                      });
                    },
                  )
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    AnimatedOpacity(
                      opacity: _visible?1.0:0.0,
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset("assets/images/ic_info.png", alignment: Alignment.topCenter,),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Masukkan nominal penempatan untuk melihat rencana Simpanan Berjangka MAX kamu (minimum penempatan dana Rp100.000).",
                                        style: CustomText.regular10,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ),
                    ),
                    Visibility(
                      visible: !_visible,
                      child: Container(
                        // margin: EdgeInsets.only(top: 16),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => SBMaxRekeningCoin()
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(color:Colors.black)
                                  ),
                                  padding: EdgeInsets.only(left: 16, top: 13, bottom: 13),
                                  margin: EdgeInsets.only(left: 16,right: 16, bottom: 12, top:10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text("Selama 1 Bulan", style: CustomText.bold12),
                                      Text("Rp 1.009.999", style: CustomText.bold14),
                                      Opacity(
                                        opacity: 0.5,
                                        child: Text("(termasuk jasa sebesar 0% p.a. sejumlah Rp 9.999)", style: CustomText.regular12),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color:Colors.black)
                                ),
                                padding: EdgeInsets.only(left: 16, top: 13, bottom: 13),
                                margin: EdgeInsets.only(left: 16,right: 16, bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text("Selama 1 Bulan", style: CustomText.bold12),
                                    Text("Rp 1.009.999", style: CustomText.bold14),
                                    Opacity(
                                      opacity: 0.5,
                                      child: Text("(termasuk jasa sebesar 0% p.a. sejumlah Rp 9.999)", style: CustomText.regular12),
                                    )

                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color:Colors.black)
                                ),
                                padding: EdgeInsets.only(left: 16, top: 13, bottom: 13),
                                margin: EdgeInsets.only(left: 16,right: 16, bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text("Selama 1 Bulan", style: CustomText.bold12),
                                    Text("Rp 1.009.999", style: CustomText.bold14),
                                    Opacity(
                                      opacity: 0.5,
                                      child: Text("(termasuk jasa sebesar 0% p.a. sejumlah Rp 9.999)", style: CustomText.regular12),
                                    )

                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color:Colors.black)
                                ),
                                padding: EdgeInsets.only(left: 16, top: 13, bottom: 13),
                                margin: EdgeInsets.only(left: 16,right: 16, bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text("Selama 1 Bulan", style: CustomText.bold12),
                                    Text("Rp 1.009.999", style: CustomText.bold14),
                                    Opacity(
                                      opacity: 0.5,
                                      child: Text("(termasuk jasa sebesar 0% p.a. sejumlah Rp 9.999)", style: CustomText.regular12),
                                    )

                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color:Colors.black)
                                ),
                                padding: EdgeInsets.only(left: 16, top: 13, bottom: 13),
                                margin: EdgeInsets.only(left: 16,right: 16, bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text("Selama 1 Bulan", style: CustomText.bold12),
                                    Text("Rp 1.009.999", style: CustomText.bold14),
                                    Opacity(
                                      opacity: 0.5,
                                      child: Text("(termasuk jasa sebesar 0% p.a. sejumlah Rp 9.999)", style: CustomText.regular12),
                                    )

                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color:Colors.black)
                                ),
                                padding: EdgeInsets.only(left: 16, top: 13, bottom: 13),
                                margin: EdgeInsets.only(left: 16,right: 16, bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text("Selama 1 Bulan", style: CustomText.bold12),
                                    Text("Rp 1.009.999", style: CustomText.bold14),
                                    Opacity(
                                      opacity: 0.5,
                                      child: Text("(termasuk jasa sebesar 0% p.a. sejumlah Rp 9.999)", style: CustomText.regular12),
                                    )

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

        );
  }
}
