import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/show_data/get_data_spesimen_bloc..dart';
import 'package:flutter_base/bloc/show_data/post_data_bloc.dart';
import 'package:flutter_base/bloc/show_data/show_data_bloc.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/show_data/show_data_form.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class ShowDataPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => MemberData()
            ));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        title: Text("Konfirmasi Data Keanggotaan",
          style: Theme.of(context).textTheme.title
        ),
      ),
    
      body: 
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ShowDataBloc(
                userRepository: userRepository,
              );
            },
          ),
          BlocProvider(
            create: (context) {
              return PostDataBloc(
                userRepository: userRepository,
              );
            },
          )
        ],
        child: ShowDataForm(),
        
      )
      // body: RegisterForm()
    );
  }
}
