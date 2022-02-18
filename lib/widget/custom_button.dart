import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';


class CustomButton extends StatelessWidget {
  final String _title;
  final bool _enable;

  CustomButton(this._title, this._enable);

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: (_enable)?CustomRoundRec.greenButton:CustomRoundRec.greyButton,
      child: MaterialButton(
        padding: EdgeInsets.all(16),
        child:Text(
          _title,
          style: (_enable) ? CustomText.bold14White : CustomText.bold14White,
        ),
      ),
    );
  }
}