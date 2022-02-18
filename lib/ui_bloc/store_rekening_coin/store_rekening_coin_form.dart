import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/store_rekening_coin/store_rekening_coin_bloc.dart';
import 'package:flutter_base/bloc/store_rekening_coin/store_rekening_coin_event.dart';
import 'package:flutter_base/bloc/store_rekening_coin/store_rekening_coin_state.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/email_otp/email_page.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/widget/custom_roundrec_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StoreRekeningCoinForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _StoreRekeningCoinFormState();
}

class _StoreRekeningCoinFormState extends State<StoreRekeningCoinForm> {
  // double bottomSheetTopPosition = 50;
  final formKey = new GlobalKey<FormState>();
  TextEditingController _rekeningController = TextEditingController();
  StoreRekeningCoinBloc _getBloc;
  String _status = "Status Rekening"; 
  int _statusAnggota ;
  bool _loading = false, _enable = false;
  

  @override
  void initState() {
    _getBloc = BlocProvider.of<StoreRekeningCoinBloc>(context);
    super.initState();

  }

  setIsAnggota(data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('isAnggota', data);          
  }


  @override
  Widget build(BuildContext context) {
    _onRegisterButtonPressed() {    
      BlocProvider.of<StoreRekeningCoinBloc>(context).add(
        StoreRekeningCoinButtonPressed(
          rekening: _rekeningController.text
        ),
      );
    }
   return BlocListener<StoreRekeningCoinBloc, StoreRekeningCoinState>(
      listener: (context, state) {
        if (state is StoreRekeningCoinLoading){
          success2();
          // setState(() {         
          //   _loading = true;          
          // });
        }
        if (state is StoreRekeningCoinFailure) {
          // setState(() {
          //   _loading = false;          
          // });
          Navigator.of(context).pop();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is StoreRekeningCoinInitial) {
          // setState(() {
          //    _loading = false;         
          // });
          Navigator.of(context).pop();
          if(state.dataRekening.response.data.isAnggota == 1){
            setState(() {
              _statusAnggota = state.dataRekening.response.data.isAnggota;
              setIsAnggota(_statusAnggota);          
              _status = "Ditemukan";            
            });
          }else{
            setState(() {
              _statusAnggota = state.dataRekening.response.data.isAnggota;     
              setIsAnggota(_statusAnggota);                                 
              _status = "Tidak ditemukan";
                          
            });
          }
        }
       
      }, 
  child: Stack(
     children: <Widget>[
       Container(
          color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 74.2, right: 74.2),
                            margin: EdgeInsets.only(bottom: 28.7),
                            child: SvgPicture.asset("assets/svg/ic-rek-koin.svg")),
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Masukkan Nomor Rekening KOIN",
                              style: CustomText.bold18,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 16, left: 16, bottom: 16),
                            child: Text(
                              "Silahkan masukan nomor rekening tabungan KOIN KSP Sejahtera Bersama yang anda miliki",
                              textAlign: TextAlign.center,
                              style: CustomText.regular12,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 16, left: 16),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1.0, color: Colors.grey)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: TextFormField(  
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    controller: _rekeningController,
                                    onChanged: (_){
                                      setState(() {
                                        if(_.length < 1){
                                          _enable = false;
                                        }else{
                                          _enable = true;
                                        }
                                                                              
                                      });
                                    },
                                    decoration: InputDecoration.collapsed(
                                        fillColor: Colors.teal,
                                        hintText: 'Masukan Nomor Rekening'),
                                  ),
                                ),
                                Container(
                                  child: FlatButton(
                                    color: Colors.transparent,
                                    textColor: Color(0xff096d5c),
                                    splashColor: Color(0xff02554a),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(5.0),
                                      side: BorderSide(color: Colors.teal)
                                    ),
                                    onPressed: () {
                                      _onRegisterButtonPressed();
                                      // Navigator.push(context, MaterialPageRoute(
                                      //   builder: (context) => PickmiChangeRekening()
                                      // ));
                                    },
                                    child: Text(
                                      "CEK REKENING",
                                      style: TextStyle(fontSize: 14.0)
                                    ),
                              ),
                                )
                                
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 16),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide( //                    <--- top side
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),),),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Center(child: _status =="Ditemukan" ? Text(_status, style: TextStyle(color: Colors.teal, fontSize: 16, fontWeight: FontWeight.bold),) : Text(_status, style: CustomText.bold16,),),
                                ),
                              ] 
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setIsAnggota(0);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => EmailPage()
                                ));
                              },
                              child: Container(
                                  width: double.infinity,
                              child: CustomRoundRecButton("LEWATI", false)),
                        ),
                        GestureDetector(
                          onTap: () {
                            !_enable? null :Navigator.push(context, MaterialPageRoute(
                                builder: (context) => EmailPage()
                              )
                            );
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 12, bottom: 0),
                              width: double.infinity,
                              child: CustomRegistrationButton("LANJUT", !_enable ? false : true)),
                        )
                      ],
                    ),
                  ),
                    ),
              ],
            ),
        ),
     ],
    ),
   );
  }
  success2(){
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
  
  _widget(){
    Navigator.of(context).pop();
  }
  
}
