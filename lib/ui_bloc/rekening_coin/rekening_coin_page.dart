import 'package:flutter/material.dart';
import 'package:flutter_base/ui_bloc/register/register_page.dart';
import 'package:flutter_base/ui_bloc/rekening_coin/rekening_coin_form.dart';




class RekeningCoinPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_){
                    return RegisterPage();
                  }
                )
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
     
      body:  RekeningCoinForm(),
    );
  }
}
