import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget//custom_radio.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_additional_data.dart';
import 'package:flutter_base/dashboard/pickmi/mahasiswa/pickmi_academic_step_three.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class PickmiAcademicStepTwo extends StatefulWidget {
  @override
  _PickmiAcademicStepTwoState createState() => _PickmiAcademicStepTwoState();
}

class _PickmiAcademicStepTwoState extends State<PickmiAcademicStepTwo> {
  final formKey = new GlobalKey<FormState>();
  var _nim, _fakultas, _jurusan, _semesterKul, _ipk;
  final format = DateFormat("dd-MM-yyyy");

  String _dateText = "Pilih tanggal";
  List<RadioModel> homeStatus = new List<RadioModel>();
  var _selectedProvince, _selectedCity, _selectedDistrict, _selectedSubDistrict;
  var _address2, _postalCode2;
  var _selectedProvince2,
      _selectedCity2,
      _selectedDistrict2,
      _selectedSubDistrict2;

  List<RadioGroup> provinces = []
    ..add(RadioGroup("1", "Jawa Barat"))
    ..add(RadioGroup("2", "Jawa Tengah"))
    ..add(RadioGroup("3", "Jawa Timur"));

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
                                        "(2/3)",
                                        style: CustomText.medium12,
                                      ),
                                    )
                                  ],
                                )
                                
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Mulai Kuliah", style: CustomText.medium12),
                              ),
                              GestureDetector(
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(1900, 3, 5),
                                      maxTime: DateTime.now(), onChanged: (date) {
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    setState(() {
                                      _dateText = format.format(date).toString();

                                    });
                                    print('confirm ${date.day}');
                                  },
                                      currentTime: DateTime(2000, 6, 6),
                                      locale: LocaleType.id);
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 2.0)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 16, left: 16, bottom: 16),
                                        child: Text(
                                          _dateText,
                                          style: CustomText.regular16,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 16),
                                        child: Image.asset(
                                          "assets/images/right_arrow.png",
                                          scale: 2.2,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Perkiraan Selesai Kuliah", style: CustomText.medium12),
                              ),
                              CustomPopupSelect(
                                onChangeText: (counter) {
                                  counter;
                                },
                                radioGroup: provinces,
                                title: "Pilih Gelar",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                                child: Text("Data Beasiswa", style: CustomText.bold12),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Penerimaan Beasiswa", style: CustomText.medium12),
                              ),
                              CustomPopupSelect(
                                onChangeText: (counter) {
                                  counter;
                                },
                                radioGroup: provinces,
                                title: "Pilih",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Jangka Waktu Beasiswa", style: CustomText.medium12),
                              ),
                              CustomPopupSelect(
                                onChangeText: (counter) {
                                  counter;
                                },
                                radioGroup: provinces,
                                title: "Pilih",
                              ),
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
                            builder: (context) => PickmiAcademicStepThree()
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
