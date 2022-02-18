import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/member_data_save/member_data_save_bloc.dart';
import 'package:flutter_base/bloc/referral/referral_bloc.dart';
import 'package:flutter_base/bloc/set_password/set_password_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/member_data_save/member_data_save_form.dart';
import 'package:flutter_base/ui_bloc/referral/referral_form.dart';
import 'package:flutter_base/ui_bloc/set_password/set_password_form.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ReferralPage extends StatelessWidget {
  final UserRepository userRepository =UserRepository();
  final type;  
  
  ReferralPage({Key key, @required this.type}) : super(key: key);
  // SetPasswordPage({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
     
      body: BlocProvider(
        create: (context) {
          return ReferralBloc(
            userRepository: userRepository,
          );
        },
        child: ReferralForm(type: type,),
      ),
    );
  }
}
