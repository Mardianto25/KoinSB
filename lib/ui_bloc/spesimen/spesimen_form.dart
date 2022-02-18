import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/bloc/spesimen/spesimen_bloc.dart';
import 'package:flutter_base/bloc/spesimen/spesimen_event.dart';
import 'package:flutter_base/bloc/spesimen/spesimen_state.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/phonenumber.dart';
import 'package:flutter_base/resource/strings.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/pin_phone/pin_phone_page.dart';
import 'package:flutter_base/ui_bloc/show_data/show_data_page.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SpesimenForm extends StatefulWidget {
  String type;

  SpesimenForm({Key key, @required this.type}) : super(key: key);
  
  @override
  State<SpesimenForm> createState() => _SpesimenFormState();


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

class _SpesimenFormState extends State<SpesimenForm> {
  ByteData _img = ByteData(0);
  int _imageCounter = 0;
  File _imageFile;
  var color = Colors.black;
  var strokeWidth = 3.0;
  var _isChecked = false;
  final _sign = GlobalKey<SignatureState>();
  final _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  bool _enable = false;
  bool _autoValidate=false;

  @override
  void initState() {  
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    _onSpesimenButtonPressed() {
      BlocProvider.of<SpesimenBloc>(context).add(
        SpesimenButtonPressed(
          spesimen: _imageFile
          // otpCode: _pin
        ),
      );
    }


    return BlocListener<SpesimenBloc, SpesimenState>(
      listener: (context, state) {
        if (state is SpesimenLoading){
          loading();
        }
        if (state is SpesimenFailure) {
          Navigator.pop(context);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is SpesimenInitial) {
          // BlocProvider.of<SpesimenHandleBloc>(context).add(SpesimenSuccess());
          if(widget.type == "update"){
            Navigator.pop(context);
            Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_){
                  return ShowDataPage();
                }
            ));
          }
          if(widget.type == ""){
            Navigator.pop(context);
            // success();
            setParameter();
            Navigator.of(context).pop();
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => MemberData()));
          }
        }
       
      },
      child: BlocBuilder<SpesimenBloc, SpesimenState>(
        builder: (context, state) {
          return  Container(
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
                      GestureDetector(
                        onTap: () async{
                          final sign = _sign.currentState;
                          sign.clear();
                          setState(() {
                            _img = ByteData(0);
                          });
                          debugPrint("cleared");
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            "HAPUS SPESIMEN",
                            style: CustomText.bold12Primary,
                            textAlign: TextAlign.center,
                          ),
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
                        activeColor: Colors.teal,
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
                        onPressed: () async {
                          final sign = _sign.currentState;
                           //retrieve image data, do whatever you want with it (send to server, save locally...)
                           final image = await sign.getData();


                           var data = await image.toByteData(
                               format: ui.ImageByteFormat.png);
                           print(data);
                           sign.clear();
                          final directory = await getApplicationDocumentsDirectory();
                          final imageFile = await writeToFile(data, directory.path, _imageCounter);
                           setState(() {
                             _imageCounter = _imageCounter + 1;
                           _imageFile = imageFile;
                           print(_imageFile);
//                           _showImageDialog(_imageFile);
                           });
                           _isChecked ? _onSpesimenButtonPressed(): null;
                        },
                        color:_isChecked == true ? Color(0xff096d5c): Color(0xff727272),
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
              ],
            ),
          ); 
        },
      ),
    );
  }
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // Navigator.of(context).push(
      //     MaterialPageRoute(
      //         builder:(context) => PinPhonenumber()
      //     )
      // );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<File> writeToFile(ByteData data, String path, int counter) {

    final buffer = data.buffer;
    return new File('$path/sign-$counter.png').writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  _showImageDialog(File file) {
    return 
      showDialog(context: context, child:
    new AlertDialog(
      title: new Text("My Super title"),
      content: new Container(
        child: Image.file(file, scale: 1.0,),
      ),
    )
    );
  }

  success(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
            title: new Text('Data spesimen berhasil disimpan'),
            content: new Text('Success'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("spesimenSimpan", "done");
                  Navigator.of(context).pop();
                  Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MemberData()));
                }, 
                child: FlatButton(child: Text("OK", style: TextStyle(color: Colors.teal),),),
              ),
            ],
          ),
    ) ??
    false;
  }

  setParameter() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("spesimenSimpan", "done");
}

  successEdit(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
            title: new Text('Data pribadi berhasil diupdate'),
            content: new Text('Success'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShowDataPage()));
                }, 
                child: FlatButton(child: Text("OK", style: TextStyle(color: Colors.teal),),),
              ),
            ],
          ),
    ) ??
    false;
  }

  loading2(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
            content:
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.4, 
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ),
    ) ??
    false;
  }

  loading(){
    return showDialog(
      context: context,
      barrierDismissible: false,  
      useRootNavigator: false,    
      builder: (context) => new AlertDialog(
            content:
            Container(

            width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height, 
            child: Container(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Loading ...", style: CustomText.bold12Black,),
                  )
                ],
              ),
            ),
          )
        ),
    ) ??
    false;
  }
}
