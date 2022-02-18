import 'package:flutter/material.dart';

import 'package:flutter_base/bloc/register/register_bloc.dart';
import 'package:flutter_base/bloc/register/register_event.dart';
import 'package:flutter_base/bloc/register/register_handle_bloc.dart';
import 'package:flutter_base/bloc/register/register_state.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/success_piko.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui/login_widget.dart';
import 'package:flutter_base/ui_bloc/email_otp/email_page.dart';
import 'package:flutter_base/ui_bloc/login/login_main.dart';
import 'package:flutter_base/ui_bloc/login/login_page.dart';
import 'package:flutter_base/ui_bloc/phone_otp/phone_otp_page.dart';
import 'package:flutter_base/ui_bloc/pin_email/pin_email_page.dart';
import 'package:flutter_base/ui_bloc/pin_phone/pin_phone_page.dart';
import 'package:flutter_base/ui_bloc/referral/referral_form.dart';
import 'package:flutter_base/ui_bloc/referral/referral_page.dart';
import 'package:flutter_base/ui_bloc/rekening_coin/rekening_coin_page.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/verifikasi_thankyou_registration.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _ktpController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final FocusNode _ktpFocus = FocusNode();
  final FocusNode _firstFocus = FocusNode();
  final FocusNode _lastFocus = FocusNode();
  var playerId;
  bool passwordVisible = true;
  bool _enable = false;
  bool _loading =false;
  bool _autoValidate =false;
  
  RegisterBloc _registerBloc;
  String _platformImei = 'Unknown';
  bool _ktp, _firstName, _lastName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();

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
      print(_platformImei);
    });
  }
  

  @override
  void initState() {
    // 74f351e8-adfa-473a-ad32-c1c2c8421cae
    OneSignal.shared.init(
      "fa074867-9d3f-468b-b0e3-ca63f153e033",
      iOSSettings: {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.inAppLaunchUrl: true
      }
    );
    OneSignal.shared
    .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => LoginMain()
      ));
    });
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    _getDataOneSignal();
    // _initOneSignal();
    super.initState();
    initPlatformState();
  }

  _getDataOneSignal() async{
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    playerId = status.subscriptionStatus.userId;
  }

  void kirim() async {
    print(playerId);
    await OneSignal.shared.postNotification(OSCreateNotification(
      playerIds: [playerId],
      content: "Bismillah Ya Allah",
      heading: "Test Notification",
      buttons: [
        OSActionButton(text: "test1", id: "id1"),
        OSActionButton(text: "test2", id: "id2")
      ]
    ));
  }

   _onRegisterButtonPressed() {
    //  print("tes"+playerId);
      BlocProvider.of<RegisterBloc>(context).add(
        SubmittedRegister(
          ktp: _ktpController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          imei: _platformImei,
          oneSignal: playerId,
          // imei: "866156043273100"
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading){
          success2();
        }
        if (state is RegisterFailure) {
          
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
        // if (state is StatusInitial){
        //   if(state.status.response.data.proses == "verifikasi_ktp"){
        //      Navigator.of(context).push(
        //         MaterialPageRoute(
        //             builder: (_){
        //               return EmailPage();
        //             }
        //         )
        //       );
        //   }
        //   if(state.status.response.data.proses == "verifikasi_email"){
        //      Navigator.of(context).push(
        //         MaterialPageRoute(
        //             builder: (_){
        //               return PhoneOtpPage();
        //             }
        //         )
        //       );
        //   }

        //   if(state.status.response.data.proses == "verifikasi_phonenumber"){
        //      Navigator.of(context).push(
        //         MaterialPageRoute(
        //             builder: (_){
        //               return SetPasswordPage();
        //             }
        //         )
        //       );
        //   }
        // }
        if (state is RegisterInitial) {

          var timer = Timer(Duration(seconds: 1), () {
            if (state.register.response.data == null){
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_){
                      return RekeningCoinPage();
                    }
                )
              );
            }else if(state.register.response.data.pikoStatus == 1){
              Navigator.pop(context);
              
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_){
                      return VerifikasiThankyouRegistration();
                    }
                )
              );

            }
          });
            
          // });
          

          // BlocProvider.of<RegisterHandleBloc>(context).add(RegisterSuccess());
        }
       
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Container(
                      // margin: EdgeInsets.all(32),
                      // alignment: Alignment.bottomCenter,
                      decoration: CustomBoxDecoration.registrationBox,
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Container(
                              //   child: SvgPicture.asset(
                              //     "assets/svg/ic-signup.svg",
                              //   ),
                              // ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text("Ayo! Buat akun", style: CustomText.regular24White,),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(top: 5),
                                child: Text("KoinSB", style: CustomText.regular24White,),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 22),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Nomor e-KTP", style: CustomText.bold14White,),
                                      ],
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      style: CustomText.regular16White,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _ktpFocus,
                                      onFieldSubmitted: (term){
                                      _fieldFocusChange(context, _ktpFocus, _firstFocus);
                                      },
                                      controller: _ktpController,
                                      onChanged: (_){
                                        setState(() {
                                          _enable = false;                                       
                                        });
                                        if(_.length >= 16){
                                          _ktp = true;
                                        }else{
                                          _ktp = false;
                                        }
                                        if(_ktp == true && _firstName == true && _lastName == true){
                                          _enable = !_enable;
                                        }
                                      },
                                      validator:Validator.validateEktp,
                                      decoration: InputDecoration(
                                          hintText: "Cth: 3212345678910002",
                                          hintStyle: CustomText.registrationHint,
                                          enabledBorder: new UnderlineInputBorder(
                                              borderSide: new BorderSide(color: Colors.white)
                                          )
                                      ),
                                    ),
                                   
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 22),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Nama Depan", style: CustomText.bold14White,),
                                      ],
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: CustomText.regular16White,
                                      focusNode: _firstFocus,
                                      onFieldSubmitted: (term){
                                      _fieldFocusChange(context, _firstFocus, _lastFocus);
                                      },
                                      controller: _firstNameController,
                                      onChanged: (_){
                                        setState(() {
                                          _enable = false;                                       
                                        });
                                        if(_.length >= 2){
                                          _firstName = true;
                                        }else{
                                          _firstName = false;
                                        }
                                        if(_ktp == true && _firstName == true && _lastName == true){
                                          _enable = !_enable;
                                        }
                                      },
                                      validator: (_){
                                        if(_.length < 2){
                                          return "Nama depan minimal 5 huruf";
                                        }
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Cth: Dimas",
                                          hintStyle: CustomText.registrationHint,
                                          enabledBorder: new UnderlineInputBorder(
                                              borderSide: new BorderSide(color: Colors.white)
                                          )
                                      ),
                                    ),
                                   
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 22),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Nama Belakang", style: CustomText.bold14White,),
                                      ],
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      style: CustomText.regular16White,
                                      focusNode: _lastFocus,
                                      onFieldSubmitted: (value){
                                        _lastFocus.unfocus();
                                        _saved();
                                      },
                                      controller: _lastNameController,
                                      onChanged: (_){
                                        setState(() {
                                          _enable = false;                                       
                                        });
                                        if(_.length >= 2){
                                          _lastName = true;
                                        }else{
                                          _lastName = false;
                                        }
                                        if(_ktp == true && _firstName == true && _lastName == true){
                                          _enable = !_enable;
                                        }
                                      },
                                      validator: (_) {
                                        if(_.length < 2){
                                          return "Nama belakang minimal 5 huruf";
                                        }
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Cth: Dimas",
                                          hintStyle: CustomText.registrationHint,
                                          enabledBorder: new UnderlineInputBorder(
                                              borderSide: new BorderSide(color: Colors.white)
                                          )
                                      ),
                                    ),
                                   
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  ),
                ),
              ),

              GestureDetector(
                 onTap:() {
                  //  Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //         builder: (_){
                  //           return RekeningCoinPage();
                  //         }
                  //     )
                  //   );
                   _saved();
                  // test();
                  },
                child: Container(
                    color: Color(0xff71ab3c),
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: CustomRegistrationButton("BUAT AKUN", _enable)

                ),
              )
            ],
          ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _ktpController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _saved(){
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
        // kirim();
        _onRegisterButtonPressed();
          
    
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
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
