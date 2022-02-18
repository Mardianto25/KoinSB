import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroWidget extends StatefulWidget {
  const IntroWidget({Key key, this.image, this.subText, this.title})
      : super(key: key);

  final image;
  final String subText;
  final String title;
  @override
  State<StatefulWidget> createState() =>
      new _IntroWidgetState(image, subText, title);
}

class _IntroWidgetState extends State<IntroWidget> {
  double topPosistion = -100;
  double opacity = 0;
  String image, subtext, title;

  _IntroWidgetState(image, subtext, title) {
    this.image = image;
    this.subtext = subtext;
    this.title = title;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        topPosistion = 10;
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: SvgPicture.asset(image),
            ),
            Container(
              margin: EdgeInsets.only(top: 24,bottom: 16),
              child: Text(
                  title,
                style: CustomText.bold20,
              ),
            ),
            Container(
              height: 64,
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: topPosistion,
                    duration: Duration(milliseconds: 500),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 250,
                          child: Text(
                            subtext,
                            maxLines: 3,
                            style: CustomText.regular14,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

}
