import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget//custom_radio.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_additional_data.dart';
import 'package:flutter_base/dashboard/pickmi/mahasiswa/pickmi_parents_step_two.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';

class PickmiParentsStepOne extends StatefulWidget {
  @override
  _PickmiParentsStepOneState createState() => _PickmiParentsStepOneState();
}

class _PickmiParentsStepOneState extends State<PickmiParentsStepOne> {
  final formKey = new GlobalKey<FormState>();
  var _nim, _fakultas, _jurusan, _semesterKul, _ipk;
  List<RadioModel> homeStatus = new List<RadioModel>();
  var _selectedProvince, _selectedCity, _selectedDistrict, _selectedSubDistrict;
  var _address2, _postalCode2;
  var _selectedProvince2,
      _selectedCity2,
      _selectedDistrict2,
      _selectedSubDistrict2;

  List<RadioGroup> job = []
    ..add(RadioGroup("1", "Wiraswasta"))
    ..add(RadioGroup("2", "Pengusaha"))
    ..add(RadioGroup("3", "Programmer"));

  List<RadioGroup> regencies = []
    ..add(RadioGroup("1", "Bogor"))
    ..add(RadioGroup("2", "Bekasi"))
    ..add(RadioGroup("3", "Bandung"));

  List<RadioGroup> districts = []
    ..add(RadioGroup("1", "Ciawi"))
    ..add(RadioGroup("2", "Citeureup"))
    ..add(RadioGroup("3", "Cibinong"));

  List<RadioGroup> locations = []
    ..add(RadioGroup("1", "Pandansari"))
    ..add(RadioGroup("2", "Sindangsari"));

  List<RadioGroup> buildingOwnins = []
    ..add(RadioGroup("1", "Milik Sendiri"))
    ..add(RadioGroup("2", "Sewa"));

  List<RadioModel> homeStatus2 = new List<RadioModel>();

  List<String> sampleData = [
    'Lorem Ipsum 1',
    'Lorem Ipsum 2',
    'Lorem Ipsum 3',
    'Lorem Ipsum 4',
    'Lorem Ipsum 5',
  ];
  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    homeStatus.add(new RadioModel(true, 'D3'));
    homeStatus.add(new RadioModel(false, 'S1'));

    homeStatus2.add(new RadioModel(true, 'D3'));
    homeStatus2.add(new RadioModel(false, 'S1'));

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
          title: Text("Data Orang Tua", style: Theme.of(context).textTheme.title),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
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
                                padding: EdgeInsets.only(bottom: 10.0, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "Data Alamat Orang Tua",
                                        style: CustomText.medium12,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "(1/2)",
                                        style: CustomText.medium12,
                                      ),
                                    )
                                  ],
                                )
                                
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 16.5),
                                child: Text("Nama Lengkap Orang Tua 1 / Wali", style: CustomText.medium12),
                              ),
                              Container(
                                child: TextFormField(
                                onSaved: (val) => _nim = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    hintText: 'Masukkan nama orang tua 1 / wali'),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 8),
                                child: Text("Pekerjaan Orang Tua 1 / Wali", style: CustomText.medium12,),
                              ),
                              CustomPopupSelect(
                                onChangeText: (counter) {
                                  counter;
                                },
                                radioGroup: job,
                                title: "Pilih Pekerjaan",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Nomor HP Orang Tua 1 / Wali", style: CustomText.medium12),
                              ),
                              TextFormField(
                                onSaved: (val) => _nim = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    hintText: 'Masukkan nomor HP orang tua 1 / wali'),
                              ),
                             Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Nama Lengkap Orang Tua 2 / Wali", style: CustomText.medium12),
                              ),
                              TextFormField(
                                onSaved: (val) => _nim = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    hintText: 'Masukkan nama orang tua 2 / wali'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 8),
                                child: Text("Pekerjaan Orang Tua 2 / Wali", style: CustomText.medium12,),
                              ),
                              CustomPopupSelect(
                                onChangeText: (counter) {
                                  counter;
                                },
                                radioGroup: job,
                                title: "Pilih Pekerjaan",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Nomor HP Orang Tua 2 / Wali", style: CustomText.medium12),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 50),
                                child: TextFormField(
                                onSaved: (val) => _nim = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    hintText: 'Masukkan nomor HP orang tua 2 / wali'),
                              ),
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
                        EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => PickmiParentsStepTwo()
                          ));
                      },
                      color: Color(0xff727272),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "LANJUT",
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
