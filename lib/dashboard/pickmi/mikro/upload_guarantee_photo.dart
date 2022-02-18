import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget//custom_radio.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';

import 'package:flutter_base/model/content/RadioGroup.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';

class UploadGuaranteePhoto extends StatefulWidget {
  @override
  _UploadGuaranteePhotoState createState() => _UploadGuaranteePhotoState();
}

class _UploadGuaranteePhotoState extends State<UploadGuaranteePhoto> {
  final formKey = new GlobalKey<FormState>();
  var _address, _postalCode;
  var _listText = [
    "- Foto Cover SHM",
    "- Foto Halaman Pendaftaran Pertama",
    "- Foto Halaman Surat Ukur",
    "- Foto Halaman Lainnya"
  ];
  var _isChecked = false;
  List<RadioModel> homeStatus = new List<RadioModel>();

  List<RadioGroup> buildingOwnins = []
    ..add(RadioGroup("1", "Pilih"))
    ..add(RadioGroup("2", "Hapus"));

  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    homeStatus.add(new RadioModel(true, 'Pilih'));
    homeStatus.add(new RadioModel(false, 'Hapus'));

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
          title:
              Text("Upload Foto SHM", style: Theme.of(context).textTheme.title),
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Container(
                    child: Padding(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                        child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text("JAMINAN SERTIFIKAT HAK MILIK",
                                      style: CustomText.regular12),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  margin: EdgeInsets.only(top: 5, bottom: 10),
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              _listText[index],
                                              style: CustomText.regular12,
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                    itemCount: _listText.length,
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeStatus.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return new Container(
                                        margin: EdgeInsets.only(right: 16.0),
                                        child: InkWell(
                                          //highlightColor: Colors.red,
                                          splashColor: Colors.blueAccent,
                                          onTap: () {
                                            setState(() {
                                              homeStatus.forEach((element) =>
                                                  element.isSelected = false);
                                              homeStatus[index].isSelected =
                                                  true;
                                            });
                                          },

                                          child: RadioItem(
                                              homeStatus[index], 150.0, 18.0),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )))),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xfff2f28f),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image.asset("assets/images/ic_warning.png"),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 18),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: RichText(
                              text: TextSpan(
                                text: 'Upload minimal 3 foto jaminan',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 11),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          ' Apabila Mengunggah dokumen yang sama akan menghasilkan penolakan',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 10)),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 16, bottom: 15),
                    child: new Row(
                      children: <Widget>[
                        Container(
                          width: 87,
                          height: 87,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/banner_promo.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 87,
                          height: 87,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/banner_promo.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  _isChecked = value;
                                });
                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.75 ,
                              child: Text(
                                "Saya mengkonfirmasi nama saya dan dokumen yang"
                                " saya upload terlihat jelas",
                                style: CustomText.regular12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => MikroSubmission()));
                        },
                        child: Container(
                            padding:
                                EdgeInsets.only(left: 16, right: 16, top: 16),
                            width: double.infinity,
                            child: CustomRegistrationButton("UPLOAD", false)),
                      )
                    ],
                  ),
                ))
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
