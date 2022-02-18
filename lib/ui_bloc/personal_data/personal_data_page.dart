import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/general_get/general_get_bloc.dart';
import 'package:flutter_base/bloc/personal_data/get_personal_data_bloc.dart';
import 'package:flutter_base/bloc/personal_data/personal_data_bloc.dart';
import 'package:flutter_base/bloc/pin_email/pin_email_bloc.dart';
import 'package:flutter_base/bloc/pin_phonenumber/pin_phone_bloc.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/personal_data/personal_data_form.dart';
import 'package:flutter_base/ui_bloc/pin_email/pin_email_form.dart';
import 'package:flutter_base/ui_bloc/pin_phone/pin_phone_form.dart';
import 'package:flutter_base/ui_bloc/show_data/show_data_page.dart';

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


class PersonalDataPage extends StatelessWidget {
  final UserRepository userRepository=UserRepository();
  String type;

  PersonalDataPage({Key key, @required this.type}) : super(key: key);

  // PersonalDataPage({Key key, @required this.userRepository})
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
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                if(type == "data_personal"){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ShowDataPage()
                  ));
                }else{
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MemberData()
                  ));
                }
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) => MemberData()
                // ));
                
            
              }
            ),
          elevation: 0.0,
          title: Text("Informasi Pribadi",
              style: Theme.of(context).textTheme.title),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) {
                return GetPersonalDataBloc(
                  userRepository: userRepository,
                );
              },
            ),
            BlocProvider(
              create: (context) {
                return PersonalDataBloc(
                  userRepository: userRepository,
                );
              },
            ),
            BlocProvider(
              create: (context) {
                return GeneralGetBloc(
                  userRepository: userRepository,
                );
              },
            ),
            
          ],
          child: PersonalDataForm(type: type,),
          
        )
      ),
    );
  }
}
