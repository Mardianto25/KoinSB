import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:intl/intl.dart';

import 'model/content/RadioGroup.dart';

class JobData extends StatefulWidget {
  @override
  _JobDataState createState() => _JobDataState();
}

class _JobDataState extends State<JobData> {
  var _eKTP, _fullname, _bornAt;
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

  List<RadioGroup> JobCategory = []
    ..add(RadioGroup("1", "Teknisi"))
    ..add(RadioGroup("2", "Supervisi"))
    ..add(RadioGroup("3", "Manager"));

  List<RadioGroup> JobStatus = []
    ..add(RadioGroup("1", "Full Time"))
    ..add(RadioGroup("2", "Part Time"))
    ..add(RadioGroup("3", "Freelance"));

  List<RadioGroup> LengthWork = []
    ..add(RadioGroup("1", "> 1 Tahun"))
    ..add(RadioGroup("2", "> 2 Tahun"))
    ..add(RadioGroup("3", "> 5 Tahun"));

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
        title: Text("Data Pekerjaan", style: Theme.of(context).textTheme.title),
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
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text("Jenis Pekerjaan", style: CustomText.regular12,),
                          ),
                          CustomPopupSelect(
                            radioGroup: JobCategory,
                            title: "Pilih Jenis Pekerjaan",
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Nama Instansi", style: CustomText.regular12,),
                          ),
                          TextFormField(
                            onSaved: (val) => _fullname = val,
                            decoration: InputDecoration(
                                fillColor: Theme.of(context).accentColor,
                                hintText: 'Masukkan nama instansi', hintStyle: CustomText.regular16,),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text("Status pekerjaan", style: CustomText.regular12,),
                          ),
                          CustomPopupSelect(
                            radioGroup: JobStatus,
                            title: "Pilih Status Pekerjaan",
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text("Lama Bekerja", style: CustomText.regular12,),
                          ),
                          CustomPopupSelect(
                            radioGroup: LengthWork,
                            title: "Pilih Lama Bekerja",
                          ),
                        ],
                      ))),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: MaterialButton(
                    onPressed: () {},
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
