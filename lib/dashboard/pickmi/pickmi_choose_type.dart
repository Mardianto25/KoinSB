import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_additional_data.dart';
import 'package:flutter_base/dashboard/pickmi/mahasiswa/pickmi_additional_data_mahasiswa.dart';

class PickmiChooseType extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PickmiChooseTypeState();
  }
}

class _PickmiChooseTypeState extends State<PickmiChooseType> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("Pinjaman Pickmi",
              style: Theme.of(context).textTheme.title),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _showDialog("Karyawan");
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xff096d5c),
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              padding: EdgeInsets.only(top: 21, bottom: 20, left: 24, right: 24),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // child: SvgPicture.asset("assets/svg/ic-loan-regular.svg"),
                                     child: Image.asset("assets/images/ic_loan_regular.png"),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(bottom: 6),
                                          child: Text(
                                            "Karyawan",
                                            style: CustomText.regular18white,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        
                                        Container(
                                          child: Text(
                                            "KTP + Bukti Pendapatan & Alamat",
                                            style: CustomText.regular14White,
                                          ),
                                        )
                                        
                                      ],
                                    ) 
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showDialog("Mahasiswa");
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xff71ab3c),
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              padding: EdgeInsets.all(23),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // child: SvgPicture.asset("assets/svg/ic-loan-student.svg"),
                                    child: Image.asset("assets/images/ic_loan_student.png"),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(bottom: 6),
                                          child: new Text(
                                            "Mahasiswa",
                                            style: CustomText.regular18white,
                                          ),
                                        ),
                                        Container(
                                          child: new Text(
                                            "KTP + Data Akademis",
                                            style: CustomText.regular14White,
                                          ),
                                        )
                                       
                                      ],
                                    ) 
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          )),
        ));
  }

  void _showDialog(str) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: new Text(
              "Syarat dan Ketentuan",
              style: CustomText.medium16,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Dengan memilih setuju, Anggota telah menyetujui',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Syarat dan Ketentuan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.underline,)),
                      TextSpan(text: ' yang berlaku'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if(str=="Mahasiswa"){
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PickmiAdditionalMahasiswa()));
                    }else{
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PickmiAdditionalData()));
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      child: Container(
                        height: 38,
                        margin: EdgeInsets.only(bottom: 12, top: 23),
                        decoration: BoxDecoration(
                          color: Color(0xff096d5c),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: MaterialButton(
                          child: Text(
                            "SETUJU",
                            style: CustomText.bold14White,
                          ),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 38,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.teal),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3.0,
                          ),
                        ]),
                        child: MaterialButton(
                          child: Text(
                            "TIDAK",
                            style: CustomText.medium14Teal,
                          ),
                        ),
                      )),
                )
              ],
            ));
      },
    );
  }
}
