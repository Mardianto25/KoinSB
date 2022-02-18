import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/pickmi/mikro/mikro_summary.dart';
import 'package:flutter_base/dashboard/pickmi/mikro/upload_data_completeness.dart';
import 'package:flutter_base/dashboard/pickmi/mikro/upload_guarantee_photo.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/widget/custom_radio.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:intl/intl.dart';

class MikroSubmissionData extends StatefulWidget {
  @override
  _MikroSubmissionDataState createState() => _MikroSubmissionDataState();
}

class _MikroSubmissionDataState extends State<MikroSubmissionData> {
  var _eKTP, _fullname, _bornAt;
  String _selectedJob, _selectedJobTime;
  List<RadioModel> kindOfGuarantee = new List<RadioModel>();
  List<RadioModel> ownershipStatus = new List<RadioModel>();
  final format = DateFormat("yyyy-MM-dd");
  final formKey = new GlobalKey<FormState>();

  List<RadioGroup> JobCategory = []
    ..add(RadioGroup("1", "Konsumtif"))
    ..add(RadioGroup("2", "Renovasi Rumah"))
    ..add(RadioGroup("3", "Modal Usaha"))
    ..add(RadioGroup("4", "Biaya Sekolah"));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kindOfGuarantee.add(new RadioModel(true, 'SHM'));
    kindOfGuarantee.add(new RadioModel(false, 'BPKB'));

    ownershipStatus.add(new RadioModel(true, 'Sendiri'));
    ownershipStatus.add(new RadioModel(false, 'Orang Tua'));
    ownershipStatus.add(new RadioModel(false, 'Pasangan'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Pinjaman Mikro", style: Theme.of(context).textTheme.title),
      ),
      body: Stack(
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
                            child: Text("Tujuan Penggunaan Pinjaman"),
                          ),
                          CustomPopupSelect(
                            title: 'Pilih tujuan penggunaan pinjaman',
                            onChangeText: (value) {},
                            radioGroup: JobCategory,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Penghasilan Per Bulan"),
                          ),
                          TextFormField(
                            onSaved: (val) => _fullname = val,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context).accentColor,
                              hintText: 'Masukkan penghasilan per bulan',
                              hintStyle: CustomText.regular16,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Pengeluaran Per Bulan"),
                          ),
                          TextFormField(
                            onSaved: (val) => _fullname = val,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context).accentColor,
                              hintText: 'Masukkan pengeluaran per bulan',
                              hintStyle: CustomText.regular16,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text("Jenis Jaminan"),
                          ),
                          Container(
                            height: 50.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: kindOfGuarantee.length,
                              itemBuilder: (BuildContext context, int index) {
                                return new Container(
                                  margin: EdgeInsets.only(right: 16.0),
                                  child: InkWell(
                                    //highlightColor: Colors.red,
                                    splashColor: Colors.blueAccent,
                                    onTap: () {
                                      setState(() {
                                        kindOfGuarantee.forEach((element) =>
                                            element.isSelected = false);
                                        kindOfGuarantee[index].isSelected =
                                            true;
                                      });
                                    },

                                    child: RadioItem(
                                        kindOfGuarantee[index], 150.0, 18.0),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text("Status Kepemilikan Pinjaman"),
                          ),
                          Container(
                            height: 50.0,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: ownershipStatus.length,
                              itemBuilder: (BuildContext context, int index) {
                                return new Container(
                                  margin: EdgeInsets.only(right: 15.0),
                                  child: InkWell(
                                    //highlightColor: Colors.red,
                                    splashColor: Colors.blueAccent,
                                    onTap: () {
                                      setState(() {
                                        ownershipStatus.forEach((element) =>
                                            element.isSelected = false);
                                        ownershipStatus[index].isSelected =
                                            true;
                                      });
                                    },

                                    child: RadioItem(
                                        ownershipStatus[index], 95.0, 13.0),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Nama Pemilik Pinjaman"),
                          ),
                          TextFormField(
                            onSaved: (val) => _fullname = val,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context).accentColor,
                              hintText: 'Masukkan nama pemilik pinjaman',
                              hintStyle: CustomText.regular16,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: new MaterialButton(
                                child: new Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: 30.0, left: 10.0, bottom: 30.0),
                                  child: Text(
                                    "Upload Foto Jaminan",
                                    style: CustomText.regular15Teal,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UploadGuaranteePhoto()));
                                },
                                elevation: 5.0,
                                shape: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.5))),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12, bottom: 80),
                            child: new MaterialButton(
                                child: new Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: 22.0, left: 10.0, bottom: 22.0),
                                  child: Text(
                                    "Upload Dokumen Kelengkapan Pinjaman",
                                    style: CustomText.regular15Teal,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UploadDataCompleteness()));
                                },
                                elevation: 5.0,
                                shape: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.5))),
                          ),
//                          GestureDetector(
//                            onTap: () {
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => MikroSummary()));
//                            },
//                            child: Container(
//                                padding: EdgeInsets.only(bottom: 0),
//                                width: double.infinity,
//                                child: CustomRegistrationButton("AJUKAN PINJAMAN", true)),
//                          )
                        ],
                      ))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 0.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MikroSummary()));
                },
                child: Container(
                    padding: EdgeInsets.only(bottom: 0),
                    width: double.infinity,
                    child: CustomRegistrationButton("AJUKAN PINJAMAN", true)),
              ),
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
