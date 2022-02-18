import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_inisiasi/sbmax_inisiasi_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail/sbmax_simulasi_detail_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail_non/sbmax_simulasi_detail_non_bloc.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_detail/sbmax_detail_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_simulasi_detail/sbmax_simulasi_detail_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_simulasi_detail_non/sbmax_simulasi_detail_non_form.dart';

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


class SbmaxSimulasiDetailNonPage extends StatelessWidget {

  final UserRepository userRepository = UserRepository();

  String noac;
  List<DataSimulasi> list ;

  SbmaxSimulasiDetailNonPage({Key key, @required this.noac, @required this.list}) : super(key: key);

  // SbmaxPilihRekeningPage({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff068675),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return SbmaxSimulasiDetailNonBloc(
                userRepository: userRepository,
              );
            },
          ),
         BlocProvider(
            create: (context) {
              return SbmaxInisiasiBloc(
                userRepository: userRepository,
              );
            },
          ),
        ],
        child: SbmaxSimulasiDetailNonForm(noac:noac,list: list,),
        
      ),
    );
  }
}
