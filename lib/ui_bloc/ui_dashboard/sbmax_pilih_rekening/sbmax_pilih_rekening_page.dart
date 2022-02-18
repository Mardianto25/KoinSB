import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/sbmax/list_rekening/list_rekening_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pin/sbmax_pin_bloc.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_nominal/sbmax_nominal_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_pilih_rekening/sbmax_pilih_rekening_form.dart';
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


class SbmaxPilihRekeningPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  List<DataSimulasi> list;  
  
  SbmaxPilihRekeningPage({Key key, @required this.list}) : super(key: key);

  // SbmaxPilihRekeningPage({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          elevation: 0.0,
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
          backgroundColor: Colors.white,
          title: Text("Pilih Rekening Koin",
              style: Theme.of(context).textTheme.title),
        ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ListRekeningBloc(
                userRepository: userRepository,
              );
            },
          ),
         
        ],
        child: SbmaxPilihRekeningForm(list: list,),
        
      ),
    );
  }
}
