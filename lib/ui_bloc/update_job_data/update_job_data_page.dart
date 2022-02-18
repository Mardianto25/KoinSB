import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/general_get/general_get_bloc.dart';
import 'package:flutter_base/bloc/general_get/general_get_param_bloc.dart';
import 'package:flutter_base/bloc/job_data/job_data_bloc.dart';
import 'package:flutter_base/bloc/update_job_data/update_job_data_bloc.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/job_data/job_data_form.dart';
import 'package:flutter_base/ui_bloc/update_job_data/update_job_data_form.dart';

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


class UpdateJobDataPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  // UpdateJobDataPage({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) => MemberData()
              // ));
              Navigator.of(context).pop();
          
            }
          ),
        elevation: 0.0,
        title: Text("Data Pekerjaan",
            style: Theme.of(context).textTheme.title),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return UpdateJobDataBloc(
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
        child: UpdateJobDataForm(),
        
      ),
    );
  }
}
