import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/bloc_login.dart';
import 'package:flutter_base/email.dart';

import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_text.dart';

import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:imei_plugin/imei_plugin.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:flutter_one_signal/flutter_one_signal.dart';


import 'package:flutter/services.dart';

import 'bloc/user_bloc.dart';

enum LoginStatus { NON_LOGIN, LOGGING, LOGIN_SUCCESS, LOGIN_ERROR }

class LoginState {
  final LoginStatus status;
  final String message;
  final bool loadingRequest;

  LoginState({this.status, this.message, this.loadingRequest});
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  var passKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String password;
  bool passwordVisible = true;
  double bottomSheetTopPosition = 50;
  static const String DEFAULT_APP_ID = '74f351e8-adfa-473a-ad32-c1c2c8421cae';  
  
  String _platformImei = 'Unknown';

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

  // @override
  // void didChangeDependencies() {
  //   OneSignal.shared.setNotificationOpenedHandler((result) {
  //     print("hasil open ${result}");
  //     // will be called whenever a notification is opened/button pressed.
  //     Navigator.push(context, MaterialPageRoute(
  //       builder: (context) => Email()
  //     ));

  //     var notify = result.notification.payload.additionalData;
  //     // if (notify["type"] == "message") {
  //     //   Navigator.push(
  //     //     context,
  //     //     MaterialPageRoute(
  //     //       builder: (_) => DM(user: notify['id']),
  //     //     ),
  //     //   );
  //     // }
  //     // if (notify["type"] == "user") {
  //     //   Navigator.push(
  //     //     context,
  //     //     MaterialPageRoute(
  //     //       builder: (_) => Profileo(notify["id"]),
  //     //     ),
  //     //   );
  //     // }
  //     // if (notify["type"] == "post") {
  //     //   Navigator.push(
  //     //     context,
  //     //     MaterialPageRoute(
  //     //       builder: (_) => ViewPost(notify["id"]),
  //     //     ),
  //     //   );
  //     // }
  //   });
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // OneSignal.shared.init(
    //   "74f351e8-adfa-473a-ad32-c1c2c8421cae",
    //   iOSSettings: {
    //     OSiOSSettings.autoPrompt: false,
    //     OSiOSSettings.inAppLaunchUrl: true
    //   }
    // );
    // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    // _initOneSignal(); 
    
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        bottomSheetTopPosition = 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          elevation: 0.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Container(
                color: Colors.white,
                child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: CustomBoxDecoration.registrationBox,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: SvgPicture.asset(
                                "assets/svg/ic-login.svg",
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 34, right: 34, top: 34),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Hi! Selamat Datang",
                                        style: CustomText.regular24White,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Kembali",
                                        style: CustomText.regular24White,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 34, right: 34, top: 22),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Email / Nomor Ponsel",
                                        style: CustomText.regular12White,
                                      ),
                                    ],
                                  ), 
                                  _phone(blocCreate)
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 34, right: 34, top: 22),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Password",
                                        style: CustomText.regular12White,
                                      ),
                                    ],
                                  ),
                                  _password(blocCreate)
                               
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
             StreamBuilder<bool>(
              //  stream: blocCreate.submitValid,
               builder: (context, snapshot) => 
               GestureDetector(
                onTap: () {
                  // _logoutEmail();
                  // _sub();
                  // main();
                  (!snapshot.hasData) ? null :
                  blocCreate.loginSubmit(_platformImei);
                  // main();
                  // if (controller.validate()) {
                  //   blocCreate.postIn.add(LoginModel(
                  //       publicId: "6248fe24-2393-4aae-965a-6cf5fe1c5064",
                  //       imei: _platformImei, 
                  //       phonenumber: blocCreate.phone, 
                  //       password: blocCreate.password
                  //   ));
                  // }
                },
                child: Container(
                    color: Color(0xff71ab3c),
                    padding: EdgeInsets.all(30),
                    child: CustomRegistrationButton("LOGIN", true)),
            ),
          ),
          loadingIndicator(blocCreate),
          // StreamBuilder<LoginState>(
          //   stream: blocCreate.loginStateStream,
          //   builder: (context, AsyncSnapshot<LoginState> snapshot){
          //     if ( !snapshot.hasData )
          //       return Container();

          //     switch(snapshot.data.status){
          //       case LoginStatus.LOGGING:
          //         return _buildLoadingWidget();

          //       case LoginStatus.LOGIN_ERROR:
          //         return _buildErrorWidget(snapshot.data.message);

          //       case LoginStatus.LOGIN_SUCCESS:
          //         // Here you can go to another screen after login success.
          //         // return Center(child: Text("${snapshot.data.message}"),);
          //         return change(context);

          //       case LoginStatus.NON_LOGIN:
          //       default:
          //         return Container();
          //     }
          //   },
          // ),
            
          ],
        ));
  }

  // Widget change(context){
  //   Navigator.of(context).pop();
  //   Navigator.push(context, MaterialPageRoute(
  //     builder: (context) => Email()
  //   ));
  // }

  // void _handleNotificationReceived(OSNotification notification) {
  
  // }

  // void main() {
  //   OneSignal.shared.setNotificationReceivedHandler(_handleNotificationReceived);
  // }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: new Text(
              "username atau password \n anda salah",
              style: CustomText.medium16, textAlign: TextAlign.center
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: '',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 38,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.teal),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3.0,
                          ),
                        ]),
                        child: MaterialButton(
                          child: Text(
                            "OK",
                            style: CustomText.medium14Teal,
                          ),
                        ),
                      )),
                )
              ],
            ));
      },
    );
  }

  Widget _phone(CreateBloc bloc){
    return StreamBuilder(
      stream: bloc.phoneController,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: bloc.updatePhone,
          keyboardType: TextInputType.text,
          style: CustomText.regular16White,
          decoration: InputDecoration(
              hintText: "Cth: dimas@email.com/081234567890",
              hintStyle: CustomText.registrationHint,
              errorText: snapshot.error,
              enabledBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(
                      color: Colors.white))),
        );
      },
    );
  }

  Widget _password(CreateBloc bloc){
    return StreamBuilder(
      stream: bloc.passwordController,
      builder: (context, snapshot) {
        return TextFormField(
          key: passKey,
          keyboardType: TextInputType.text,
          obscureText: passwordVisible,
          style: CustomText.regular16White,
          onChanged: bloc.updatePassword,
          decoration: InputDecoration(
              errorText: snapshot.error,
              hintText: "Cth: Dimas123",
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
                  color: Colors.white,
                ),
              ),
              hintStyle: CustomText.registrationHint,
              enabledBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(
                      color: Colors.white))),
        );
                        
      },
    );
  }

  Widget loadingIndicator(CreateBloc bloc) => StreamBuilder<bool>(
    // stream: bloc.loading,
    builder: (context, snap) {
    return Container(
      child: (snap.hasData && snap.data)
      ? CircularProgressIndicator()
      : null,
      );
    },
  );
  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Loading data from API...", textDirection: TextDirection.ltr), CircularProgressIndicator()
        ],
      ),
    );
  }

  // // Error Widget
  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Loading error data from API...", textDirection: TextDirection.ltr), CircularProgressIndicator()
        ],
      ),
    );
  }
  
}

