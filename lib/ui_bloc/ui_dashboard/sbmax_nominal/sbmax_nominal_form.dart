import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/email_otp/email_event.dart';

import 'package:flutter_base/bloc/sbmax/sbmax_nominal/sbmax_nominal_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_nominal/sbmax_nominal_event.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_nominal/sbmax_nominal_state.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_rekening_coin.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_summary_va.dart';
import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/pin_email/pin_email_page.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_simulasi_detail_non/sbmax_simulasi_detail_non_page.dart';
import 'package:flutter_base/util/currency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SbmaxNominalForm extends StatefulWidget {
  @override
  State<SbmaxNominalForm> createState() => _SbmaxNominalFormState();
}

class _SbmaxNominalFormState extends State<SbmaxNominalForm> {
  final _nominalController = TextEditingController();
  ScrollController _scrollContainer = ScrollController();

  bool _enable = false;
  String _nominal;
  int _anggota;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final money = NumberFormat("#,##0","en_US");
  bool _visible = true;
  bool _loading = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();
  List<DataSimulasi> list = List();


  @override
  void initState() {
    super.initState();
    getAnggota();
  }

  void getAnggota() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _anggota = prefs.getInt("isAnggota");              
    });
        
  }

  @override
  Widget build(BuildContext context) {
    // list=[];
    _onSubmited(int text) {
      BlocProvider.of<SbmaxNominalBloc>(context).add(
        SubmittedNominal(
          nominal: text,
        ),
      );
    }

    return BlocListener<SbmaxNominalBloc, SbmaxNominalState>(
      listener: (context, state) {
        if (state is SbmaxNominalLoading){
          setState(() {
            _loading = false;
          });
          // success2();
        }
        if (state is SbmaxNominalFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            _loading = true;
          });
        }
        if (state is SbmaxNominalInitial) {
          setState(() {
            // List<DataSimulasi> data = state.dataSbmax.data;
            list.clear();
            list.addAll(state.dataSbmax.data);
            _loading = true;
          });
          // Navigator.pop(context);
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => PinEmailPage()
          // ));
        }
       
      },
      child: BlocBuilder<SbmaxNominalBloc, SbmaxNominalState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color:Color(0xff068675),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.all(Radius.circular(12)),

                  ),
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.only(left: 16, right:16),
                  child: TextFormField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly, 
                      CurrencyFormat()
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Masukkan nominal penempatan',
                        enabledBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white)
                        ),
                    ),
                    onChanged: (text){
                      var textNominal = text.replaceAll("Rp ", "");
                      var a = textNominal.replaceAll(",", "");
                      _onSubmited(int.parse(a));
                      setState(() {
                        if(text != ""){
                          _visible = false;
                        }else{
                          _visible = true;                          
                        }
                          // money.format(int.parse(text));
                      });
                    },
                  )
                ),
              ),
              Expanded(
                child: !_loading ? Center(child: CircularProgressIndicator(),) : Stack(
                  children: <Widget>[
                    AnimatedOpacity(
                      opacity: _visible?1.0:0.0,
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset("assets/images/ic_info.png", alignment: Alignment.topCenter,),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Masukkan nominal penempatan untuk melihat rencana Simpanan Berjangka MAX kamu (minimum penempatan dana Rp100.000).",
                                        style: CustomText.regular10,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ),
                    ),
                    Visibility(
                      visible: !_visible,
                      child:list.isEmpty ?
              Center(
                child: Text("No Data", style: TextStyle(color: Colors.red),),
                        ): ListView.builder(
                        controller: _scrollContainer,
                        itemCount: list.length,
                        itemBuilder: (context, index){
                          return _buildCellSearch(context, index);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildCellSearch(BuildContext context, index) {
     return 
     Container(
       // margin: EdgeInsets.only(top: 16),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: (){

                if (_anggota ==0){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => SbmaxSimulasiDetailNonPage(noac: "", list: list,)
                    )
                  );
                } else if(_anggota ==1){
                   Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => SBMaxRekeningCoin(noac: "", nominal: 0, list: list,)
                    )
                  );
                }

                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //         builder: (context) => SBMaxRekeningCoin(noac: "", nominal: 0,list: list,)
                //     )
                //   );
                
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color:Colors.black)
                ),
                padding: EdgeInsets.only(left: 16, top: 13, bottom: 13),
                margin: EdgeInsets.only(left: 16,right: 16, bottom: 12, top:10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text("Selama ${list[index].tenor} Bulan", style: CustomText.bold12),
                    Text("Rp ${money.format(list[index].nominalTotal)}", style: CustomText.bold14),
                    Opacity(
                      opacity: 0.5,
                      child: Text("(termasuk jasa sebesar ${list[index].jasa}% p.a. sejumlah Rp ${money.format(list[index].nominalJasa)})", style: CustomText.regular12),
                    )

                  ],
                ),
              ),
            ),
            

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
