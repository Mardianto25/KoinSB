import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_bloc.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_state.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_success_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/phone_otp/phone_otp_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_view/pin_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/async.dart';
class PinEmailForm extends StatefulWidget {

  final String email;
  
  
  PinEmailForm({Key key, @required this.email}) : super(key: key);

  @override
  State<PinEmailForm> createState() => _PinEmailFormState();

}

class _PinEmailFormState extends State<PinEmailForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _user = UserRepository();
  bool _loading = false;
  String _warna="" ,_no_ktp, _email, _imei, _pin;
  Timer _timer;
  int _current = 60, _start=60, _otp_id;
  String cekResend ="";

  @override
  void initState() {  
    super.initState();
      _getEmail();
      startTimer2(); 
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _no_ktp = prefs.getString('ktp');
    _email = prefs.getString('email');
    _imei = prefs.getString('imei');
    _otp_id = prefs.getInt('otpIdEmail');
    
  }

  
  
  @override
  Widget build(BuildContext context) {
    _onPinEmailButtonPressed() {
      BlocProvider.of<PinEmailBloc>(context).add(
        PinEmailButtonPressed(
          email: _email,
          ktp: _no_ktp,
          imei: _imei,
          otpCode: _pin,
          otpId: _otp_id
        ),
      );
    }


    return BlocListener<PinEmailBloc, PinEmailState>(
      listener: (context, state) {
        if (state is PinEmailLoading){
          success2();
        }
        if (state is PinEmailFailure) {
          
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
        if (state is PinEmailInitial) {
          if(cekResend == ""){
            var timer = Timer(Duration(seconds: 1), () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_){
                    return PhoneOtpPage();
                  }
              ));
            });
          }else{
            null;
          }
          
        }
       
      },
      child: BlocBuilder<PinEmailBloc, PinEmailState>(
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
                                _warna.isEmpty?"00."+_start.toString():"00.00",
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
                                // _user.emailOtp(_email, _no_ktp, _imei); 
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
}
