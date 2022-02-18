import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/example_json_to_form.dart';
import 'package:flutter_base/dashboard/komersial/komersial_welcome.dart';
import 'package:flutter_base/dashboard/loan_list.dart';
import 'package:flutter_base/dashboard/pickmi/mikro/mikro_welcome.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_desc.dart';
import 'package:flutter_base/dashboard/saving_list.dart';
import 'package:flutter_base/dashboard/sbmax/sbmax_start.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/ui_dashboard/list_simpanan/list_simpanan_page.dart';
import 'package:flutter_base/widget/circle_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExploreProductState();
  }
}

class _ExploreProductState extends State<ExploreProduct> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> _tabs = ["Simpanan", "Pinjaman"];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xffe6c125),
                        ),
                        insets: EdgeInsets.only(left: 0, right: 21, bottom: 0)),
                    isScrollable: true,
                    labelStyle: TextStyle(fontFamily: 'NeoSansW1g'),
                    unselectedLabelStyle:TextStyle(fontFamily:"NeoSansW1g"),
                    labelPadding: EdgeInsets.only(left: 0, right: 0),
                    tabs: _tabs
                        .map((label) => Padding(
                              padding: const EdgeInsets.only(right: 21),
                              child: Tab(text: "$label"),
                            ))
                        .toList(),
                  ),
                ),
                preferredSize: const Size.fromHeight(48.0),
              ),
              title: Text('Jelajah Produk'),
            ),
            body: TabBarView(
              children: [
                //simpanan
                Container(
                  padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Stack(
                    children: <Widget>[
                      _simpananSection(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: OutlineButton(
                            child: new Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding:
                                    EdgeInsets.only(top: 18.0, bottom: 16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 12.0),
                                      child: SvgPicture.asset(
                                          "assets/svg/jelajah-produk/simpanan/ic-saving-list.svg"),
                                    ),
                                    Text(
                                      "List Produk Simpananmu",
                                      textAlign: TextAlign.center,
                                      style: CustomText.medium14Teal,
                                    )
                                  ],
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListSimpananPage()));
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //pinjaman
                Container(
                  padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Stack(
                    children: <Widget>[
                      _pinjamanSection(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: OutlineButton(
                            child: new Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding:
                                    EdgeInsets.only(top: 16.0, bottom: 16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      child: SvgPicture.asset(
                                          "assets/svg/jelajah-produk/pinjaman/ic-loan-list.svg"),
                                    ),
                                    Text(
                                      "List Produk Pinjamanmu",
                                      textAlign: TextAlign.center,
                                      style: CustomText.medium14Teal,
                                    )
                                  ],
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoanList()));
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _ppobSection() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
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

  Widget _simpananSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
//          _ppobSection(),
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
                child: CircleButton(
                    "SBMax",
                    "assets/svg/jelajah-produk/simpanan/ic-sbmax-white.svg",
                    Color(0xff096d5c)),
              ),
              GestureDetector(
                onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SBMaxStart()));
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Coming Soon!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: CircleButton(
                    "TAKA",
                    "assets/svg/jelajah-produk/simpanan/ic-taka-white.svg",
                    Color(0xff2cbf5a)),
              ),
              GestureDetector(
                onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SBMaxStart()));
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Coming Soon!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: CircleButton(
                    "SAVE-T",
                    "assets/svg/jelajah-produk/simpanan/ic-savet-whte.svg",
                    Color(0xfffa6e70)),
              ),
              GestureDetector(
                onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SBMaxStart()));
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Coming Soon!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: CircleButton(
                    "SBAUTO",
                    "assets/svg/jelajah-produk/simpanan/ic-sbauto-white.svg",
                    Color(0xff235d9f)),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SBMaxStart()));
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Coming Soon!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: CircleButton(
                      "SBSP",
                      "assets/svg/jelajah-produk/simpanan/ic-sbsp-white.svg",
                      Color(0xff71ab3c)),
                ),
                GestureDetector(
                  onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SBMaxStart()));
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Coming Soon!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: CircleButton(
                      "JELITA",
                      "assets/svg/jelajah-produk/simpanan/ic-jelita-white.svg",
                      Color(0xffffce51)),
                ),
                GestureDetector(
                  onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SBMaxStart()));
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Coming Soon!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: CircleButton(
                      "TAWIS",
                      "assets/svg/jelajah-produk/simpanan/ic-tawis-white.svg",
                      Color(0xff197e8c)),
                ),
                GestureDetector(
                  onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SBMaxStart()));
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Coming Soon!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: CircleButton(
                      "TRS-B",
                      "assets/svg/jelajah-produk/simpanan/ic-trs-white.svg",
                      Color(0xff4bbfb8)),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SBMaxStart()));
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Coming Soon!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: CircleButton(
                      "TPS-B",
                      "assets/svg/jelajah-produk/simpanan/ic-tps-white.svg",
                      Color(0xfffa6e70)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _pinjamanSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
//          _ppobSection(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => PickmiDesc()));
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Coming Soon!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: CircleButton(
                    "PICKMI",
                    "assets/svg/jelajah-produk/pinjaman/ic-pickmi-white.svg",
                    Color(0xfffca000)),
              ),
              GestureDetector(
                onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => KomersialWelcome()));
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Coming Soon!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: CircleButton(
                    "KOMERSIAL",
                    "assets/svg/jelajah-produk/pinjaman/ic-komersial-white.svg",
                    Color(0xff197e8c)),
              ),
              GestureDetector(
                onTap: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => MikroWelcome()));
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Coming Soon!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: CircleButton(
                    "MIKRO",
                    "assets/svg/jelajah-produk/pinjaman/ic-mikro-white.svg",
                    Color(0xffa373b9)),
              ),
              GestureDetector(
                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => JsonToForm()));
                   Scaffold.of(context).showSnackBar(
                     SnackBar(
                       content: Text('Coming Soon!'),
                       backgroundColor: Colors.green,
                       duration: Duration(seconds: 1),
                     ),
                   );
                 },
                child: CircleButton(
                    "SBRENO",
                    "assets/svg/jelajah-produk/pinjaman/ic-griya-white.svg",
                    Color(0xff4bbfb8)),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => JsonToForm()));
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Coming Soon!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: CircleButton(
                      "SBSMART",
                      "assets/svg/jelajah-produk/pinjaman/ic-cendika-white.svg",
                      Color(0xfffa6e70)),
                ),
                GestureDetector(
                  onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => JsonToForm()));
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Coming Soon!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: CircleButton(
                      "KENDARAAN",
                      "assets/svg/jelajah-produk/pinjaman/ic-oto-white.svg",
                      Color(0xff235d9f)),
                ),
                GestureDetector(
                  onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => JsonToForm()));
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Coming Soon!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: CircleButton(
                      "EZHajj",
                      "assets/svg/jelajah-produk/pinjaman/ic-ezhajj-white.svg",
                      Color(0xff71ab3c)),
                ),
                CircleButton(
                    "", "assets/svg/jelajah-produk/pinjaman/ic-ezhajj-white.svg", Color(0xfffff)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
