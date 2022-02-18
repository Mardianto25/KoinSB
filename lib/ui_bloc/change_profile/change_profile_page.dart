import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/change_email/change_email_bloc.dart';
import 'package:flutter_base/bloc/profile/profile_bloc.dart';
import 'package:flutter_base/bloc/upload_profile/upload_profile_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/change_profile/change_profile_form.dart';
import 'package:flutter_base/ui_bloc/profile/profile_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_nominal/sbmax_nominal_form.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_pin/sbmax_pin_form.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


class ChangeProfilePage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final String email, name;
  Uint8List image;
  
  ChangeProfilePage({Key key, @required this.email, @required this.name, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Ubah Profil", style: Theme.of(context).textTheme.title),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return UploadProfileBloc(
                userRepository: userRepository,
              );
            },
          ),
         
        ],
        child: ChangeProfileForm(email: email,name: name,image: image),
        
      ),
    );
  }
}
