import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/ktp_camera.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:image_picker/image_picker.dart';


class UploadKTP extends StatefulWidget {
  @override
  _UploadKTPState createState() => _UploadKTPState();
}

class _UploadKTPState extends State<UploadKTP> {
  List<String> _textHint = [
    "Gunakan eKTP yang asli bukan hasil scan/fotokopi",
    "Pastikan seluruh eKTP terfoto jelas, tidak buram/blur",
    "Pastikan eKTP masih berlaku"
  ];

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    Navigator.pop(context);
    setState(() {
      _image = image;
    });
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Upload KTP dan Selfie",
            style: Theme.of(context).textTheme.title),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: new OutlineButton(
                        child: new Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Text(
                            "eKTP",
                            textAlign: TextAlign.center,
                            style: CustomText.bold15Primary,
                          ),
                        ),
                        onPressed: () {
                          getImage();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => KTPCamera()));
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: new OutlineButton(
                        child: new Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Text(
                            "Selfie + eKTP",
                            textAlign: TextAlign.center,
                            style: CustomText.bold15Primary,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KTPCamera()));
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: Text(
                        "Panduan foto KTP",
                        textAlign: TextAlign.left,
                        style: CustomText.bold13,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/ktp_valid.png",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "assets/images/ktp_failed.png",
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _textHint.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("\u2022"),
                                      Container(
                                        margin: EdgeInsets.only(left: 10.0),
                                        width: MediaQuery.of(context).size.width *
                                            0.83,
                                        child: Text(
                                          _textHint[index],
                                          style: CustomText.regular13,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ))),
                    Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(top: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/ic_secure_shield.png",
                                fit: BoxFit.cover,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10.0),
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  "Kami pastikan data Anda aman tersimpan di sistem kami dan bersifat rahasia",
                                  style: CustomText.regular10,
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: MaterialButton(
                    onPressed: () {},
                    color: Color(0xff727272),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "UPLOAD FOTO",
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
