import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_bloc.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_event.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_state.dart';
import 'package:flutter_base/dashboard/main.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/success_piko.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/login/login_main.dart';
import 'package:flutter_base/ui_bloc/set_password/set_password_page.dart';
import 'package:flutter_base/verifikasi_thankyou.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_view/pin_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quiver/async.dart';

class PinPhoneForm extends StatefulWidget {
  final String phone;

  PinPhoneForm({Key key, @required this.phone}) : super(key: key);
  @override
  State<PinPhoneForm> createState() => _PinPhoneFormState();

}

class _PinPhoneFormState extends State<PinPhoneForm> {
  final _user = UserRepository();
  String _warna="", _no_ktp, _phone, _imei, _pin;
  Timer _timer;
  int _current = 60, _start=60, _otp_id;
  bool _loading = false;
  String cekResend ="";

  @override
  void initState() {  
    super.initState();
      _getEmail();
    startTimer2();
  }


  void getDataLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loginStatus", null);    
    // prefs.remove("pikoStatus");
  }

  setDataMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loginStatus", "done");
    prefs.remove("pikoStatus");
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _no_ktp = prefs.getString('ktp');
    _phone = prefs.getString('phonenumber');
    _imei = prefs.getString('imei');
    _otp_id = prefs.getInt('otpIdPhone');
    
    print(_phone);
  }

  
  
  @override
  Widget build(BuildContext context) {
    _onPinPhoneButtonPressed() {
      BlocProvider.of<PinPhoneBloc>(context).add(
        PinPhoneButtonPressed(
          phone: _phone,
          ktp: _no_ktp,
          imei: _imei,
          otpCode: _pin,
          otpId : _otp_id
        ),
      );
    }


    return BlocListener<PinPhoneBloc, PinPhoneState>(
      listener: (context, state) {
        if (state is PinPhoneLoading){
          success2();
        }
        if (state is PinPhoneFailure) {

          var timer = Timer(Duration(seconds: 1), () {
            Navigator.pop(context);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
        if (state is PinPhoneInitial) {
          if(cekResend ==""){
            var timer = Timer(Duration(seconds: 1), () {
              Navigator.pop(context);
              Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_){
                    return VerifikasiThankyou();
                  }
              ));
            });

          }else{
            null;
          }
          
        }
        if (state is PinPhonePikoInitial) {
          setState(() {
            setDataMember();                     
          });

          if(cekResend ==""){
            var timer = Timer(Duration(seconds: 1), () {
              Navigator.pop(context);
              Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_){
                    return SuccessPiko();
                  }
              ));
            });

          }else{
            null;
          }
            
          // success2();
          
          
        }
        if (state is PinPhonePikoFailure) {
          // success2();
          var timer = Timer(Duration(seconds: 1), () {
            Navigator.pop(context);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
      },
      child: BlocBuilder<PinPhoneBloc, PinPhoneState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child:Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset("assets/svg/ic-verifikasi-ponsel.svg"),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 28),
                        child: Text(
                          "Kode verifikasi OTP sudah di kirim",
                          style: CustomText.bold18,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 16),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "6-digit kode verifikasi OTP telah dikirimkan ke nomer ",
                                  style: CustomText.regular13,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                // Text(
                                //   "email ",
                                //   style: CustomText.regular13,
                                // ),
                                Text(
                                  widget.phone,
                                  style: CustomText.bold13,
                                ),
                                GestureDetector(
                                  child: Text(
                                    "   Ganti Nomer Ponsel",
                                    style: CustomText.regular13Primary,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            )
                          ],
                        )
                      ),

                      Row(
                        children: <Widget>[
                          Expanded(
                              child: PinView (
                                  count: 6,
                                  autoFocusFirstField: true,
                                  enabled: true, // this makes fields not focusable
                                  dashPositions: [2,4], // this makes fields not focusable
                                  margin: EdgeInsets.all(2.5), // margin between the fields
                                  style: TextStyle (
                                    // style for the fields
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                  dashStyle: TextStyle (
                                    // dash style
                                    fontSize: 25.0,
                                    color: Colors.grey
                                  ),
                                  submit:(String pin){
                                    _pin=pin;
                                    if(pin.length < 6){
                                      return null;
                                    }else{
                                      // state is! PinPhoneAuthLoading? _onPinPhoneButtonPressed() : Container( child: Text(""),);                                  
                                      _onPinPhoneButtonPressed();     
                                      // Navigator.of(context).push(
                                      // MaterialPageRoute(
                                      //     builder: (_){
                                      //       return SetPasswordPage();
                                      //     }
                                      // ));                             
                                    }
                                  } 
                              )
                          ),
                          Expanded(
                              child: Text(
                                _warna.isEmpty ? "00."+_start.toString(): "00.00",
                                style: CustomText.regular12,
                              )
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _warna="";
                                _start=60;
                                _current=60;  
                                startTimer2();
                                cekResend ="resend";
                                // _user.phoneOtp(_phone, _no_ktp, _imei);    
                                _onPinPhoneButtonPressed();                     
                              });
                            },
                            child: Opacity(
                              opacity: _warna.isEmpty ? 0.5:1,
                              child: Text(
                                "Kirim ulang OTP",
                                style:_warna.isEmpty ? CustomText.regular12: CustomText.bold12Black,
                              ),
                            ),

                          )

                        ],
                      ),
                      // Container(
                      //   child: state is PinPhoneLoading
                      //       ? CircularProgressIndicator()
                      //       : null,
                      // ),

                    ],
                  ),

                )
            ),
          );
        },
      ),
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
          title: Text("Berhasil", style: TextStyle(fontSize: 14),),
          content: Container(
            child: Text("Akun piko anda sudah terdaftar di aplikasi koin, silahkan login kembali", style: TextStyle(fontSize: 13),),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_){
                        return LoginMain();
                      }
                  ));
              },
            )
          ],
        );
      },
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



  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            _warna="success";
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void startTimer2() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _current),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { 
        _start = _current - duration.elapsed.inSeconds; 
      });
    });

    sub.onDone(() {
      setState(() {
        _warna="success";     
      });
      sub.cancel();
    });
  }
}
