import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pin/sbmax_pin_bloc.dart';
import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_nominal/sbmax_nominal_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_pin/sbmax_pin_form.dart';

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


class SbmaxPinPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  List<DataSimulasi> list;
  
  SbmaxPinPage({Key key, @required this.list}) : super(key: key);


  // SbmaxPinPage({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (contex) => Welcome() 
              // ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return SbmaxPinBloc(
                userRepository: userRepository,
              );
            },
          ),
         
        ],
        child: SbmaxPinForm(list: list,),
        
      ),
    );
  }
}
