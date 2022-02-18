import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/sbmax/list_rekening/list_rekening_bloc.dart';
import 'package:flutter_base/bloc/sbmax/list_simpanan/list_simpanan_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_detail_anggota/sbmax_detail_anggota_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pencairan/sbmax_pencairan_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_pin/sbmax_pin_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/list_simpanan/list_simpanan_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_detail/sbmax_detail_form.dart';
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


class SbmaxDetailPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  String noac;

  SbmaxDetailPage({Key key, @required this.noac}) : super(key: key);

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
              return SbmaxDetailAnggotaBloc(
                userRepository: userRepository,
              );
            },
          ),
          BlocProvider(
            create: (context) {
              return SbmaxPencairanBloc(
                userRepository: userRepository,
              );
            },
          ),
        ],
        child: SbmaxDetailForm(noac:noac,),
        
      ),
    );
  }
}
