import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/referral/referral_bloc.dart';
import 'package:flutter_base/bloc/referral/referral_event.dart';
import 'package:flutter_base/bloc/referral/referral_state.dart';
import 'package:flutter_base/dashboard/main.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/login/login_main.dart';
import 'package:flutter_base/widget/custom_button.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/widget/custom_roundrec_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferralForm extends StatefulWidget {
  final type;  
  
  ReferralForm({Key key, @required this.type}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _ReferralFormState();
}

class _ReferralFormState extends State<ReferralForm> {
  final _refCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _enable =false;
  @override
  void initState() {
    super.initState();
  }

  _onButtonPressed() {
    setDataMember();
    BlocProvider.of<ReferralBloc>(context).add(
      ReferralButtonPressed(publicId: "", refcode: _refCodeController.text),
    );
  }

  setDataMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loginStatus", "done");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReferralBloc, ReferralState>(
        listener: (context, state) {
          if (state is ReferralLoading) {
            // setState(() {
            //    _loading = true;           
            // });
            loading();
          }
          if (state is ReferralFailure) {
            //  setState(() {
            //    _loading = false;           
            // });
            Navigator.of(context).pop();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is ReferralInitial) {

            // setState(() {
            //    _loading = false;           
            // });
            if(widget.type=="piko"){
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_){
                      return LoginMain();
                    }
                )
                
              );
            }else{
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_){
                      return Main();
                    }
                )
                
              );

            }
            // setState(() {
            //    _loading = false;           
            // });
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => Main()),
            //     ModalRoute.withName('/'));
            // BlocProvider.of<RegisterHandleBloc>(context).add(RegisterSuccess());
          }
        },
        child:Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: SvgPicture.asset("assets/svg/ic-refer-fix.svg"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: Text(
                        "Kode Referral",
                        style: CustomText.bold18,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Text(
                        "Undang teman untuk bergabung bersama kami di Koperasi Simpan Pinjam Sejahtera Bersama dengan menggunakan kode referral & dapatkan bonus spesial ",
                        style: CustomText.regular13,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      color: Colors.grey,
                      width: double.infinity,
                      height: 1,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 200,
                            child: TextFormField(
                              controller: _refCodeController,
                              onChanged: (_){
                                if(_.length > 8){
                                  setState(() {
                                    _enable =true;                      
                                  });

                                }else{
                                  setState(() {
                                    _enable =false;                      
                                  });
                                }
                              },
                              decoration: InputDecoration.collapsed(
                                  border: InputBorder.none,
                                  fillColor: Theme.of(context).accentColor,
                                  hintText: 'Masukkan Kode Referral'),
                            ),
                          ),
                          Container(
                            height: 35,
                            child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.teal)),
                                onPressed: () {
                                  
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("CARI", style: CustomText.bold12Teal,),
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 1,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 26.5),
                      child: Text(
                        "Status Kode Referral",
                        style: CustomText.bold14,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 1,
                    ),
                  ],
                )),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _onButtonPressed();
                          // if (_formKey.currentState.validate()) {
                          //     _formKey.currentState.save();
                          //   }
                        },
                        child: Container(
                            width: double.infinity,
                            child: CustomButton(
                                "PASANGKAN KODE REFERRAL", _enable)),
                      ),
                      GestureDetector(
                        onTap: () {
                          // _onButtonPressed();
                          if(widget.type=="piko"){
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_){
                                    return LoginMain();
                                  }
                              )
                              
                            );
                          }else{
                            Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Main()),
                              ModalRoute.withName('/'));
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(
                            //       builder: (_){
                            //         return Main();
                            //       }
                            //   )
                              
                            // );

                          }
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => Main()),
                          //     ModalRoute.withName('/'));
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 12, bottom: 23),
                            width: double.infinity,
                            child: CustomRoundRecButton("LEWATI", false)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  success2() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
              content: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )),
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
}


