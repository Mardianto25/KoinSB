import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/saving_list.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_plan.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_start.dart';
import 'package:flutter_base/style/custom_box_decoration.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/list_simpanan/list_simpanan_page.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/sbmax_nominal/sbmax_nominal_page.dart';
import 'package:flutter_base/util/SlideRightRoute.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SBMaxChooseProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SBMaxChooseProductState();
  }
}

class _SBMaxChooseProductState extends State<SBMaxChooseProduct> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextSelection textSelection =
  const TextSelection(baseOffset: 50, extentOffset: 70);
  final GlobalKey _textKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (contex) => SBMaxStart() 
        ));
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) => Main()
        // ));
      },
      child: new Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                // Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (contex) => SBMaxStart() 
                ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text("Simpanan Berjangka Max",
                style: Theme.of(context).textTheme.title),
          ),
          body: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _showDialog();
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xff71ab3c),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  padding: EdgeInsets.all(23),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "Saya ingin membuka Simpanan Berjangka MAX",
                                          style: CustomText.medium12White,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 9),
                                        child: Text(
                                          "“Simpanan dengan nilai manfaat terbesar”",
                                          style: CustomText.regular12White,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context, MaterialPageRoute(
                                    builder: (context)=> ListSimpananPage()
                                  ));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 12),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xff71ab3c),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  padding: EdgeInsets.all(23),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "Lihat Portofolio Simpanan Berjangka saya",
                                          style: CustomText.medium12White,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 9),
                                        child: Text(
                                          "“Daftar semua Simpanan Berjangka milikmu”",
                                          style: CustomText.regular12White,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: new Text(
              "Syarat dan Ketentuan",
              style: CustomText.medium16,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Dengan memilih setuju, Anggota telah menyetujui',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Syarat dan Ketentuan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.underline,)),
                      TextSpan(text: ' yang berlaku'),
                    ],
                  ),
                ),
                // new Positioned.fill(
                //   child: new LayoutBuilder(
                //     builder: (context, _) => new Stack(
                //       children: <Widget>[
                //         new Positioned.fromRect(
                //           rect: _getSelectionRect(),
                //           child: new InkWell(
                //             onTap: () {
                //               print("test");
                //             }, // needed to show the ripple
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder:(context) => SbmaxNominalPage()
                        ));
                        
                  },
                  child: Container(
                      width: double.infinity,
                      child: Container(
                        height: 38,
                        margin: EdgeInsets.only(bottom: 12, top: 23),
                        decoration: BoxDecoration(
                          color: Color(0xff096d5c),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: MaterialButton(
                          child: Text(
                            "SETUJU",
                            style: CustomText.bold14White,
                          ),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 38,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.teal),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3.0,
                          ),
                        ]),
                        child: MaterialButton(
                          child: Text(
                            "TIDAK",
                            style: CustomText.medium14Teal,
                          ),
                        ),
                      )),
                )
              ],
            ));
      },
    );
  }

  Rect _getSelectionRect() =>
      (_textKey.currentContext.findRenderObject() as RenderParagraph)
          .getBoxesForSelection(textSelection)
          .fold(
        null,
            (Rect previous, TextBox textBox) => new Rect.fromLTRB(
          min(previous?.left ?? textBox.left, textBox.left),
          min(previous?.top ?? textBox.top, textBox.top),
          max(previous?.right ?? textBox.right, textBox.right),
          max(previous?.bottom ?? textBox.bottom, textBox.bottom),
        ),
      ) ??
          Rect.zero;
}
