import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/email_otp/email_event.dart';
import 'package:flutter_base/bloc/sbmax/list_rekening/list_rekening_bloc.dart';
import 'package:flutter_base/bloc/sbmax/list_rekening/list_rekening_event.dart';
import 'package:flutter_base/bloc/sbmax/list_rekening/list_rekening_state.dart';

import 'package:flutter_base/dashboard/sbmax/sbmax_rekening_coin.dart';
import 'package:flutter_base/model/response/list_rekening.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/util/currency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_view/pin_code_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SbmaxPilihRekeningForm extends StatefulWidget {
  List<DataSimulasi> list;  
  
  SbmaxPilihRekeningForm({Key key, @required this.list}) : super(key: key);
  @override
  State<SbmaxPilihRekeningForm> createState() => _SbmaxPilihRekeningFormState();
}

class _SbmaxPilihRekeningFormState extends State<SbmaxPilihRekeningForm> {
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
  // List<DataRekening> list = List();
  ListRekening list;

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
      BlocProvider.of<ListRekeningBloc>(context).add(
        SubmittedListRekening(
        ),
      );
    }


  @override
  Widget build(BuildContext context) {
    
    

    return BlocListener<ListRekeningBloc, ListRekeningState>(
      listener: (context, state) {
        if (state is ListRekeningLoading){
          success2();
        }
        if (state is ListRekeningFailure) {
          Navigator.pop(context);
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
        if (state is ListRekeningInitial) {
          Navigator.pop(context);          
          setState(() {
            list = state.listRekening; 
            _loading = false;         
          });
        }
       
      },
      child: BlocBuilder<ListRekeningBloc, ListRekeningState>(
        builder: (context, state) {
          return _loading == true ? Center(child: CircularProgressIndicator(),) : Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: 
              Container(
                height: MediaQuery.of(context).size.height * 1,
                padding: EdgeInsets.only(top: 5, bottom: 10, left: 16, right: 16),
                color: Colors.white,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        // Navigator.pop(context);
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SBMaxRekeningCoin(noac: list.response.data.noac, nominal: list.response.data.nominal, list: widget.list,)));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color:Color(0xff27a08b))
                        ),
                        padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
                        margin: EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: SvgPicture.asset("assets/svg/dashboard/ai-svg/ic-dashboard-active.svg"),
                            ),
                            Container(
                              child: Text(
                                list.response.data.noac,
                                style: CustomText.regular12,
                              ),
                            ),
                            Container(
                              child: Text(
                                "Rp. ${list.response.data.nominal}",
                                style: CustomText.bold14,
                              ),
                            )
                            
                          ],
                        ),
                      ),
                    )
                    ],
                  ),
              ),
            )
          ],
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
