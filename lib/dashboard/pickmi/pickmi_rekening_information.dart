import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:intl/intl.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_additional_data.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';

class RekeningInformation extends StatefulWidget {
  @override
  _RekeningInformationState createState() => _RekeningInformationState();
}

class _RekeningInformationState extends State<RekeningInformation> {
  var _noRek, _nameRek, _nameCab;
  String _selectedJob, _selectedJobTime;
  final format = DateFormat("yyyy-MM-dd");
  final formKey = new GlobalKey<FormState>();
  List<String> sampleData = [
    'Lorem Ipsum 1',
    'Lorem Ipsum 2',
    'Lorem Ipsum 3',
    'Lorem Ipsum 4',
    'Lorem Ipsum 5',
  ];

  List<RadioGroup> BankList = []
    ..add(RadioGroup("1", "Bank Mandiri"))
    ..add(RadioGroup("2", "Bank Mandiri Syariah"))
    ..add(RadioGroup("3", "Bank BNI"))
    ..add(RadioGroup("4", "Bank BCA"))
    ..add(RadioGroup("5", "Bank BRI"))
    ..add(RadioGroup("6", "Bank Bukopin"));
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Informasi Rekening", style: Theme.of(context).textTheme.title),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Padding(
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
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text("Pilih Bank", style: CustomText.medium12,),
                          ),
                          CustomPopupSelect(
                            onChangeText: (counter) {
                              counter;
                            },
                            radioGroup: BankList,
                            title: "Pilih Bank",
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8, top: 16),
                            child: Text("Nomer Rekening", style: CustomText.medium12),
                          ),
                          TextFormField(
                            onSaved: (val) => _noRek = val,
                            decoration: InputDecoration(
                                fillColor: Theme.of(context).accentColor,
                                hintText: 'Masukan no Rekening', hintStyle: CustomText.regular16,),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8, top: 16),                          
                            child: Text("Nama Pemilik Rekening", style: CustomText.medium12),
                          ),
                          TextFormField(
                            onSaved: (val) => _nameRek = val,
                            decoration: InputDecoration(
                                fillColor: Theme.of(context).accentColor,
                                hintText: 'Masukan nama pemilik rekening', hintStyle: CustomText.regular16,),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8, top: 16),                          
                            child: Text("Cabang", style: CustomText.medium12,),
                          ),
                          TextFormField(
                            onSaved: (val) => _nameCab = val,
                            decoration: InputDecoration(
                                fillColor: Theme.of(context).accentColor,
                                hintText: 'Nama Cabang', hintStyle: CustomText.regular16,),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(top: 24.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/ic_secure_shield.png",
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      "Nomer rekening yang dicantumkan akan menjadi rekening tujuan pengiriman pinjaman dana Pickmi",
                                      style: CustomText.regular13,
                                    ),
                                  )
                                ],
                              ),
                            )
                          )
                        ],
                      ))),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => PickmiAdditionalData()
                        ));
                    },
                    color: Color(0xff096d5c),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "SIMPAN",
                        textAlign: TextAlign.center,
                        style: CustomText.regular14White,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  int _currentIndex;
  String _currentText = 'Pilih pekerjaan';

  _displayRadioDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Pilih Pekerjaan',
              style: CustomText.regular14,
            ),
            content: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(sampleData[index]),
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _currentText = sampleData[_currentIndex];
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                      Container(
                        height: 1.0,
                        width: double.infinity,
                        color: Colors.grey,
                      )
                    ],
                  );
                }),
            actions: <Widget>[
              new FlatButton(
                child: new Text('TUTUP'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
