import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_base/main.dart';
import 'package:flutter_base/onboarding.dart';
import 'package:flutter_base/ui/user_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter_base/ui_bloc/login/login_main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

//void main() => runApp(MaterialApp(
//               home: SplashScreen()
//               ));

List<CameraDescription> cameras;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   FlutterStatusbarcolor.setStatusBarColor(Color(0xff068675));
//   runApp(MaterialApp(
//       theme: ThemeData(
//           textTheme: TextTheme(title: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
//           primaryColor: Color(0xff27a08b),
//           accentColor: Color(0xff27a08b),
//           primaryColorDark: Color(0xff27a08b),
//           primaryColorLight: Color(0xff27a08b),
//           fontFamily: 'NeoSansW1g'),
//       home: Main()));
// }

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _cek = null, token =null;
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: new SvgPicture.asset(
          'assets/svg/ic-splash-koin.svg',
          width: 160,
          height: 65,
        ),
      )),
    );
  }


  startSplashScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _cek = prefs.getString("loginStatus");
      // _cek = "done"; 
      token = prefs.getString("token");
      print("tes $_cek");

      if(_cek == null && token == null){
        var duration = const Duration(seconds: 3);
        return Timer(duration, () {
            Navigator.of(context).pop();
          
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => Onboarding()
            )); 
        });  
      }
      else{
         Navigator.of(context).pop();        
         Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_){
                        return LoginMain();
                      }
                  )
                );
      }
      // var duration = const Duration(seconds: 3);
      // return Timer(duration, () {
      //   _cek == null || _cek.isEmpty ?  
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
      //       builder: (_) => OnboardingPage()
      //     )) :
      //     Navigator.of(context).pushReplacement(
      //             MaterialPageRoute(
      //                 builder: (_){
      //                   return LoginMain();
      //                 }
      //             )
      //           );
      // });  
    });

    
    
  }
}
