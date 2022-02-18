import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget//custom_radio.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_detail_fund_loans.dart';

import 'package:flutter_base/model/content/RadioGroup.dart';

class PickmiFundLoans extends StatefulWidget {
  @override
  _PickmiFundLoansState createState() => _PickmiFundLoansState();
}

class _PickmiFundLoansState extends State<PickmiFundLoans> {
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.arrow_back),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("Pinjaman Dana", style: Theme.of(context).textTheme.title),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Container(
                      child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
                                ),
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  "Sesuaikan jumlah pinjaman dan lama masa pinjaman dengan kebutuhanmu",
                                  style: CustomText.regular12
                                ),
                              ),
                              Container(
                                
                                margin: EdgeInsets.only(top:16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffdddddd),
                                        borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(8.0), topLeft: const Radius.circular(8.0)),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Center(
                                        child: Ink(
                                          padding: EdgeInsets.only(top:33, bottom: 34),
                                          
                                          child: IconButton(
                                            icon: Icon(Icons.remove_circle_outline),
                                            color: Colors.grey,
                                            onPressed: () {},
                                          ),
                                        ),
                                      )
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.62,
                                      color: Color(0xffededed),
                                      child: Center(
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: Color(0xffededed),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(bottom: 23, top: 23),
                                                child: Text("Jumlah Pinjaman", style:CustomText.bold14),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(bottom: 27),
                                                child: Text("RP. 1.800.000", style:CustomText.bold22),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                        
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomRight: const Radius.circular(8.0), topRight: const Radius.circular(8.0)),                                          
                                        color: Color(0xffdddddd),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Center(
                                        child: Ink(
                                          padding: EdgeInsets.only(top:33, bottom: 34),
                                         
                                          child: IconButton(
                                            icon: Icon(Icons.add_circle_outline),
                                            color: Colors.grey,
                                            onPressed: () {},
                                          ),
                                        ),
                                      )
                                    )
                                  ]
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top:11),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffdddddd),
                                        borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(8.0), topLeft: const Radius.circular(8.0)),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Center(
                                        child: Ink(
                                          padding: EdgeInsets.only(top:33, bottom: 34),
                                          
                                          child: IconButton(
                                            icon: Icon(Icons.chevron_left),
                                            color: Colors.grey,
                                            onPressed: () {},
                                          ),
                                        ),
                                      )
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.62,
                                      color: Color(0xffededed),
                                      child: Center(
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: Color(0xffededed),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(bottom: 23, top: 23),
                                                child: Text("Lama Cicilan", style:CustomText.bold14),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(bottom: 27),
                                                child: Text("12 Bulan", style:CustomText.bold22),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                        
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomRight: const Radius.circular(8.0), topRight: const Radius.circular(8.0)),                                          
                                        color: Color(0xffdddddd),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Center(
                                        child: Ink(
                                          padding: EdgeInsets.only(top:33, bottom: 34),
                                          
                                          child: IconButton(
                                            icon: Icon(Icons.chevron_right),
                                            color: Colors.grey,
                                            onPressed: () {},
                                          ),
                                        ),
                                      )
                                    )
                                  ]
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top:24),
                                child: Text("Estimasi Cicilan Bulanan", style:TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              ),
                              Container(
                                padding: EdgeInsets.only(top:7),
                                child: Text("Angka ini hanya simulasi, hasil akhir bisa berbeda", style:CustomText.regular10),
                              ),
                              Container(
                                padding: EdgeInsets.only(top:13),
                                child: Text("RP 312.091",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Color(0xfff18314))),
                              )
                            ],
                        )
                      )
                    ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                    child: MaterialButton(
                      onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PickmiDetailFundLoans()));
                      },
                      
                      color: Color(0xff096d5c),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "AJUKAN PINJAMAN",
                          textAlign: TextAlign.center,
                          style: CustomText.regular14White,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
