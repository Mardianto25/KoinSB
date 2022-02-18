import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/loan_detail/choose_payment_installment.dart';
import 'package:flutter_base/dashboard/loan_detail/pickmi_active.dart';
import 'package:flutter_base/dashboard/loan_detail/pickmi_process.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/circle_button.dart';

class LoanList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoanListState();
  }
}

class _LoanListState extends State<LoanList> {
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
              title: Text('Daftar Pinjaman',
                  style: Theme.of(context).textTheme.title),
            ),
            body: TabBarView(
              children: [
                //aktif
                Container(
                  padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PickmiActive(title: "Dana",)));
                            },
                            child: _loanListBox(true, "Dana"),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PickmiActive(title: "Barang",)));
                            },
                            child: _loanListBox(true, "Barang"),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PickmiProcess(title: "Dana",)));
                            },
                            child: _loanListBox(false, "Dana"),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PickmiProcess(title: "Barang")));
                            },
                            child: _loanListBox(false, "Barang"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //sudah selesai
                Container(
                  padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Container(
                    child: _emptyList(),
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
            padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 16),
            child: Text(
              "Silahkan buka produk Pinjaman terlebih dahulu dan"
              " dapatkan jasa Pinjaman yang menarik!",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _loanListBox(bool active, String title) {
    return Container(
      margin: EdgeInsets.only(top: 12.0),
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
                    child: Image.asset("assets/images/ic_pickmi_white.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Pinjaman Pickmi $title",
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
                    bottomLeft: (active == true) ? const Radius.circular(0.0) : const Radius.circular(10.0),
                    bottomRight: (active == true) ? const Radius.circular(0.0) : const Radius.circular(10.0))),
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
          ),
          (active == true)
              ? Container(
                  decoration: new BoxDecoration(
                      color: Color(0xff71ab3c),
                      borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(10.0),
                          bottomRight: const Radius.circular(10.0))),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChoosePayMentInstallment()));
                    },
                    minWidth: double.infinity,
                    child: Text(
                      "BAYAR CICILAN",
                      style: CustomText.medium14White,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
