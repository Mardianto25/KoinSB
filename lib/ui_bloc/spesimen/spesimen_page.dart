import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/show_data/post_data_bloc.dart';
import 'package:flutter_base/bloc/show_data/show_data_bloc.dart';
import 'package:flutter_base/bloc/spesimen/spesimen_bloc.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/show_data/show_data_form.dart';
import 'package:flutter_base/ui_bloc/spesimen/spesimen_form.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class SpesimenPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  String type;

  SpesimenPage({Key key, @required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => MemberData()
        ));
      },
      child: Scaffold(
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
          title: Text("Spesimen Tanda Tangan",
              style: Theme.of(context).textTheme.title),
        ),
      
        body: 
        BlocProvider(
          create: (context) {
            return SpesimenBloc(
              userRepository: userRepository,
            );
          },
          child: SpesimenForm(type: type,),
        ),
        
        // body: RegisterForm()
      ),
    );
  }
}
