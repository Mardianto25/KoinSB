import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_product.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_bill.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_summary.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_pin/sbmax_pin_page.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_simulasi_detail/sbmax_simulasi_detail_page.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SBMaxRekeningCoin extends StatefulWidget {
  final String noac;
  final int nominal;
  List<DataSimulasi> list;
  
  SBMaxRekeningCoin({Key key, @required this.noac, @required this.nominal, @required this.list}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SBMaxRekeningCoinState();
  
}

class _SBMaxRekeningCoinState extends State<SBMaxRekeningCoin> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  // SbmaxSimulasiDetail listData;
  @override
  void initState(){
    super.initState();
  }

  // getList() async{
  //   String data;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   data = prefs.getString("list");
  //   listData = json.encode(data);
  // }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          elevation: 0.0,
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                  builder: (contex) => SBMaxChooseProduct() 
                ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          backgroundColor: Colors.white,
          title: Text("Rekening Sumber Dana ",
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
                                builder: (context) => SbmaxPinPage(list: widget.list,)
                              ));
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 32, left: 16, right: 16),
                              padding: EdgeInsets.only(left: 16, top: 13, bottom: 13, right: 16),
                              decoration: BoxDecoration(
                                  color: widget.noac.isNotEmpty ? Colors.teal : Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      color:  Color(0xff068675)
                                  )
                              ),
                              child: Column(
                                children: <Widget>[
                                  widget.noac.isEmpty ? Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Pilih Rekening"
                                            , style: CustomText.bold16Primary, textAlign: TextAlign.start), 
                                          // ,
                                        ),
                                        Container(
                                          // padding: EdgeInsets.only(top: 10),
                                          child: Icon(Icons.navigate_next, color: Colors.teal,)
                                        ),
                                        
                                      ],
                                    ),
                                  ):
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("KOIN-SB NO. ${widget.noac}"
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
                                  widget.noac.isEmpty ? Container(): Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Rp ${widget.nominal}"
                                            , style: CustomText.bold16White, textAlign: TextAlign.start),
                                        )
                                      ],
                                    ),
                                  ),      
                                  
                                ],
                              )
                          ),
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
                        widget.noac.isEmpty ? null :
                        // Navigator.push(
                        //       context, 
                        //       MaterialPageRoute(
                        //         builder: (context) => SbmaxPinPage(list: widget.list,)
                        //       ));
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => SbmaxSimulasiDetailPage(noac: widget.noac, list: widget.list,)
                          ));
                      },
                      color: widget.noac.isEmpty ? Color(0xff727272) : Colors.teal,
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
