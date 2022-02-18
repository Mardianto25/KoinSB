import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/upload_profile/upload_profile_bloc.dart';
import 'package:flutter_base/bloc/upload_profile/upload_profile_event.dart';
import 'package:flutter_base/bloc/upload_profile/upload_profile_state.dart';
import 'package:flutter_base/dashboard/main.dart';
import 'package:flutter_base/model/response/profile.dart';

import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/change_email/change_email_page.dart';

import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChangeProfileForm extends StatefulWidget {
  final String email, name;
  Uint8List image ;
  

  ChangeProfileForm({Key key, @required this.email, @required this.name, @required this.image}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangeProfileFormState();
  }
}

class _ChangeProfileFormState extends State<ChangeProfileForm> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _nameController = TextEditingController();
  var passKey = GlobalKey<FormFieldState>();
  final formKey = new GlobalKey<FormState>();
  bool passwordVisible = true, _loading = false;
  ResponseProfile list ;
  var dataImage =[
    "Ambil foto dari kamera",
    "Pilih dari gallery"
  ];

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    // Navigator.pop(context);
    setState(() {
      _image = image;
      if(_image == null){
      }else{
        _onSubmited();
      }
    });
  }

  Future getGalerry() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // Navigator.pop(context);
    setState(() {
      _image = image;
      if(_image == null){
      }else{
        _onSubmited();
      }
    });
  }

  
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
   
  }

  _onSubmited() {
    BlocProvider.of<UploadProfileBloc>(context).add(
      UploadProfileButtonPressed(
        uploadProfile: _image
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadProfileBloc, UploadProfileState>(
      listener: (context, state) {
        if(state is UploadProfileLoading){
          setState(() {
             _loading = true;         
          });
        }
        if(state is UploadProfileFailure){
          setState(() {
             _loading = false;         
          });
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if(state is UploadProfileInitial){
          _success();
          setState(() {
             _loading = false;         
          });
        }
      },
      child:_loading ? Center(child: CircularProgressIndicator(),) :  Container(
            padding: EdgeInsets.all(18.0),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        _showDialog();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            widget.image.length == 0 ? Container(
                              child: Icon(
                                Icons.account_circle,
                                size: 60,
                                color: Colors.black,
                              ),
                            ): 
                            Container(
                                width: 80,
                              height: 80,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new MemoryImage(
                                          widget.image)
                                  )
                              )
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Text(
                                "Perbarui Foto Profil",
                                style: CustomText.medium16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text(
                        "Nama Lengkap",
                        style: CustomText.medium12,
                      ),
                    ),
                    TextFormField(
                      // onSaved: (val) => _newName = val,
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintStyle: CustomText.regular13Grey,
                          fillColor: Theme.of(context).primaryColor,
                          hintText: 'Nama Lengkap User'),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Email",
                        style: CustomText.medium12,
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Text(
                              widget.email,
                              style: CustomText.regular16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangeEmailPage(email: widget.email,)));
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text(
                                "Ubah",
                                style: CustomText.medium14Teal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        // _showDialog();
                      },
                      child: CustomRegistrationButton("SIMPAN", true),
                    ),
                  ),
                )
              ],
            )
          )
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Pilih Foto"),
          content:
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.18,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Theme.of(context).dividerColor))),
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              getImage();
                            },
                            title: Text("Ambil foto dari kamera",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black)),
                          ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Theme.of(context).dividerColor))),
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              getGalerry();
                            },
                            title: Text("Pilih dari gallery",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black)),
                          ),
                    ),
                    // Expanded(
                    //   child: MediaQuery.removePadding(
                    //     context: context,
                    //     removeTop: true,
                    //     child:  ListView.builder(
                    //       itemCount: dataImage.length,
                    //       itemBuilder: (context, index) {
                    //         return _buildCell(context, index);
                    //       },
                    //       shrinkWrap: true,
                    //           ),
                    //   ),
                    // ),
                  ],
                ),
              ),
                
          actions: <Widget>[
            FlatButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void _success() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Upload Profile Success "),
          
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_){
                        return Main();
                      }
                  ));
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCell(BuildContext context, index) {
  return Container(
    decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor))),
        child: ListTile(
          onTap: () {
            Navigator.pop(context);
          },
          title: Text(dataImage[index],
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
  );
  }
  
}
