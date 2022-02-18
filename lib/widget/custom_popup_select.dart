import 'package:flutter/material.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';
import 'package:flutter_base/style/custom_text.dart';

class CustomPopupSelect extends StatefulWidget {
  final ValueSetter<String> onChangeText;
  final List<RadioGroup> radioGroup;
  final String title;

  @override
  State<StatefulWidget> createState() =>
      new _CustomPopupSelectState(radioGroup, title);

  CustomPopupSelect({this.onChangeText, @required this.radioGroup, this.title});
}

class _CustomPopupSelectState extends State<CustomPopupSelect> {
  List<Widget> list = [];

  String _currentIndex;
  String _currentText = 'Pilih..';

  String title;

  List<RadioGroup> radioGroup;
  List<RadioGroup> datas;

  _CustomPopupSelectState(this.radioGroup, title) {
    this.radioGroup = radioGroup;
    this.datas = radioGroup;
    this.title = title;
    _currentText = title;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _displayRadioDialog(context);
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 15.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _currentText,
                  style: TextStyle(fontSize: 16),
                ),
                Image.asset(
                  "assets/images/right_arrow.png",
                  scale: 2.2,
                )
              ],
            ),
          )),
    );
  }

  _displayRadioDialog(BuildContext context) async {
    radioGroup = datas;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          int selectedRadio = 0;
          return AlertDialog(
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(child: buildRadioButton());
              },
            ),

          );
        });
  }

  Widget buildRadioButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, left: 10),
          child: Text(
            title,
            style: CustomText.bold16,
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20, left: 10),
          child: TextFormField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search)
            ),
            onChanged: (value){
              setState(() {
                if(value != ""){
                  radioGroup = datas.where((data) => data.name.toLowerCase().contains(value.toLowerCase())).toList();
                }
              });
            },
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: this
              .radioGroup
              .map((radioModel) => GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Radio(
                          value: radioModel.id,
                          groupValue: radioGroup,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        Text(radioModel.name),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      setState(() {

                        _currentIndex = radioModel.id;
                        _currentText = radioModel.name;

                      });

                    },
                  ))
              .toList(),
        )
      ],
    );
  }
}
