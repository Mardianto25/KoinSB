import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_bloc.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_state.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_success_bloc.dart';
import 'package:flutter_base/bloc/verify_email/verify_email_bloc.dart';
import 'package:flutter_base/bloc/verify_email/verify_email_event.dart';
import 'package:flutter_base/bloc/verify_email/verify_email_state.dart';
import 'package:flutter_base/dashboard/main.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/phone_otp/phone_otp_page.dart';
import 'package:flutter_base/ui_bloc/profile/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_view/pin_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/async.dart';

class VerifyEmailForm extends StatefulWidget {
  final String email;
  final int otpId;
  
  VerifyEmailForm({Key key, @required this.email, @required this.otpId}) : super(key: key);


  @override
  State<VerifyEmailForm> createState() => _VerifyEmailFormState();

}

class _VerifyEmailFormState extends State<VerifyEmailForm> {
  final _user = UserRepository();
  bool _loading = false;
  String _warna="", _pin, _token;
  Timer _timer;
  int _current = 60, _start=60, _otp_id;

  @override
  void initState() {  
    super.initState();
    _getToken();
    startTimer2();
  }

  void _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    _onPinEmailButtonPressed() {
      BlocProvider.of<VerifyEmailBloc>(context).add(
        VerifyEmailButtonPressed(
          email: widget.email,
          otpCode: _pin,
          otpId: widget.otpId
        ),
      );
    }


    return BlocListener<VerifyEmailBloc, VerifyEmailState>(
      listener: (context, state) {
        if (state is VerifyEmailLoading){
          setState(() {
            _loading = true;         
          });
        }
        if (state is VerifyEmailFailure) {
          setState(() {
            _loading = false;          
          });
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is VerifyEmailInitial) {
          setState(() {
            _loading = false;
          });
          _success();
                    // BlocProvider.of<PinEmailSuccessBloc>(context).add(PinEmailSuccess());
          
        }
       
      },
      child: BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
        builder: (context, state) {
          return _loading ? Center(child: CircularProgressIndicator(),) : Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child:Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset("assets/svg/ic-verifikasi-email.svg"),
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
                                  "6-digit kode verifikasi OTP telah dikirimkan ke alamat ",
                                  style: CustomText.regular13,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "email ",
                                  style: CustomText.regular13,
                                ),
                                Text(
                                  widget.email,
                                  style: CustomText.bold13,
                                ),
                                GestureDetector(
                                  child: Text(
                                    "   Ganti Alamat Email",
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
                                  enabled: true,
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
                                    if(pin.length >= 6){
                                      state is! PinEmailLoading ? _onPinEmailButtonPressed() : Container( child: Text(""),);                                  
                                    }else{
                                      
                                    }
                                  } 
                              )
                          ),
                          Expanded(
                              child: Text(
                               _warna.isEmpty? "00."+_start.toString():"00.00",
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
                                // _user.sentEmail(widget.email,_token);  
                                _onPinEmailButtonPressed();                         
                              });
                              
                            },
                            child: Opacity(
                              opacity: _warna.isEmpty ? 0.5:1,
                              child: Text(
                                "Kirim ulang OTP",
                                style: _warna.isEmpty? CustomText.regular12: CustomText.bold12Black,
                              ),
                            ),

                          )

                        ],
                      ),
                      // Container(
                      //   child: state is PinEmailLoading
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

  void _success() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Ubah Email Success "),
          
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_){
                        return Main();
                      }
                  ));
              },
            )
          ],
        );
      },
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
              child:!_loading ? CircularProgressIndicator() : Navigator.of(context).pop(),
            ),
          )
        ),
    ) ??
    false;
  }
}
