import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/circle_button.dart';

class SavingList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SavingListState();
  }
}

class _SavingListState extends State<SavingList> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> _tabs = ["Aktif", "Sudah Selesai"];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0.0,
              bottom: PreferredSize(
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    labelColor: Colors.black,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff068675),
                        ),
                        insets: EdgeInsets.only(left: 0, right: 13, bottom: 0)),
                    isScrollable: true,
                    labelPadding: EdgeInsets.only(left: 0, right: 0),
                    tabs: _tabs
                        .map((label) => Padding(
                      padding: const EdgeInsets.only(right: 13),
                      child: Tab(text: "$label"),
                    ))
                        .toList(),
                  ),
                ),
                preferredSize: const Size.fromHeight(48.0),
              ),
              title: Text('Daftar Simpanan',
                  style: Theme.of(context).textTheme.title),
            ),
            body: TabBarView(
              children: [
                //aktif
                Container(
                  padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Column(
                    children: <Widget>[_savingListBox()],
                  ),
                ),
                //sudah selesai
                Container(
                  padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Column(
                    children: <Widget>[_savingListBox()],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _emptyList() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset("assets/images/ic_no_product_01.png"),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Text(
              "Belum ada Nih",
              style: CustomText.medium18,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left:18.0, right: 18.0, top: 16),
            child: Text(
              "Silahkan buka produk Pinjaman terlebih dahulu dan"
                  " dapatkan jasa Pinjaman yang menarik!", textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }

  Widget _savingListBox() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Image.asset("assets/images/ic_sbmax_white.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Simpanan Berjangka Maximal",
                      style: CustomText.regular15White,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.teal),
                borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(10.0),
                    bottomRight: const Radius.circular(10.0))),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Nominal",
                          style: CustomText.medium12Teal,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Rp.0.000.000.000",
                          style: CustomText.medium11,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Jatuh Tempo",
                          style: CustomText.medium12Teal,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Text(
                          "00/00/0000",
                          style: CustomText.medium11,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "No.Simpanan",
                          style: CustomText.medium12Teal,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Text(
                          "0000000000",
                          style: CustomText.medium11,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
