import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/get_foto_profile/get_foto_profile_bloc.dart';
import 'package:flutter_base/bloc/profile/profile_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/profile/profile_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_nominal/sbmax_nominal_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_pin/sbmax_pin_form.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';



class ProfilePage extends StatelessWidget {
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
          backgroundColor: Theme.of(context).primaryColor,
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Akun",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
              Container(
                child: SvgPicture.asset(
                  "assets/svg/ic-notification.svg",
                ),
              )
            ],
          ),
          centerTitle: false,
        ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ProfileBloc(
                userRepository: userRepository,
              );
            },
          ),

          BlocProvider(
            create: (context) {
              return GetFotoProfileBloc(
                userRepository: userRepository,
              );
            },
          ),
         
        ],
        child: ProfileForm(),
        
      ),
    );
  }
}
