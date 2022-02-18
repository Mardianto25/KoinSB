import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget//custom_radio.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_additional_data.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';

class PickmiAddressData extends StatefulWidget {
  @override
  _PickmiAddressDataState createState() => _PickmiAddressDataState();
}

class _PickmiAddressDataState extends State<PickmiAddressData> {
  final formKey = new GlobalKey<FormState>();
  var _address, _postalCode;
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
    homeStatus.add(new RadioModel(true, 'Rumah'));
    homeStatus.add(new RadioModel(false, 'Kantor'));

    homeStatus2.add(new RadioModel(true, 'Rumah'));
    homeStatus2.add(new RadioModel(false, 'Kantor'));

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
          title: Text("Alamat Pengiriman", style: Theme.of(context).textTheme.title),
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
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  "Alamat Rumah Berdasarkan eKTP",
                                  style: CustomText.medium11,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Status Tempat Tinggal", style: CustomText.medium12,),
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
                                child: Text("Alamat Lengkap", style: CustomText.medium12),
                              ),
                              TextFormField(
                                onSaved: (val) => _address = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    hintText: 'Cth: Jl.Antariksa No.xx'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Provinsi", style: CustomText.medium12),
                              ),
                              CustomPopupSelect(
                                onChangeText: (counter) {
                                  counter;
                                },
                                radioGroup: provinces,
                                title: "Pilih Provinsi",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Kota/Kabupaten", style: CustomText.medium12),
                              ),
                              CustomPopupSelect(
                                  onChangeText: (counter) {
                                    counter;
                                  },
                                  radioGroup: regencies,
                                  title: "Pilih Kota/Kabupaten",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Kecamatan", style: CustomText.medium12),
                              ),
                              CustomPopupSelect(
                                onChangeText: (counter) {
                                  counter;
                                },
                                radioGroup: districts,
                                title: "Pilih Kecamatan",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Kelurahan", style: CustomText.medium12),
                              ),
                              CustomPopupSelect(
                                onChangeText: (counter) {
                                  counter;
                                },
                                radioGroup: locations,
                                title: "Pilih Kelurahan",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Kode Pos", style: CustomText.medium12),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 70),
                                child: TextFormField(
                                  onSaved: (val) => _postalCode = val,
                                  decoration: InputDecoration(
                                      fillColor: Theme.of(context).primaryColor,
                                      hintText: 'Masukkan kode pos'),
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
                        Navigator.pop(context);
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => PickmiAdditionalData()
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
