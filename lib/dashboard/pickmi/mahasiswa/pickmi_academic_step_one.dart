import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget//custom_radio.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_additional_data.dart';
import 'package:flutter_base/dashboard/pickmi/mahasiswa/pickmi_academic_step_two.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';

class PickmiAcademicStepOne extends StatefulWidget {
  @override
  _PickmiPickmiAcademicStepOneState createState() => _PickmiPickmiAcademicStepOneState();
}

class _PickmiPickmiAcademicStepOneState extends State<PickmiAcademicStepOne> {
  final formKey = new GlobalKey<FormState>();
  var _nim, _fakultas, _jurusan, _semesterKul, _ipk;
  List<RadioModel> homeStatus = new List<RadioModel>();
  var _selectedProvince, _selectedCity, _selectedDistrict, _selectedSubDistrict;
  var _address2, _postalCode2;
  var _selectedProvince2,
      _selectedCity2,
      _selectedDistrict2,
      _selectedSubDistrict2;

  List<RadioGroup> kampus = []
    ..add(RadioGroup("1", "Universitas Pakuan"))
    ..add(RadioGroup("2", "Universitas Kesatuan"))
    ..add(RadioGroup("3", "Universitas Indonesia"));

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
          title: Text("Data Mahasiswa", style: Theme.of(context).textTheme.title),
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
                                        "Data Akademik",
                                        style: CustomText.medium12,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "(1/3)",
                                        style: CustomText.medium12,
                                      ),
                                    )
                                  ],
                                )
                                
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Nama Kampus", style: CustomText.medium12),
                              ),
                              CustomPopupSelect(
                                onChangeText: (counter) {
                                  counter;
                                },
                                radioGroup: kampus,
                                title: "Pilih Kampus",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Program Pendidikan", style: CustomText.medium12,),
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
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Nomer Induk Mahasiswa (NIM)", style: CustomText.medium12),
                              ),
                              TextFormField(
                                onSaved: (val) => _nim = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    hintText: 'Masukan nomor induk mahasiswa'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Fakultas", style: CustomText.medium12),
                              ),
                              TextFormField(
                                onSaved: (val) => _fakultas = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    hintText: 'Masukan nama fakultas'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Jurusan", style: CustomText.medium12),
                              ),
                              TextFormField(
                                onSaved: (val) => _jurusan = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    hintText: 'Masukan nama jurusan'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Semester Kuliah", style: CustomText.medium12),
                              ),
                              TextFormField(
                                onSaved: (val) => _jurusan = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    hintText: 'Minimal semester 4 '),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("IPK Terakhir", style: CustomText.medium12),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 50),
                                child: TextFormField(
                                  onSaved: (val) => _jurusan = val,
                                  decoration: InputDecoration(
                                      fillColor: Theme.of(context).primaryColor,
                                      hintText: 'Masukan nilai IPK terakhir '),
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
                            builder: (context) => PickmiAcademicStepTwo()
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
