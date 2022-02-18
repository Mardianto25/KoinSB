import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:intl/intl.dart';
import 'package:flutter_base/dashboard/pickmi/pickmi_detail_loan_of_goods.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';

class PickmiLoanOfGoods extends StatefulWidget {
  @override
  _PickmiLoanOfGoodsState createState() => _PickmiLoanOfGoodsState();
}

class _PickmiLoanOfGoodsState extends State<PickmiLoanOfGoods> {
  var _eKTP, _gaji, _bornAt, _rangeJob;
  String _selectedJob, _selectedJobTime;
  final format = DateFormat("yyyy-MM-dd");
  final formKey = new GlobalKey<FormState>();
  List<String> sampleData = [
    'Lorem Ipsum 1',
    'Lorem Ipsum 2',
    'Lorem Ipsum 3',
    'Lorem Ipsum 4',
    'Lorem Ipsum 5',
  ];

  List<RadioGroup> JobCategory = []
    ..add(RadioGroup("1", "Teknisi"))
    ..add(RadioGroup("2", "Supervisi"))
    ..add(RadioGroup("3", "Manager"));
  
  List<RadioGroup> NameInstansi = []
    ..add(RadioGroup("1", "Teknisi"))
    ..add(RadioGroup("2", "Supervisi"))
    ..add(RadioGroup("3", "Manager"));

  List<RadioGroup> JobStatus = []
    ..add(RadioGroup("1", "Full Time"))
    ..add(RadioGroup("2", "Part Time"))
    ..add(RadioGroup("3", "Freelance"));

  List<RadioGroup> LengthWork = []
    ..add(RadioGroup("1", "> 1 Tahun"))
    ..add(RadioGroup("2", "> 2 Tahun"))
    ..add(RadioGroup("3", "> 5 Tahun"));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.arrow_back),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("Pinjaman Barang", style: Theme.of(context).textTheme.title),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Container(
                      child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             Container(    
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
                          ),
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "Sesuaikan jumlah pinjaman dan lama masa pinjaman dengan kebutuhanmu",
                            style: CustomText.regular12
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16.5, bottom: 8),
                          child: Text("Asal e-Commerce", style: CustomText.regular12),
                        ),
                        CustomPopupSelect(
                          onChangeText: (counter) {
                            counter;
                          },
                          radioGroup: NameInstansi,
                          title: "Pilih Instansi",
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
                          child: Text("Jenis Produk", style: CustomText.regular12),
                        ),
                        CustomPopupSelect(
                          onChangeText: (counter) {
                            counter;
                          },
                          radioGroup: JobStatus,
                          title: "Pilih Jenis Produk",
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16.0, bottom: 6.0),
                          child: Text("Harga Produk", style: CustomText.regular12),
                        ),
                        TextFormField(
                          onSaved: (val) => _rangeJob = val,
                          decoration: InputDecoration(
                              fillColor: Theme.of(context).accentColor,
                              hintText: 'Masukan harga jual barang', hintStyle: CustomText.regular16,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
                          child: Text("Link Produk yang Dianjurkan"),
                        ),
                        TextFormField(
                          decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                            ),
                            hintText: 'Paste link penjualan produk', hintStyle: CustomText.regular16,
                          ),
                        ),
                        // TextFormField(
                        //   onSaved: (val) => _gaji = val,
                        //   decoration: InputDecoration(
                        //       fillColor: Theme.of(context).accentColor,
                        //       hintText: 'Paste link penjualan produk', hintStyle: CustomText.regular16,),
                        // ),
                        Container(
                          margin: EdgeInsets.only(top: 16.0, bottom: 6.0),
                          child: Text("Catatan Khusus"),
                        ),
                        TextFormField(
                          onSaved: (val) => _gaji = val,
                          decoration: InputDecoration(
                              fillColor: Theme.of(context).accentColor,
                              hintText: 'Cth: Warna atau yang lainnya', hintStyle: CustomText.regular16,),
                        ),
                        Container(
                          
                          margin: EdgeInsets.only(top: 16.5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffdddddd),
                                  borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(8.0), topLeft: const Radius.circular(8.0)),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Center(
                                  child: Ink(
                                    padding: EdgeInsets.only(top:20, bottom: 20),
                                    
                                    child: IconButton(
                                      icon: Icon(Icons.chevron_left),
                                      color: Colors.grey,
                                      onPressed: () {},
                                    ),
                                  ),
                                )
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.62,
                                color: Color(0xffededed),
                                child: Center(
                                  child: Ink(
                                    padding: EdgeInsets.only(top:20, bottom: 21),
                                    decoration: BoxDecoration(
                                      color: Color(0xffededed),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 6),
                                          child: Text("Lama Cicilan", style:CustomText.regular16),
                                        ),
                                        Container(
                                          child: Text("12 Bulan", style:CustomText.regular18),
                                        )
                                        
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                  
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomRight: const Radius.circular(8.0), topRight: const Radius.circular(8.0)),                                          
                                  color: Color(0xffdddddd),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Center(
                                  child: Ink(
                                    padding: EdgeInsets.only(top:20, bottom: 20),
                                    child: IconButton(
                                      icon: Icon(Icons.chevron_right),
                                      color: Colors.grey,
                                      onPressed: () {},
                                    ),
                                  ),
                                )
                              ),
                          
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top:10),
                          child: Text("Estimasi Cicilan Bulanan", style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                        Container(
                          padding: EdgeInsets.only(top:10),
                          child: Text("Angka ini hanya simulasi, hasil akhir bisa berbeda", style:CustomText.regular13),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 100),
                          padding: EdgeInsets.only(top:10),
                          child: Text("RP 312.091",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xfff18314))),
                        )
                        ],
                      )
                    )
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PickmiDetailLoanOfGoods()));
                      },
                      color: Color(0xff096d5c),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "AJUKAN PINJAMAN",
                          textAlign: TextAlign.center,
                          style: CustomText.regular14White,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}