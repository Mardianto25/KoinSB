import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/general_get/general_get_param_bloc.dart';
import 'package:flutter_base/bloc/sbmax/sbmax_nominal/sbmax_nominal_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_nominal/sbmax_nominal_form.dart';

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


class SbmaxNominalPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  // SbmaxNominalPage({Key key, @required this.userRepository})
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
              return SbmaxNominalBloc(
                userRepository: userRepository,
              );
            },
          ),
        ],
        child: SbmaxNominalForm(),
        
      ),
    );
  }
}
