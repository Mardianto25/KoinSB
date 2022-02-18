import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/address_data.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_submission_approve.dart';
import 'package:flutter_base/data_confirmation.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_job_data.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_rekening_information.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_supporting_documents.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_fund_loans.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_proof_of_income.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_address_data.dart';
import 'package:flutter_base/dashboard/pickmi/mahasiswa/pickmi_academic_step_one.dart';
import 'package:flutter_base/dashboard/pickmi/mahasiswa/pickmi_additional_document.dart';
import 'package:flutter_base/dashboard/pickmi/mahasiswa/pickmi_parents_step_one.dart';
import 'package:flutter_base/personal_information.dart';
import 'package:flutter_base/spesimen_sign.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/upload_ktp.dart';

class PickmiAdditionalMahasiswa extends StatefulWidget {
  PickmiAdditionalMahasiswa({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PickmiAdditionalMahasiswaState createState() => _PickmiAdditionalMahasiswaState();
}

class _PickmiAdditionalMahasiswaState extends State<PickmiAdditionalMahasiswa> {
  int _counter = 0;
  var _btnTxt = [
    "Data Mahasiswa",
    "Data Orang Tua",
    "Upload Dokumen",
    "Data Pendukung"
  ];

  var _btnPage = [
    PickmiAcademicStepOne(),
    PickmiParentsStepOne(),
    PickmiAdditionalDocument(),
    ProofOfIncome()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Upload Data Pelengkap",
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Center(
                child: ListView.builder(
              itemCount: _btnTxt.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0),
                  child: new MaterialButton(
                      child: new Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.only(top: 30.0, left: 10.0, bottom: 30.0),
                        child: Text(
                          _btnTxt[index],
                          style: CustomText.regular16Teal,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => _btnPage[index]));
                      },
                      elevation: 5.0,
                      shape: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.5))),
                );
              },
            )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PickmiSubmissionApprove()));
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
