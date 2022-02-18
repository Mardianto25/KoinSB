import 'package:flutter/material.dart';

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  final double _width;
  final double _fontSize;
  RadioItem(this._item, this._width, this._fontSize);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: _width,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color:
                      _item.isSelected ? Colors.white : Colors.grey,
                      //fontWeight: FontWeight.bold,
                      fontSize: _fontSize)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? Colors.teal
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Colors.teal
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}