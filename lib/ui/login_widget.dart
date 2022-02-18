
// import 'package:flutter/material.dart';
// import 'package:flutter_base/bloc/user_bloc.dart';
// import 'package:imei_plugin/imei_plugin.dart';
// import 'dart:async';

// import 'package:flutter/services.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _LoginPageState();
//   }

// }

// class _LoginPageState extends State<LoginPage> {
//   String _platformImei = 'Unknown';
  
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   Future<void> initPlatformState() async {
//     String platformImei;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
//     } on PlatformException {
//       platformImei = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _platformImei = platformImei;
//     });
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login"),
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.only(top: 10.0),
//               child: Text("Username"),
//             ),
//             TextFormField(
//               // onChanged: bloc.updatePhone,
//               decoration: InputDecoration(
//                   fillColor: Theme.of(context).primaryColor,
//                   hintText: ''),
//             ),
//             Container(
//               padding: EdgeInsets.only(top: 10.0),
//               child: Text("Password"),
//             ),
//             TextFormField(
//               // onChanged: bloc.updatePassword,
//               obscureText: true,
//               decoration: InputDecoration(
//                   fillColor: Theme.of(context).primaryColor,
//                   hintText: ''),
//             ),

//             RaisedButton(
//               onPressed: () {
//                 // bloc.login(_platformImei);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Running on: $_platformImei\n'),
//             )
//           ],
//         ),
//       ),
//     );
//   }

// }
