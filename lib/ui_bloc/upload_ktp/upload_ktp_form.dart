import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/upload_ktp/upload_ktp_bloc.dart';
import 'package:flutter_base/bloc/upload_ktp/upload_ktp_event.dart';
import 'package:flutter_base/bloc/upload_ktp/upload_ktp_handle_bloc.dart';
import 'package:flutter_base/bloc/upload_ktp/upload_ktp_state.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_view/pin_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../../member_data.dart';


class UploadKtpForm extends StatefulWidget {
  @override
  State<UploadKtpForm> createState() => _UploadKtpFormState();

}

class _UploadKtpFormState extends State<UploadKtpForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  List<String> _textHint = [
    "Gunakan eKTP yang asli bukan hasil scan/fotokopi",
    "Pastikan seluruh eKTP terfoto jelas, tidak buram/blur",
    "Pastikan eKTP masih berlaku"
  ];
  File _image;
  String _statusKtp = "", _statusSelfie ="", _button="", _upload="";

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      print("image $image");
      if(_image == null){
      }else{
        _image = image;
        _onUploadKtpButtonPressed();
      }
      
    });
  }  

  @override
  void initState() {  
    super.initState();
      _getEmail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  _onUploadKtpButtonPressed() {
    BlocProvider.of<UploadKtpBloc>(context).add(
      UploadKtpButtonPressed(
        usersFile: _image
      ),
    );
  }

  
  @override
  Widget build(BuildContext context) {

    return BlocListener<UploadKtpBloc, UploadKtpState>(
      listener: (context, state) {
        if (state is UploadKtpLoading){
          loading();
        }
        if (state is UploadKtpFailure) {
          Navigator.pop(context);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
          // Navigator.pop(context);
          
        }
        if (state is UploadKtpInitial) {
          Navigator.pop(context);
          if (_button == "ktp"){
            setState(() {
              _statusKtp ="success";                                    
            });
          }
          if (_button == "selfie"){
            // success2();
            setState(() {
              _statusSelfie ="success";                  
            });
          }
          // BlocProvider.of<UploadKtpHandleBloc>(context).add(UploadKtpSuccess())

        }
       
      },
      child: BlocBuilder<UploadKtpBloc, UploadKtpState>(
        builder: (context, state) {
          return Container(
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
                          child: new FlatButton(
                            color: _statusKtp == "" ? Colors.white : Colors.teal,
                            child: new Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                              child: Text(
                                "eKTP",
                                textAlign: TextAlign.center,
                                style: _statusKtp == "" ? CustomText.bold15Primary : CustomText.bold15White,
                              ),
                            ),
                            onPressed: () {
                              _button = "ktp";
                              getImage();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => KTPCamera()));
                            },
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.teal)
                            ),
                            // borderSide: BorderSide(color: Colors.teal),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16.0),
                          child: new FlatButton(
                            color: _statusSelfie == "" ? Colors.white : Colors.teal,                                                          
                            child: new Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                              child: Text(
                                "Selfie + eKTP",
                                textAlign: TextAlign.center,
                                style: _statusSelfie == "" ? CustomText.bold15Primary : CustomText.bold15White,
                              ),
                            ),
                            onPressed: () {
                              _button = "selfie";                       
                              getImage();
                            },
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.teal)
                            ),
                            // borderSide: BorderSide(color: Colors.teal),
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
                        onPressed: () async{
                          if(_statusKtp == "success" && _statusSelfie == "success"){
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("uploadKtp", "done");
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => MemberData()
                            ));              
                          }
                        },
                        color: _statusKtp == "success" && _statusSelfie == "success" ? Colors.teal : Color(0xff727272),
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
          );
        },
      ),
    );
  }

  success(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (context) => new AlertDialog(
            title: new Text('Upload Gambar Berhasil'),
            content: new Text('Success'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () {
                  Navigator.pop(context);          
                  
                  Navigator.of(context).pop();
                  setState(() {
                    _statusKtp ="success";                                    
                  });
                }, 
                child: FlatButton(child: Text("OK", style: TextStyle(color: Colors.teal),),),
              ),
            ],
          ),
    ) ??
    false;
  }

  success2(){
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
            title: new Text('Upload Gambar Berhasil'),
            content: new Text('Success'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  
                  setState(() {
                    _statusSelfie ="success";
                    
                  });
                }, 
                child: FlatButton(child: Text("OK", style: TextStyle(color: Colors.teal),),),
              ),
            ],
          ),
    ) ??
    false;
  }

  loading(){
    return showDialog(
      context: context,
      barrierDismissible: false,  
      useRootNavigator: false,    
      builder: (context) => new AlertDialog(
            content:
            Container(

            width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height, 
            child: Container(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Loading ...", style: CustomText.bold12Black,),
                  )
                ],
              ),
            ),
          )
        ),
    ) ??
    false;
  }

  loading2(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
            content:
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.4, 
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ),
    ) ??
    false;
  }
}
