import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_inisiasi/sbmax_inisiasi_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_inisiasi/sbmax_inisiasi_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_inisiasi/sbmax_inisiasi_state.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pencairan/sbmax_pencairan_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pencairan/sbmax_pencairan_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pencairan/sbmax_pencairan_state.dart';

import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail/sbmax_simulasi_detail_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail/sbmax_simulasi_detail_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail/sbmax_simulasi_detail_state.dart';
import 'package:flutter_base/dashboard/main.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_success.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_thawing.dart';
import 'package:flutter_base/model/content/sbmax_inisiasi.dart';
import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/model/response/sbmax_simulasi_detail_response.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SbmaxThawingForm extends StatefulWidget {
  String noac;

  SbmaxThawingForm({Key key, @required this.noac}) : super(key: key);
  

  @override
  State<StatefulWidget> createState() {
    return _SbmaxThawingFormState();
  }
}

class _SbmaxThawingFormState extends State<SbmaxThawingForm> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _passwordController = TextEditingController();
  
  ResponseDetailSimulasi list;
  final money = NumberFormat("#,##0","en_US");
  var passKey = GlobalKey<FormFieldState>();
  final formKey = new GlobalKey<FormState>();
  var _pass;
  String _imei;
  bool _obscureTextOld = true;
  bool passwordVisible = true, _loading = false;

  @override
  void initState() {
    super.initState();
    getDataImei();
  }

  void getDataImei() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _imei = prefs.getString("imei");
  }
  
  _onCair() {
    BlocProvider.of<SbmaxPencairanBloc>(context).add(
      SubmittedSbmaxPencairan(
        imei: _imei,
        noac: widget.noac,
        password: _passwordController.text
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SbmaxPencairanBloc, SbmaxPencairanState>(
      listener: (context, state) {
         if (state is SbmaxPencairanLoading){
          return LoadingIndicator();
        }
        if (state is SbmaxPencairanFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
          // setState(() {
          //   _loading = false;         
          // });
        }
        if (state is SbmaxPencairanInitial) {
           Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_){
                      return Main();
                    }
                )
              
            );
          // list = state.sbmaxDetailAnggota.response;
          // setState(() {
          //   _loading = false;         
          // });
        }
       
      },
      child:  Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: SvgPicture.asset("assets/svg/ic-success-01.svg")
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Cairkan SB Maximal",
                    textAlign: TextAlign.center,
                    style: CustomText.bold18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    "Pencairan sebelum tanggal jatuh tempo akan dikenakan \nbiaya pinalti sebesar 5% dari besar penempatan \nSimpanan Berjangka Maximal",
                    textAlign: TextAlign.center,
                    style: CustomText.regular12,
                  ),
                )

              ],
            ),
            GestureDetector(
              onTap: (){
                _showDialog();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                child: CustomRegistrationButton("CAIRKAN SIMPANAN BERJANGKA INI", true)
              ),
            ),
          ],
        )
      )
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 15.0, bottom: 18.0),
                              child: Text(
                                "Password Transaksi",
                                style: CustomText.bold16,
                              ),
                            ),
                            TextFormField(
                              key: passKey,
                              keyboardType: TextInputType.text,
                              obscureText: passwordVisible,
                              onSaved: (val) => _pass = val,
                              decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff707070), width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff707070), width: 1.0),
                                  ),
                                  hintStyle: CustomText.regular16,
                                  fillColor: Theme.of(context).primaryColor,
                                  hintText: '',
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              passwordVisible = !passwordVisible;
                                            });
                                          },
                                          child: Icon(
                                            passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.black,
                                          ),
                                        ),),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16, bottom: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(""),
                                  ),
                                  Container(
                                    child: Text("Lupa password transaksi?", style: CustomText.regular14,),
                                  ),
                                ],
                              )
                            )
                            
                          ],
                        )
                      )
                    ),
                
                Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                       _onCair();
                      },
                      child: Container(
                          // padding: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          child: CustomRegistrationButton("KONFIRMASI", true)),
                    )),
              ],
            ));
      },
    );
  }
}
