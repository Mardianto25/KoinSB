// import 'package:flutter/material.dart';

// import 'package:bloc/bloc.dart';
// import 'package:flutter_base/bloc/auth/auth_bloc.dart';
// import 'package:flutter_base/bloc/auth/auth_event.dart';
// import 'package:flutter_base/bloc/auth/auth_state.dart';
// import 'package:flutter_base/bloc/pin_email/pin_email_event.dart';
// import 'package:flutter_base/bloc/pin_email/pin_email_state.dart';
// import 'package:flutter_base/bloc/pin_email/pin_email_success_bloc.dart';
// import 'package:flutter_base/bloc/register/register_bloc.dart';
// import 'package:flutter_base/bloc/upload_ktp/upload_ktp_event.dart';
// import 'package:flutter_base/bloc/upload_ktp/upload_ktp_handle_bloc.dart';
// import 'package:flutter_base/bloc/upload_ktp/upload_ktp_state.dart';
// import 'package:flutter_base/email.dart';
// import 'package:flutter_base/member_data.dart';
// import 'package:flutter_base/repository/user/user_repository.dart';
// import 'package:flutter_base/ui/login_indicator.dart';
// import 'package:flutter_base/ui_bloc/login/login_page.dart';
// import 'package:flutter_base/ui_bloc/phone_otp/phone_otp_main.dart';
// import 'package:flutter_base/ui_bloc/pin_email/pin_email_page.dart';
// import 'package:flutter_base/ui_bloc/register/register_page.dart';
// import 'package:flutter_base/ui_bloc/upload_ktp/upload_ktp_page.dart';
// import 'package:flutter_base/verifikasi_thankyou_registration.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SimpleBlocDelegate extends BlocDelegate {
//   @override
//   void onEvent(Bloc bloc, Object event) {
//     super.onEvent(bloc, event);
//     print(event);
//   }

//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     print(transition);
//   }

//   @override
//   void onError(Bloc bloc, Object error, StackTrace stacktrace) {
//     super.onError(bloc, error, stacktrace);
//     print(error);
//   }
// }


// class UploadKtpMain extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => new _UploadKtpMainState();
// }

// class _UploadKtpMainState extends State<UploadKtpMain> {
  
//   final userRepository = UserRepository();

//   void initState() {
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           color: Colors.black,
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => MemberData()
//             ));
//             // Navigator.of(context).pop();
         
//           }
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         title: Text("Upload KTP dan Selfie",
//             style: Theme.of(context).textTheme.title),
//       ),
//      body:  BlocProvider<UploadKtpHandleBloc>(
//         create: (context) {
//           return UploadKtpHandleBloc(userRepository: userRepository)
//           ..add(UploadKtpStarted());
//         },
//         child: UploadKtpWidget(userRepository: userRepository),
//       )
//     );
//   }

// }

// class UploadKtpWidget extends StatelessWidget {
//   final UserRepository userRepository;

//   UploadKtpWidget({Key key, @required this.userRepository}) : super(key: key);

//  @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BlocBuilder<UploadKtpHandleBloc, UploadKtpState>(
//         builder: (context, state) {
//           if (state is UploadKtpUninitialized) {
//             // return LoadingIndicator();
//             return UploadKtpPage(userRepository: userRepository);
            
//           }
//           if (state is UploadKtpAuthenticated) {
//             print("success");
            
//             return UploadKtpPage(userRepository: userRepository);
//           }
//           if (state is UploadKtpUnauthenticated) {
//             print("error");
//             return UploadKtpPage(userRepository: userRepository);
//           }
//           if (state is UploadKtpLoading) {
//             return LoadingIndicator();
//           }
//         },
//       ),
//     );
//   }
  
// }