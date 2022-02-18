import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_text.dart';

 class CustomRegistrationText extends StatelessWidget {
  final String _title;
  final String _hint;
  final bool _isObsecureText;
  Function _validator;
  CustomRegistrationText(this._title, this._hint, this._isObsecureText, _validator);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(left: 34, right: 34, top: 22),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_title, style: CustomText.regular14White,),
            ],
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            style: CustomText.regular13White,
            obscureText: _isObsecureText,
            validator: _validator,
            decoration: InputDecoration(
                hintText: _hint,
                hintStyle: CustomText.registrationHint,
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)
                )
            ),
          )
        ],
      ),
    );
  }
}