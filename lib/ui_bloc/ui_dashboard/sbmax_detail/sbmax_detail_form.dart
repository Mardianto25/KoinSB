import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_detail_anggota/sbmax_detail_anggota_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_detail_anggota/sbmax_detail_anggota_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_detail_anggota/sbmax_detail_anggota_state.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pencairan/sbmax_pencairan_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pencairan/sbmax_pencairan_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pencairan/sbmax_pencairan_state.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_success.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_thawing.dart';
import 'package:flutter_base/model/response/sbmax_detail.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_thawing/sbmax_thawing_page.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SbmaxDetailForm extends StatefulWidget {
  String noac;

  SbmaxDetailForm({Key key, @required this.noac}) : super(key: key);
  

  @override
  State<StatefulWidget> createState() {
    return _SbmaxDetailFormState();
  }
}

class _SbmaxDetailFormState extends State<SbmaxDetailForm> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _passwordController = TextEditingController();
  var _pass;
  bool _obscureTextOld = true;
  bool passwordVisible = true, _loading = false;
  ResponseSbmaxDetail list;
  final money = NumberFormat("#,##0","en_US");
  DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
  var passKey = GlobalKey<FormFieldState>();
  final formKey = new GlobalKey<FormState>();
  String _imei;
  @override
  void initState() {
    super.initState();
    getDataImei();
    _onSubmited();
  }

  void getDataImei()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _imei = prefs.getString("imei");
  }

  _onSubmited() {
    BlocProvider.of<SbmaxDetailAnggotaBloc>(context).add(
      SubmittedSbmaxDetailAnggota(
        noac: widget.noac
      ),
    );
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
          // list = state.sbmaxDetailAnggota.response;
          // setState(() {
          //   _loading = false;         
          // });
        }
       
      },
        child:BlocBuilder<SbmaxDetailAnggotaBloc, SbmaxDetailAnggotaState>(
        builder: (context, state) { 
          if (state is SbmaxDetailAnggotaLoading){
          // success2();
            return LoadingIndicator();
          }
          if (state is SbmaxDetailAnggotaFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is SbmaxDetailAnggotaInitial) {
            list = state.sbmaxDetailAnggota.response;
            return Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width * 0.3,
                  color: Color(0xff068675),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 9, top: 10),
                          child: Text(
                            "Detil Simpanan Berjangka Maximal",
                            style: CustomText.regular14White,
                          ),
                        ),
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xff068675)),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                            
                                Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Container(
                                            child: Text("Penempatan Pokok",
                                                style: CustomText.regular13Grey),
                                          ),
                                        ),
                                        Container(
                                          child: Container(
                                            child: Text("Rp ${money.format(list.data.penempatanProduk)}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                          ),
                                        )
                                      ],
                                    )
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Container(
                                            child: Text("Jasa simpanan berjangka",
                                                style: CustomText.regular12Grey),
                                          ),
                                        ),
                                        Container(
                                          child: Container(
                                            child: Text("${list.data.jasa}% p.a.",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                          ),
                                        )
                                      ],
                                    )
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Container(
                                            child: Text("Jasa terbentuk",
                                                style: CustomText.regular13Grey),
                                          ),
                                        ),
                                        Container(
                                          child: Container(
                                            child: Text("Rp ${money.format(list.data.jasaTerbentuk)}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14, color: Colors.green)),
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Container(
                                            child: Text("Tanggal jatuh tempo",
                                                style: CustomText.regular13Grey),
                                          ),
                                        ),
                                        Container(
                                          child: Container(
                                            child: Text(list.data.tglJthTempo == null ? "00 bulan 0000" : "${list.data.tenor} bulan ${list.data.tglJthTempo}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Container(
                                            child: Text("Jumlah saat jatuh tempo",
                                                style: CustomText.regular13Grey),
                                          ),
                                        ),
                                        Container(
                                          child: Container(
                                            child: Text("Rp ${money.format(list.data.jumlahSaatJthTempo)}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                
                                
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:12),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xff068675)),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Padding(
                            padding: EdgeInsets.only(top:16.0, left: 16.0, right: 10.0, bottom: 13.0),
                            child: Column(
                              children: <Widget>[
                                
                                Container(
                                  child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        margin: EdgeInsets.only(top:0),
                                        child: Text("Rekening KOIN-SB yang dipilih untuk transaksi ini",
                                            style: CustomText.regular10Grey),
                                      ),
                                    )
                                  ],
                                )),
                                Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Container(
                                            child: Text(list.data.noac,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                          ),
                                        )
                                      
                                      ],
                                    )),
                                
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:12),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xff068675)),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Padding(
                            padding: EdgeInsets.only(top:16.0, left: 16.0, right: 10.0, bottom: 13.0),
                            child: Column(
                              children: <Widget>[
                                
                                Container(
                                  child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        margin: EdgeInsets.only(top:0),
                                        child: Text("Status Pengajuan Pencairan SB Maximal dipercepat",
                                            style: CustomText.regular10Grey),
                                      ),
                                    )
                                  ],
                                )),
                                Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Container(
                                            child: Text(list.data.status,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                          ),
                                        )
                                      
                                      ],
                                    )),
                                
                              ],
                            ),
                          ),
                        ),                        
                      ],
                    ),
                  ),
                ),

                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 12, bottom: 16, left: 16, right: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SbmaxThawingPage(noac: widget.noac,)));
                      },
                      child: Container(
                          decoration: new BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xff068675)),
                          borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.all(16),
                          width: double.infinity,
                          child: Text("ATUR SIMPANAN INI", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff096d5c)),),),
                    ),
                  )
                )
              
              ],
            );
          }
          
        }
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
                              controller: _passwordController,
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
