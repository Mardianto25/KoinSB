import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/email_otp/email_event.dart';

import 'package:flutter_base/bloc/sbmax/sbmax_nominal/sbmax_nominal_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_nominal/sbmax_nominal_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_nominal/sbmax_nominal_state.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pin/sbmax_pin_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pin/sbmax_pin_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pin/sbmax_pin_state.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_choose_bill.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_rekening_coin.dart';
import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_pilih_rekening/sbmax_pilih_rekening_page.dart';
import 'package:flutter_base/util/currency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_view/pin_code_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SbmaxPinForm extends StatefulWidget {
  List<DataSimulasi> list;  
  
  SbmaxPinForm({Key key, @required this.list}) : super(key: key);

  @override
  State<SbmaxPinForm> createState() => _SbmaxPinFormState();
}

class _SbmaxPinFormState extends State<SbmaxPinForm> {
  final _nominalController = TextEditingController();
  ScrollController _scrollContainer = ScrollController();

  bool _enable = false;
  String _imei, _pin ,_anggota ="";
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final money = NumberFormat("#,##0","en_US");
  bool _visible = true;
  bool _loading = true;
  String _platformImei = 'Unknown';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();
  List<DataSimulasi> list = List();

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
  }

  void getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();    
    _imei = prefs.getString('imei');    
  }


  @override
  Widget build(BuildContext context) {
    
    _onSubmited() {
      BlocProvider.of<SbmaxPinBloc>(context).add(
        SubmittedPin(
          imei: _imei,
          pin: _pin
        ),
      );
    }

    return BlocListener<SbmaxPinBloc, SbmaxPinState>(
      listener: (context, state) {
        if (state is SbmaxPinLoading){
          success2();
        }
        if (state is SbmaxPinFailure) {
          Navigator.pop(context);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is SbmaxPinInitial) {
          Navigator.pop(context);
          Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SbmaxPilihRekeningPage(list: widget.list,)));
        }
       
      },
      child: BlocBuilder<SbmaxPinBloc, SbmaxPinState>(
        builder: (context, state) {
          return Container(
          height: MediaQuery.of(context).size.height,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          child: PinCode(
            keyTextStyle: TextStyle(color: Colors.black, fontSize: 24),
            backgroundColor: Colors.white,
            codeTextStyle: TextStyle(color: Colors.black, fontSize: 24),
            title: Text(
              "PIN Transaksi",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            
            subTitle: Text(
              "Masukan PIN Transaksi yang digunakan sebagai \nsecurity code setiap transaksi yang akan dilakukan",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            codeLength: 6,
            obscurePin: true,
            correctPin: "250597",
            onCodeSuccess: (code) {
              print(code);
              setState(() {
                _pin=code;   
                _onSubmited();       
              });
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => SBMaxChooseBill()));
            },
            onCodeFail: (code) {
              print(code); 
              setState(() {
                _pin=code;   
                _onSubmited();       
              });
            }, 
          )
        );
        },
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
