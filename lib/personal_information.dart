import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_base/widget/custom_radio.dart';
import 'model/content/RadioGroup.dart';

class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  var _eKTP, _fullname, _bornAt;
  TextEditingController _eKtpController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _bornAtController = TextEditingController();
  TextEditingController _matherController = TextEditingController();
  
  String _dateText = "Pilih tanggal";
  String _selectedReligion,
      _selectedEducation,
      _selectedDegree,
      _selectedEmergencyContact;
  final format = DateFormat("dd-MM-yyyy");
  final formKey = new GlobalKey<FormState>();

  List<RadioModel> sampleData = new List<RadioModel>();
  List<RadioModel> sampleData2 = new List<RadioModel>();

  List<RadioGroup> religions = []
    ..add(RadioGroup("1", "Islam"))
    ..add(RadioGroup("2", "Kristen"))
    ..add(RadioGroup("3", "Yahudi"));

  List<RadioGroup> educations = []
    ..add(RadioGroup("1", "S2"))
    ..add(RadioGroup("2", "S1"))
    ..add(RadioGroup("3", "SMA"))
    ..add(RadioGroup("3", "SMP"))
    ..add(RadioGroup("3", "SD"));

  List<RadioGroup> degrees = []
    ..add(RadioGroup("1", "SE"))
    ..add(RadioGroup("2", "S.KOM"))
    ..add(RadioGroup("3", "ST"));

  List<RadioGroup> relationships = []
    ..add(RadioGroup("1", "Saudara"))
    ..add(RadioGroup("2", "Orang Tua"));

  List<String> religion = [
    'ISLAM',
    'KRISTEN',
    'HINDU',
    'BUDDHA',
    'KONGHUCU',
  ];

  List<String> lastEducation = [
    'SMA/SMK SEDERAJAT',
    'D3',
    'S1',
    'S2',
    'S3',
  ];

  List<String> degree = [
    'S.Kom',
    'S.Ag',
  ];

  List<String> emergencyContact = [
    'ORANG TUA',
    'WALI',
  ];

  @override
  void initState() {
    // TODO: implement initState
    sampleData.add(new RadioModel(true, 'Laki-laki'));
    sampleData.add(new RadioModel(false, 'Perempuan'));

    sampleData2.add(new RadioModel(true, 'Lajang'));
    sampleData2.add(new RadioModel(false, 'Menikah'));
    sampleData2.add(new RadioModel(false, 'Janda / Duda'));

    super.initState();
  }

  String validateKtp(String value){
    if (value.length < 15){
      return "Nomor KTP anda salah";
    }
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("Informasi Pribadi",
              style: Theme.of(context).textTheme.title),
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
                                padding: EdgeInsets.only(top: 0.0),
                                child: Text(
                                  "Nomor eKTP",
                                  style: CustomText.regular12,
                                ),
                              ),
                              TextFormField(
                                controller: _eKtpController,
                                validator: Validator.validateEktp,
                                onSaved: (val) => _eKTP = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    labelStyle: CustomText.regular16,
                                    hintText: 'Masukkan nomor eKTP'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "Nama Lengkap",
                                  style: CustomText.regular12,
                                ),
                              ),
                              TextFormField(
                                validator: (String value) {
                                  if(value.isEmpty || value ==null){
                                    return "Silahkan isi nama anda";
                                  }
                                },
                                controller: _fullNameController,
                                onSaved: (val) => _fullname = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).accentColor,
                                    hintText: 'Masukkan nama lengkap'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "Tempat Lahir",
                                  style: CustomText.regular12,
                                ),
                              ),
                              TextFormField(
                                controller: _bornAtController,
                                validator: (String value) {
                                  if(value.isEmpty || value ==null){
                                    return "Silahkan isi tempat lahir anda";
                                  }
                                },
                                onSaved: (val) => _bornAt = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).accentColor,
                                    hintText: 'Masukkan tempat lahir'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  "Tanggal Lahir",
                                  style: CustomText.regular12,
                                ),
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
                                child: Text(
                                  "Jenis Kelamin",
                                  style: CustomText.regular12,
                                ),
                              ),
                              Container(
                                height: 50.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sampleData.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return new Container(
                                      margin: EdgeInsets.only(right: 15.0),
                                      child: InkWell(
                                        //highlightColor: Colors.red,
                                        splashColor: Colors.blueAccent,
                                        onTap: () {
                                          setState(() {
                                            sampleData.forEach((element) =>
                                                element.isSelected = false);
                                            sampleData[index].isSelected = true;
                                          });
                                        },

                                        child: RadioItem(
                                            sampleData[index], 150.0, 18.0),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  "Agama",
                                  style: CustomText.regular12,
                                ),
                              ),
                              CustomPopupSelect(
                                radioGroup: religions,
                                title: "Pilih Agama",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "Nama Ibu Kandung",
                                  style: CustomText.regular12,
                                ),
                              ),
                              TextFormField(
                                onSaved: (val) => _fullname = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).accentColor,
                                    hintText: 'Masukkan nama ibu kandung'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  "Status Perkawinan",
                                  style: CustomText.regular12,
                                ),
                              ),
                              Container(
                                height: 50.0,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sampleData2.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return new Container(
                                      margin: EdgeInsets.only(right: 15.0),
                                      child: InkWell(
                                        //highlightColor: Colors.red,
                                        splashColor: Colors.blueAccent,
                                        onTap: () {
                                          setState(() {
                                            sampleData2.forEach((element) =>
                                                element.isSelected = false);
                                            sampleData2[index].isSelected = true;
                                          });
                                        },

                                        child: RadioItem(
                                            sampleData2[index], 95.0, 13.0),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  "Pendidikan Terakhir",
                                  style: CustomText.regular12,
                                ),
                              ),
                              CustomPopupSelect(
                                radioGroup: educations,
                                title: "Pilih Pendidikan Terakhir",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  "Gelar",
                                  style: CustomText.regular12,
                                ),
                              ),
                              CustomPopupSelect(
                                radioGroup: degrees,
                                title: "Pilih Gelar",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "Kontak Darurat",
                                  style: CustomText.regular12,
                                ),
                              ),
                              TextFormField(
                                onSaved: (val) => _fullname = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).accentColor,
                                    hintText: 'Masukkan nomor kontak darurat'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  "Hubungan dengan Kontak Darurat",
                                  style: CustomText.regular12,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.12),
                                child: CustomPopupSelect(
                                  radioGroup: relationships,
                                  title: "Pilih Hubungan Dengan Kontak Darurat",
                                ),
                              ),
                            ],
                          ))),
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
                        _submit();
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
