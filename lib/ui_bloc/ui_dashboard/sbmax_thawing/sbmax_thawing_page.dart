import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_inisiasi/sbmax_inisiasi_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pencairan/sbmax_pencairan_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_simulasi_detail/sbmax_simulasi_detail_bloc.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_detail/sbmax_detail_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_simulasi_detail/sbmax_simulasi_detail_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_thawing/sbmax_thawing_form.dart';

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


class SbmaxThawingPage extends StatelessWidget {

  final UserRepository userRepository = UserRepository();

  String noac;
  // List<DataSimulasi> list ;

  SbmaxThawingPage({Key key, @required this.noac}) : super(key: key);

  // SbmaxPilihRekeningPage({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text("Atur SB Maximal",
              style: Theme.of(context).textTheme.title),
        elevation: 0.0,
      ),
      body: MultiBlocProvider(
        providers: [
         BlocProvider(
            create: (context) {
              return SbmaxPencairanBloc(
                userRepository: userRepository,
              );
            },
          ),
        ],
        child: SbmaxThawingForm(noac: noac,),
        
      ),
    );
  }
}
