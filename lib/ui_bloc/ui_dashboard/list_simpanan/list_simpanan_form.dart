import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/email_otp/email_event.dart';
import 'package:flutter_base/bloc/sbmax/list_rekening/list_rekening_bloc.dart';
import 'package:flutter_base/bloc/sbmax/list_rekening/list_rekening_event.dart';
import 'package:flutter_base/bloc/sbmax/list_rekening/list_rekening_state.dart';
import 'package:flutter_base/bloc/sbmax/list_simpanan/list_simpanan_bloc.dart';
import 'package:flutter_base/bloc/sbmax/list_simpanan/list_simpanan_event.dart';
import 'package:flutter_base/bloc/sbmax/list_simpanan/list_simpanan_state.dart';

import 'package:flutter_base/dashboard/sbmax/sbmax_rekening_coin.dart';
import 'package:flutter_base/model/response/list_rekening.dart';
import 'package:flutter_base/model/response/list_simpanan.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_detail/sbmax_detail_page.dart';
import 'package:flutter_base/util/currency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_view/pin_code_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ListSimpananForm extends StatefulWidget {
  @override
  State<ListSimpananForm> createState() => _ListSimpananFormState();
}

class _ListSimpananFormState extends State<ListSimpananForm> {
  final _nominalController = TextEditingController();
  ScrollController _scrollContainer = ScrollController();
  List<String> _tabs = ["Aktif", "Sudah Selesai"];

  bool _enable = false;
  String _imei, _pin ,_anggota ="";
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final money = NumberFormat("#,##0","en_US");
  
  final format = DateFormat("yyyy-MM-dd");
  // DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
  bool _visible = true;
  bool _loading = true;
  String _platformImei = 'Unknown';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();
  // List<DataRekening> list = List();
  List<DataSimpanan> list = List();

  Future<void> initPlatformState() async {
    String platformImei;
    try {
      platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
    } on PlatformException {
      platformImei = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformImei = platformImei;
    });
  }

  @override
  void initState() {
    super.initState();
    // initPlatformState();
    getStatus();
    _onSubmited();
  }

  void getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();    
    _imei = prefs.getString('imei');    
  }

  _onSubmited() {
      BlocProvider.of<ListSimpananBloc>(context).add(
        SubmittedListSimpanan(
        ),
      );
    }


  @override
  Widget build(BuildContext context) {
    return BlocListener<ListSimpananBloc, ListSimpananState>(
      listener: (context, state) {
        if (state is ListSimpananLoading){
          // success2();
        }
        if (state is ListSimpananFailure) {
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
        if (state is ListSimpananInitial) {
          
          list.addAll(state.listSimpanan.response.data);
          
          // setState(() {
          //   _loading = false;         
          // });
        }
       
      },
      child: BlocBuilder<ListSimpananBloc, ListSimpananState>(
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            body: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0.0,
                bottom: PreferredSize(
                  child: Container(
                    margin: EdgeInsets.only(left: 16),
                    alignment: Alignment.topLeft,
                    child: TabBar(
                      labelColor: Colors.black,
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff068675),
                          ),
                          insets: EdgeInsets.only(left: 0, right: 13, bottom: 0)),
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(left: 0, right: 0),
                      tabs: _tabs
                          .map((label) => Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: Tab(text: "$label"),
                      ))
                          .toList(),
                    ),
                  ),
                  preferredSize: const Size.fromHeight(48.0),
                ),
                title: Text('Daftar Simpanan',
                    style: Theme.of(context).textTheme.title),
              ),
            body: TabBarView(
              children: [
                //aktif
                Container(
                  padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Column(
                    children: <Widget>[_savingListBox()],
                  ),
                ),
                //sudah selesai
                Container(
                  padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Column(
                    children: <Widget>[_savingListBox()],
                  ),
                )
              ],
            ),
          ),
        ));
        },
      ),
    );
  }

  Widget _savingListBox() {
    return Expanded(
      child: ListView.builder(
          controller: _scrollContainer,
          itemCount: list.length,
          itemBuilder: (context, index){
            return _buildCell(context, index);
          },
        ),
      );
  }

  Widget _buildCell(BuildContext context, i) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => SbmaxDetailPage(noac: list[i].noac,)
        ));
      },
      child: Container(
          margin: EdgeInsets.only(top: 16.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Image.asset("assets/images/ic_sbmax_white.png"),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: Text(
                          list[i].productName,
                          style: CustomText.regular14White,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.teal),
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(10.0),
                        bottomRight: const Radius.circular(10.0))),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Nominal",
                              style: CustomText.medium12Teal,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Rp. ${money.format(list[i].nominal)}",
                              style: CustomText.medium11,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Jatuh Tempo",
                              style: CustomText.medium12Teal,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              list[i].tglJthTempo == null ?"00/00/0000" : list[i].tglJthTempo,
                              style: CustomText.medium11,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "No.Simpanan",
                              style: CustomText.medium12Teal,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              list[i].noac,
                              style: CustomText.medium11,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }

  success2(){
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
