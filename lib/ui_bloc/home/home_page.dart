import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/cek_fitur_coin/cek_fitur_coin_bloc.dart';
import 'package:flutter_base/bloc/profile/get_home_bloc.dart';
import 'package:flutter_base/bloc/profile/profile_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/home/home_form.dart';
import 'package:flutter_base/ui_bloc/profile/profile_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_nominal/sbmax_nominal_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_pin/sbmax_pin_form.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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


class HomePage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  // List<DataSimulasi> list;
  
  // ProfilePage({Key key, @required this.list}) : super(key: key);


  // SbmaxPinPage({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                // padding: EdgeInsets.only(left: 13),
                child: SvgPicture.asset("assets/svg/dashboard/ai-svg/ic-koin-dashboard.svg"),
              ),
              SvgPicture.asset("assets/svg/dashboard/ai-svg/ic-notification.svg"),
            ],
          ),
        ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return GetHomeBloc(
                userRepository: userRepository,
              );
            },
          ),
          BlocProvider(
            create: (context) {
              return CekFiturCoinBloc(
                userRepository: userRepository,
              );
            },
          ),         
        ],
        child: HomeForm(),
        
      ),
    );
  }
}
