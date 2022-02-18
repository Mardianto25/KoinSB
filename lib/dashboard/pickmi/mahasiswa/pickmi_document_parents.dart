import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget//custom_radio.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_additional_data.dart';
import 'package:flutter_base/dashboard/pickmi/mahasiswa/pickmi_additional_document.dart';

class PickmiDocumentParents extends StatefulWidget {
  @override
  _PickmiDocumentParentsState createState() => _PickmiDocumentParentsState();
}

class _PickmiDocumentParentsState extends State<PickmiDocumentParents> {
  final formKey = new GlobalKey<FormState>();
  var _address, _postalCode;
  var _listText = [
    "- Slip Gaji 2 bulan terakhir",
    "- Mutasi rekening bank",
    "- Laporan pembayaran pajak paling baru",
    "- Surat Keterangan Penghasilan"
  ];
  var _isChecked = false;
  List<RadioModel> homeStatus = new List<RadioModel>();

  List<RadioGroup> buildingOwnins = []
    ..add(RadioGroup("1", "Pilih"))
    ..add(RadioGroup("2", "Hapus"));

  List<RadioModel> homeStatus2 = new List<RadioModel>();

  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    homeStatus.add(new RadioModel(true, 'Pilih'));
    homeStatus.add(new RadioModel(false, 'Hapus'));

    homeStatus2.add(new RadioModel(true, 'Pilih'));
    homeStatus2.add(new RadioModel(false, 'Hapus'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.arrow_back),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("Dokumen Orang Tua", style: Theme.of(context).textTheme.title),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                        child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                child: Text("DOKUMEN YANG MEMENUHI SYARAT", style: CustomText.regular12),
                              )
                              
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              margin: EdgeInsets.only(top: 5, bottom: 10),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 4),
                                        child: Text(
                                          _listText[index],
                                          style: CustomText.regular12,
                                        ),
                                      )
                                    ],
                                  );
                                },
                                itemCount: _listText.length,
                              ),
                            ),
                            
                            Container(
                              height: 50.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeStatus.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return new Container(
                                    margin: EdgeInsets.only(right: 16.0),
                                    child: InkWell(
                                      //highlightColor: Colors.red,
                                      splashColor: Colors.blueAccent,
                                      onTap: () {
                                        setState(() {
                                          homeStatus.forEach((element) =>
                                              element.isSelected = false);
                                          homeStatus[index].isSelected = true;
                                        });
                                      },

                                      child: RadioItem(
                                          homeStatus[index], 150.0, 18.0),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      )
                      
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xfff2f28f), 
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Image.asset("assets/images/ic_warning.png"),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 18),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Upload 2 foto dokumen berbeda',
                                  style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 11),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                        ' apabila mengunggah dokumen yang sama akan',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 10)
                                    ),
                                    TextSpan(
                                        text:
                                        ' menghasilkan penolakan',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 10 )
                                    )
                                  ],
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 15),
                      child: new Row(
                        children: <Widget>[
                          Container(
                            width: 87,
                            height: 87,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                AssetImage("assets/images/banner_promo.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            width: 87,
                            height: 87,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                AssetImage("assets/images/banner_promo.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ],  
                )
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 1,
                          color: Colors.grey,
                          margin: EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _isChecked,
                                onChanged: (bool value) {
                                  setState(() {
                                    _isChecked = value;
                                  });
                                },
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75 ,
                                child: Text(
                                  "Saya mengkonfirmasi nama saya dan dokumen yang"
                                      " saya upload terlihat jelas",
                                  style: CustomText.regular12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => PickmiAdditionalDocument()));
                          },
                          child: Container(
                              padding:
                              EdgeInsets.only(left: 16, right: 16, top: 16),
                              width: double.infinity,
                              child: CustomRegistrationButton("UPLOAD", false)),
                        )
                      ],
                    ),
                  )
                )
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
