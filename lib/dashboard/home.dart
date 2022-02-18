import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/profile/profile_bloc.dart';
import 'package:flutter_base/bloc/profile/profile_event.dart';
import 'package:flutter_base/bloc/profile/profile_state.dart';
import 'package:flutter_base/dashboard/main.dart';
import 'package:flutter_base/dashboard/menu_webview.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_start.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_desc.dart';
import 'package:flutter_base/dashboard/komersial/komersial_welcome.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/login/login_main.dart';
import 'package:flutter_base/ui_bloc/rekening_webview.dart';
import 'package:flutter_base/ui_bloc/rekening_webview_tes.dart';
import 'package:flutter_base/widget/circle_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current;
  bool _loading = false;
  String _token;
  // ProfileBloc _getBloc;
  

  @override
  void initState() {
    super.initState();
    // _getBloc = BlocProvider.of<ProfileBloc>(context); 
    // _onSubmited();   
    _getToken();
  }

  void _getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // prefs.remove("token");
      _token = prefs.getString("token");
      if(_token == null || _token.isEmpty){
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginMain()
        ));
      }    
      _loading = true;
    });
  }


  _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Apakah anda yakin?'),
            content: new Text('Anda akan Keluar'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: FlatButton(
                  child: Text(
                    "No",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  
                },
                child: FlatButton(
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          key: scaffoldKey,
          appBar: new AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  // padding: EdgeInsets.only(left: 13),
                  child: SvgPicture.asset("assets/svg/dashboard/ai-svg/ic-koin-dashboard.svg"),
                ),
                SvgPicture.asset("assets/svg/dashboard/ai-svg/ic-notification.svg"),
              ],
            ),
          ),
          body:(_loading == false) ? Center(child: CircularProgressIndicator(),):
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          StickyHeader(
                            header: _headerSection(),
                            content: Container(
                              child: Column(
                                children: <Widget>[
                                  _sliderSection(),
                                  _ppobSection(),
                                  _productSection(),
                                  Container(
                                    margin: EdgeInsets.only(top: 17.0, bottom: 16.0),
                                    width: double.infinity,
                                    height: 20.0,
                                    color: Color(0xffe3e3e3),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 18, left: 16, right: 16),
                                    child: Column(
                                      children: <Widget>[_whatNewsSection(), _cardSection()],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ),
                          
                        ],
                      ),
                    ),
                  
                  ],
                ),
              )

      ),
    );
  }

  Widget _headerSection() {
    return 
      Container(
        color:Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              // color: Colors.white,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(left: 18, right: 18),
              decoration: BoxDecoration(
                color: Color(0xff096d5c),
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Padding(
              padding: EdgeInsets.only(top: 14, bottom: 13.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      // BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => MyWebview()
                      ));
                      
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: SvgPicture.asset("assets/svg/dashboard/ai-svg/ic-rekening.svg"),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8.7),
                            child: Text(
                              "Rekening",
                              style: CustomText.medium12White,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child:Column(
                      children: <Widget>[
                        Container(
                          child: SvgPicture.asset("assets/svg/dashboard/ai-svg/ic-transfer.svg"),
                        ),
                        
                        Container(
                          margin: EdgeInsets.only(top: 8.7),
                          child: Text(
                            "Transfer",
                            style: CustomText.medium12White,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      child:Column(
                      children: <Widget>[
                        Container(
                          child: SvgPicture.asset("assets/svg/dashboard/ai-svg/ic-beli-bayar.svg"),
                        ),
                        
                        Container(
                          margin: EdgeInsets.only(top: 8.7),
                          child: Text(
                            "Beli & Bayar",
                            style: CustomText.medium12White,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    ),
          ],
        ),
      );
  }

  Widget _bannerSection() {
    return Container(
      margin: EdgeInsets.only(top: 12.0),
      height: 100,
      width: 316,
      child: new Swiper(
        loop: true,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return new SvgPicture.asset(
            "assets/svg/dashboard/ai-svg/banner-sbmax.svg",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
      ),
    );
  }
  
  Widget _sliderSection() {
    List imageList = [
      "assets/svg/dashboard/ai-svg/banner-sbmax.svg",
      "assets/svg/dashboard/ai-svg/banner-sbmax.svg",
      "assets/svg/dashboard/ai-svg/banner-sbmax.svg",
      "assets/svg/dashboard/ai-svg/banner-sbmax.svg",
    ];
    return Container(
      margin: EdgeInsets.only(top:12),
      child: Column(
        children: <Widget>[
          CarouselSlider(
            height: MediaQuery.of(context).size.height * 0.15,
            autoPlay: true,
            viewportFraction: 0.7,
            items: imageList.map((image){
              return Builder(
                builder: (BuildContext context){
                  return Container(
                    padding: EdgeInsets.only(left: 6),
                    child: SvgPicture.asset(image,fit:BoxFit.fill),
                  );
                },
              );
            }).toList(),
            onPageChanged: (index) {
              setState(() {
                this._current = index;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(imageList, (index, url) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: this._current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4)
                ),
              );
            }),
          )

        ],

      ),
    );
  }
  
  Widget _ppobSection() {
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18),      
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleButton("Pulsa", "assets/svg/dashboard/ai-svg/ic-pulsa.svg",
              Color(0xffffff)),
          CircleButton("Paket Data",
              "assets/svg/dashboard/ai-svg/ic-paket-data.svg", Color(0xffffff)),
          CircleButton("Listrik PLN", "assets/svg/dashboard/ai-svg/ic-pln.svg",
              Color(0xffffff)),
          CircleButton("PDAM", "assets/svg/dashboard/ai-svg/ic-pdam.svg",
              Color(0xffffff))
        ],
      ),
    );
  }

  Widget _productSection() {
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18),      
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 16, left: 16),
      child: Column(
        children: <Widget>[
          Container(
            child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SBMaxStart()));
                },
                child: CircleButton("SBMax", "assets/svg/dashboard/ai-svg/ic-sbmax-white.svg",
                    Color(0xff096d5c)
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MenuWebView(
                              url: "https://www.google.com", title: "Taka")));
                },
                child: CircleButton("Taka", "assets/svg/dashboard/ai-svg/ic-taka-white.svg",
                    Color(0xff2cbf5a)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MenuWebView(
                              url: "https://www.facebook.com", title: "Save-T")));
                },
                child: CircleButton("Save-T", "assets/svg/dashboard/ai-svg/ic-savet-whte.svg",
                    Color(0xfffa6e70)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MenuWebView(
                              url: "https://www.google.com", title: "SBAuto")));
                },
                child: CircleButton("SBAuto", "assets/svg/dashboard/ai-svg/ic-sbauto-white.svg", 
                    Color(0xff235d9f)),
              ),
            ],
          ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PickmiDesc()));
                },
                child: CircleButton("Pickmi", "assets/svg/dashboard/ai-svg/ic-pickmi-white.svg",
                    Color(0xfffca000)),
                ),
                GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KomersialWelcome()));
                },
                child: CircleButton("Komersial", "assets/svg/dashboard/ai-svg/ic-komersial-white.svg",
                    Color(0xff197e8c)),
                ),
                CircleButton("SBReno", "assets/svg/dashboard/ai-svg/ic-griya-white.svg",
                    Color(0xff4bbfb8)),
                CircleButton("EZHajj", "assets/svg/dashboard/ai-svg/ic-ezhajj-white.svg",
                    Color(0xff71ab3c))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _whatNewsSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'APA YANG',
                  style: CustomText.regular9Teal,
                ),
                Container(
                  child: Text(
                    "BARU?",
                    style: CustomText.bold14,
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 6.0),
              padding: EdgeInsets.all(12.0),
              decoration: CustomRoundRec.greenButtonSmall,
              child: Text(
                "Semua",
                style: CustomText.regular12White,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 6.0),
              padding: EdgeInsets.all(12.0),
              decoration: CustomRoundRec.whiteButtonSmall,
              child: Text(
                "Promo",
                style: CustomText.regular12Teal,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 6.0),
              padding: EdgeInsets.all(12.0),
              decoration: CustomRoundRec.whiteButtonSmall,
              child: Text("Berita Terbaru", style: CustomText.regular12Teal),
            ),
            Container(
              margin: EdgeInsets.only(left: 6.0),
              padding: EdgeInsets.all(12.0),
              decoration: CustomRoundRec.whiteButtonSmall,
              child: Text("Simpanan", style: CustomText.regular12Teal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardSection() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.only(left: 4),
          child: Card(
            elevation: 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset("assets/svg/dashboard/ai-svg/banner-cs-1.svg"),
                Container(
                  padding:
                      EdgeInsets.only(left: 12, right: 12, bottom: 5.3, top: 12.7),
                  child: Text(
                    'Lorem Ipsum Dolor Sit Amet',
                    style: CustomText.bold12,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 12, right: 12, bottom: 9),
                  child: Text(
                    'Integer ac interdum lacus. Nunc porta semper lacus a varius.'
                    'Pellentesque habitant morbi tristique senectus et netus et',
                    style: CustomText.regular10,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.only(left: 4),
          child: Card(
            elevation: 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset("assets/svg/dashboard/ai-svg/banner-cs-1.svg"),
                Container(
                  padding:
                      EdgeInsets.only(left: 12, right: 12, bottom: 5.3, top: 12.7),
                  child: Text(
                    'Lorem Ipsum Dolor Sit Amet',
                    style: CustomText.bold12,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 12, right: 12, bottom: 9),
                  child: Text(
                    'Integer ac interdum lacus. Nunc porta semper lacus a varius.'
                    'Pellentesque habitant morbi tristique senectus et netus et',
                    style: CustomText.regular10,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 26),
          padding: EdgeInsets.only(left: 4),
          child: Card(
            elevation: 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset("assets/svg/dashboard/ai-svg/banner-cs.svg"),
                Container(
                  padding:
                      EdgeInsets.only(left: 12, right: 12, bottom: 5.3, top: 12.7),
                  child: Text(
                    'Lorem Ipsum Dolor Sit Amet',
                    style: CustomText.bold12,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 12, right: 12, bottom: 9),
                  child: Text(
                    'Integer ac interdum lacus. Nunc porta semper lacus a varius.'
                    'Pellentesque habitant morbi tristique senectus et netus et',
                    style: CustomText.regular10,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
}
