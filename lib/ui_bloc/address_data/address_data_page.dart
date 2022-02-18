import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/address_data/address_data_bloc.dart';
import 'package:flutter_base/bloc/address_data/get_address_data_bloc.dart';
import 'package:flutter_base/bloc/address_data/second_address_data_bloc.dart';
import 'package:flutter_base/bloc/general_get/general_get_bloc.dart';
import 'package:flutter_base/bloc/general_get/general_get_param_bloc.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/address_data/address_data_form.dart';
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


class AddressDataPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  String type;
  AddressDataPage({Key key, @required this.type}) : super(key: key);

  // AddressDataPage({Key key, @required this.userRepository})
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
        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
               if(type == "address"){
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
            
              }
            ),
          elevation: 0.0,
          title: Text("Data Alamat",
              style: Theme.of(context).textTheme.title),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) {
                return SecondAddressDataBloc(
                  userRepository: userRepository,
                );
              },
            ),
            BlocProvider(
              create: (context) {
                return GetAddressDataBloc(
                  userRepository: userRepository,
                );
              },
            ),
            BlocProvider(
              create: (context) {
                return AddressDataBloc(
                  userRepository: userRepository,
                );
              },
            ),
            BlocProvider(
              create: (context) {
                return GeneralGetParamBloc(
                  userRepository: userRepository,
                );
              },
            ),
          ],
          child: AddressDataForm(type: type),
          
        ),
      ),
    );
  }
}
