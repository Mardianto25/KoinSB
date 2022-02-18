import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/store_rekening_coin/store_rekening_coin_bloc.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/ui_bloc/store_rekening_coin/store_rekening_coin_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class StoreRekeningCoinPage extends StatelessWidget {
  final UserRepository userRepository =UserRepository();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
     
      body:  BlocProvider(
        create: (context) {
          return StoreRekeningCoinBloc(
            // authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: StoreRekeningCoinForm(),
      ),
    );
  }
}
