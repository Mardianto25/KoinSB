import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

class SpesimenSign extends StatefulWidget {
  SpesimenSign({Key key}) : super(key: key);

  @override
  _SpesimenSignState createState() => _SpesimenSignState();
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
//    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WatermarkPaint &&
          runtimeType == other.runtimeType &&
          price == other.price &&
          watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}

class _SpesimenSignState extends State<SpesimenSign> {
  ByteData _img = ByteData(0);
  var color = Colors.black;
  var strokeWidth = 3.0;
  var _isChecked = false;
  final _sign = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Spesimen Tanda Tangan",
            style: Theme.of(context).textTheme.title),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 10.0, top: 30.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey)),
                child: Signature(
                  color: color,
                  key: _sign,
                  onSign: () {
                    final sign = _sign.currentState;
                    debugPrint('${sign.points.length} points in the signature');
                  },
                  backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                  strokeWidth: strokeWidth,
                ),
              ),
            ),
            _img.buffer.lengthInBytes == 0
                ? Container()
                : LimitedBox(
                    maxHeight: 200.0,
                    child: Image.memory(_img.buffer.asUint8List())),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "Silahkan buat spesimen tanda tangan digital anda",
                      style: CustomText.regular12,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "HAPUS SPESIMEN",
                      style: CustomText.bold12Primary,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value) {
                      setState(() {
                        _isChecked = value;
                      });
                    },
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "Saya mengkonfirmasi ini adalah benar spesimen tanda tangan saya"
                      " dan KSP-SB dapat digunakan sebagaimana seharusnya",
                      style: CustomText.regular13,
                    ),
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: MaterialButton(
                    onPressed: () {},
                    color: Color(0xff727272),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "UPLOAD  TTD",
                        textAlign: TextAlign.center,
                        style: CustomText.regular14White,
                      ),
                    ),
                  ),
                ))
//          Column(
//            children: <Widget>[
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: [
//                  MaterialButton(
//                      color: Colors.green,
//                      onPressed: () async {
//                        final sign = _sign.currentState;
//                        //retrieve image data, do whatever you want with it (send to server, save locally...)
//                        final image = await sign.getData();
//                        var data = await image.toByteData(
//                            format: ui.ImageByteFormat.png);
//                        sign.clear();
//                        final encoded =
//                            base64.encode(data.buffer.asUint8List());
//                        setState(() {
//                          _img = data;
//                        });
//                        debugPrint("onPressed " + encoded);
//                      },
//                      child: Text("Save")),
//                  MaterialButton(
//                      color: Colors.grey,
//                      onPressed: () {
//                        final sign = _sign.currentState;
//                        sign.clear();
//                        setState(() {
//                          _img = ByteData(0);
//                        });
//                        debugPrint("cleared");
//                      },
//                      child: Text("Clear")),
//                ],
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  MaterialButton(
//                      onPressed: () {
//                        setState(() {
//                          color =
//                              color == Colors.green ? Colors.red : Colors.green;
//                        });
//                        debugPrint("change color");
//                      },
//                      child: Text("Change color")),
//                  MaterialButton(
//                      onPressed: () {
//                        setState(() {
//                          int min = 1;
//                          int max = 10;
//                          int selection = min + (Random().nextInt(max - min));
//                          strokeWidth = selection.roundToDouble();
//                          debugPrint("change stroke width to $selection");
//                        });
//                      },
//                      child: Text("Change stroke width")),
//                ],
//              ),
//            ],
//          )
          ],
        ),
      ),
    );
  }
}
