import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_inisiasi/sbmax_inisiasi_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_inisiasi/sbmax_inisiasi_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_inisiasi/sbmax_inisiasi_state.dart';

import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail_non/sbmax_simulasi_detail_non_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail_non/sbmax_simulasi_detail_non_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail_non/sbmax_simulasi_detail_non_state.dart';

import 'package:flutter_base/dashboard/sbmax/sbmax_success.dart';
import 'package:flutter_base/model/content/sbmax_inisiasi.dart';
import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/model/response/sbmax_simulasi_detail_response.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_nominal/sbmax_nominal_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SbmaxSimulasiDetailNonForm extends StatefulWidget {
   String noac;
  List<DataSimulasi> list ;

  SbmaxSimulasiDetailNonForm({Key key, @required this.noac, @required this.list}) : super(key: key);
  

  @override
  State<StatefulWidget> createState() {
    return _SbmaxSimulasiDetailNonFormState();
  }
}

class _SbmaxSimulasiDetailNonFormState extends State<SbmaxSimulasiDetailNonForm> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  ResponseDetailSimulasi list;
  final money = NumberFormat("#,##0","en_US");
  var passKey = GlobalKey<FormFieldState>();
  final formKey = new GlobalKey<FormState>();
  var _pass;
  bool _obscureTextOld = true;
  bool passwordVisible = true, _loading = false;

  @override
  void initState() {
    super.initState();
    _onSubmited();
  }

  _onSubmited() {
    BlocProvider.of<SbmaxSimulasiDetailNonBloc>(context).add(
      SubmittedSbmaxSimulasiDetailNon(
        param: SbmaxSimulasiDetail(
          jasa: widget.list[1].jasa,
          nominal: widget.list[1].nominal,
          nominalJasa: widget.list[1].nominalJasa,
          nominalTotal: widget.list[1].nominalTotal,
          tenor: widget.list[1].tenor
        ),      
      ),
    );
  }

  _onClick() {
     if(list.data == null){
      BlocProvider.of<SbmaxInisiasiBloc>(context).add(
        SubmittedSbmaxInisiasi(
          param: SbmaxInisiasi(
            jasa: "",
            jthTempo: "",
            nominal: "",
            nominalJasa: "",
            nominalTotal: "",
            tenor: "",
          ),
          no: ""        
        ),
      );
    }else{
      BlocProvider.of<SbmaxInisiasiBloc>(context).add(
        SubmittedSbmaxInisiasi(
          param: SbmaxInisiasi(
            jasa: list.data.jasa == null ? "" : list.data.jasa,
            jthTempo: list.data.jthTempo ==null ? "" : list.data.jthTempo,
            nominal: list.data.nominal ==null ? "" : list.data.nominal,
            nominalJasa: list.data.nominalJasa ==null ? "" : list.data.nominalJasa,
            nominalTotal: list.data.nominalTotal ==null ? "" : list.data.nominalTotal,
            tenor: list.data.tenor ==null ? "" : list.data.tenor,
          ),
          no: ""       
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SbmaxInisiasiBloc, SbmaxInisiasiState>(
      listener: (context, state) {
        if (state is SbmaxInisiasiLoading){
          // return LoadingIndicator();
          setState(() {
            _loading = true;         
          });
        }
        if (state is SbmaxInisiasiFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            _loading = false;         
          });
        }
        if (state is SbmaxInisiasiInitial) {

          setState(() {
            _loading = false;         
          });
          Navigator.push(context, MaterialPageRoute(
            builder: (contex) => SBMaxSuccess()
          ));
        }
       
      },
      child:BlocBuilder<SbmaxSimulasiDetailNonBloc, SbmaxSimulasiDetailNonState>(
        builder: (context, state) { 
          if (state is SbmaxSimulasiDetailNonLoading){
            _loading = true;         
          }
          if (state is SbmaxSimulasiDetailNonFailure) {
            _loading = false;    
            list = state.sbmaxSimulasiDetailNon.response;     
            return _loading ? Center(child: CircularProgressIndicator(),) : _build();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
          }
          if (state is SbmaxSimulasiDetailNonInitial) {
            _loading = false;         
            list = state.sbmaxSimulasiDetailNon.response;
            return _loading ? Center(child: CircularProgressIndicator(),) : _build();
          }
          
        }
      )
    );
  }

  Widget _build(){
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width * 0.3,
          color: Color(0xff068675),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 9, top: 10),
                  child: Text(
                    "Periksa kembali penempatan produk SBmax",
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
                          child: Row(
                          children: <Widget>[
                            Container(
                              child: Container(
                                child: Text("Besar penempatan dana Simpanan Berjangka",
                                    style: CustomText.regular12Grey),
                              ),
                            )
                          ],
                        )),
                        Container(
                            margin: EdgeInsets.only(top: 9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    child: Text(list.data == null ? "Hingga 25 Mei 2020" : "Hingga ${list.data.jthTempo}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ),
                                Container(
                                  child: Container(
                                    child: Text(list.data == null ? "Rp. 0" : "Rp ${money.format(list.data.nominal)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                )
                              ],
                            )),
                        Container(
                          child: Row(
                          children: <Widget>[
                            Container(
                              child: Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Text("Pendapatan jasa (sebelum Pajak)",
                                    style: CustomText.regular12Grey),
                              ),
                            )
                          ],
                        )),
                        Container(
                            margin: EdgeInsets.only(top: 9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    child: Text(list.data == null ? "Rp 0" :"${list.data.jasa}% p.a",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ),
                                Container(
                                  child: Container(
                                    child: Text(list.data == null ?"Rp 0" : "Rp ${money.format(list.data.nominalJasa)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                )
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                          children: <Widget>[
                            Container(
                              child: Container(
                                child: Text("Dana bertumbuh menjadi (ini hanya hitungan indikatif)",
                                    style: CustomText.regular12Grey),
                              ),
                            )
                          ],
                        )),
                        Container(
                            margin: EdgeInsets.only(top: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    child: Text("",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ),
                                Container(
                                  child: Container(
                                    child: Text(list.data == null ?"Rp 0":"Rp ${money.format(list.data.nominalTotal)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff71ab3c),
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
                                child: Text("Biaya Keanggotaan",
                                    style: CustomText.regular10Grey),
                              ),
                            )
                          ],
                        )),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    child: Text("Simpanan Pokok, Simpanan Wajib, \nsaldo awal rekening  KOIN-SB",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10)),
                                  ),
                                ),
                                Container(
                                  child: Container(
                                    child: Text("Rp 120,000",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
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
                  margin: EdgeInsets.only(top:12, bottom: MediaQuery.of(context).size.height * 0.25),
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
                                child: Text("Total dana untuk penempatan ini sebesar(setelah ditambah biaya)",
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
                                    child: Text("Rp 1.120.000",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                )
                              ],
                            )),
                        Container(
                          child: Row(
                          children: <Widget>[
                            Container(
                              child: Container(
                                margin: EdgeInsets.only(top: 14),
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
                                    child: Text("0000000000000000 VA BNI",
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 12, bottom: 16, left: 18, right: 18),
                  child: GestureDetector(
                    onTap: () {
                      // _showDialog();
                      _onClick();
                    },
                    child: Container(
                        decoration: new BoxDecoration(
                        color: Color(0xff068675),
                        border: Border.all(color: Color(0xff068675)),
                        borderRadius: BorderRadius.circular(8.0)),
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                        child: Text("BUKA SIMPANAN BERJANGKA", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),),
                  ),
                ),
                  Container(
                  color: Colors.white,
                  margin: EdgeInsets.only( bottom: 16, left: 18, right: 18),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SbmaxNominalPage()));
                    },
                    child: Container(
                        decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xff068675)),
                        borderRadius: BorderRadius.circular(8.0)),
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                        child: Text("UBAH RENCANA INI", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff096d5c)),),),
                  ),
                ),
              ],
            )
        )
      ],
    );
  }

  
}
