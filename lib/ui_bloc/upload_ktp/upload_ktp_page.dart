import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/upload_ktp/upload_ktp_bloc.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/upload_ktp/upload_ktp_form.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}


class UploadKtpPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  // UploadKtpPage({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => MemberData()
        ));
      },
      child: Scaffold(
        // resizeToAvoidBottomPadding: false,
         appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
              
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => MemberData()
              ));
           
            }
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("Upload KTP dan Selfie",
              style: Theme.of(context).textTheme.title),
        ),
        body: BlocProvider(
          create: (context) {
            return UploadKtpBloc(
              userRepository: userRepository,
            );
          },
          child: UploadKtpForm(),
        ),
      ),
    );
  }
}
