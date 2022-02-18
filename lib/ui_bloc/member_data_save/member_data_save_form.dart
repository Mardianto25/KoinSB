import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/member_data_save/member_data_save_bloc.dart';
import 'package:flutter_base/bloc/member_data_save/member_data_save_event.dart';
import 'package:flutter_base/bloc/member_data_save/member_data_save_state.dart';
import 'package:flutter_base/code_referral.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/referral/referral_page.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MemberDataForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MemberDataFormState();
}

class _MemberDataFormState extends State<MemberDataForm> {
  double bottomSheetTopPosition = 50;

  @override
  void initState() {
    super.initState();
  }

  _onButtonPressed() {
    BlocProvider.of<MemberDataSaveBloc>(context).add(
      MemberDataButtonPressed(
        publicId: ""
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemberDataSaveBloc, MemberDataSaveState>(
      listener: (context, state) {
        if (state is MemberDataSaveFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is MemberDataSaveInitial) {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_){
                  return ReferralPage(type: "",);
                }
            ));
          // BlocProvider.of<RegisterHandleBloc>(context).add(RegisterSuccess());
        }
       
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 32),
                    child: SvgPicture.asset("assets/svg/ic-success-01.svg")),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Data Keanggotaan Berhasil Disimpan",
                    style: CustomText.bold18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: Text(
                    "Silahkan masuk ke dashboard untuk mulai memanfaatkan "
                    " penawaran produk simpanan kami",
                    textAlign: TextAlign.center,
                    style: CustomText.regular13,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                _onButtonPressed();

              },
              child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: CustomRegistrationButton("ISI KODE REFERRAL", true)),
            ),
          ],
        )));
  }
}
