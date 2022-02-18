import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget//custom_radio.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/dashboard/komersial/komersial_upload_bpkb.dart';
import 'package:flutter_base/dashboard/komersial/komersial_summary.dart';
import 'package:flutter_base/dashboard/komersial/komersial_upload_data.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';

class KomersialDataSubmission extends StatefulWidget {
  @override
  _KomersialDataSubmissionState createState() => _KomersialDataSubmissionState();
}

class _KomersialDataSubmissionState extends State<KomersialDataSubmission> {
  final formKey = new GlobalKey<FormState>();
  var _inBul, _outBul, _name;
  List<RadioModel> jenisStatus = new List<RadioModel>();
  var _selectedProvince, _selectedCity, _selectedDistrict, _selectedSubDistrict;
  var _address2, _postalCode2;
  var _selectedProvince2,
      _selectedCity2,
      _selectedDistrict2,
      _selectedSubDistrict2;

  List<RadioGroup> loanPurpose = []
    ..add(RadioGroup("1", "Konsumtif"))
    ..add(RadioGroup("2", "Renovasi Rumah"))
    ..add(RadioGroup("3", "Modal Usaha"))
    ..add(RadioGroup("4", "Biaya Sekolah"));

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

  List<RadioModel> homeStatus = new List<RadioModel>();

  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    jenisStatus.add(new RadioModel(true, 'SHM'));
    jenisStatus.add(new RadioModel(false, 'BPKB'));

    homeStatus.add(new RadioModel(true, 'Rumah'));
    homeStatus.add(new RadioModel(false, 'Orang Tua'));
    homeStatus.add(new RadioModel(false, 'Pasangan'));
    
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
          title: Text("Pinjaman Komersial", style: Theme.of(context).textTheme.title),
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
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Tujuan Penggunaan Pinjaman", style: CustomText.medium12,),
                              ),
                              CustomPopupSelect(
                                onChangeText: (counter) {
                                  counter;
                                },
                                radioGroup: loanPurpose,
                                title: "Tujuan Pengguna Pinjaman",
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Penghasilan Perbulan", style: CustomText.medium12),
                              ),
                              TextFormField(
                                onSaved: (val) => _inBul = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    hintText: 'Masukkan penghasilan per bulan'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Pengeluaran Perbulan", style: CustomText.medium12),
                              ),
                              TextFormField(
                                onSaved: (val) => _outBul = val,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    hintText: 'Masukkan pengeluaran per bulan'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Jenis Jaminan", style: CustomText.medium12),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                height: 50.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: jenisStatus.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return new Container(
                                      margin: EdgeInsets.only(right: 16.0),
                                      child: InkWell(
                                        //highlightColor: Colors.red,
                                        splashColor: Colors.blueAccent,
                                        onTap: () {
                                          setState(() {
                                            jenisStatus.forEach((element) =>
                                                element.isSelected = false);
                                            jenisStatus[index].isSelected = true;
                                          });
                                        },

                                        child: RadioItem(
                                            jenisStatus[index], 150.0, 18.0),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Status Kepemilikan Jaminan", style: CustomText.medium12),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
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
                                            homeStatus[index], 95.0, 18.0),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Nama Pemilik Jaminan", style: CustomText.medium12),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  onSaved: (val) => _name = val,
                                  decoration: InputDecoration(
                                      fillColor: Theme.of(context).primaryColor,
                                      hintText: 'Masukkan nama pemilik jaminan'),
                                ),
                              ),
                              Container(
                                decoration: new BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Color(0xff068675)),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),                              
                                child: MaterialButton(
                                  padding: EdgeInsets.all(5.0),
                                  onPressed: () {
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => KomersialUploadBpkb()));
                                  },
                                  color: Color(0xffffffff),
                                  shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0)),
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      "Upload Foto jaminan",
                                      textAlign: TextAlign.center,
                                      style: CustomText.regular14Teal,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom:70, top: 10),
                                decoration: new BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Color(0xff068675)),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),                              
                                child: MaterialButton(
                                  padding: EdgeInsets.all(5.0),
                                  onPressed: () {
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => KomersialUploadData()));
                                  },
                                  color: Color(0xffffffff),
                                  shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0)),
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      "Upload Dokumen Kelengkapan Pinjaman",
                                      textAlign: TextAlign.center,
                                      style: CustomText.regular14Teal,
                                    ),
                                  ),
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
                        Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => KomersialSummary()));
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
