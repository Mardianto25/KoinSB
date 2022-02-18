import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/member_data_saved.dart';
import 'package:intl/intl.dart';
import 'package:flutter_base/style/custom_text.dart';

class DataConfirmation extends StatefulWidget {
  @override
  _DataConfirmationState createState() => _DataConfirmationState();
}

class _DataConfirmationState extends State<DataConfirmation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("Konfirmasi Data Keanggotaan",
              style: Theme.of(context).textTheme.title),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Nomor eKTP",
                                style: CustomText.heading12Grey,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3.0),
                              child: Text(
                                "3201234567890123",
                                style: CustomText.bold13,
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Image.asset(
                            "assets/images/pencil.png",
                            scale: 1,
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text("Nama Lengkap",
                                style: CustomText.heading12Grey),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text("Dimas Tester Sejati",
                                style: CustomText.bold13),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Table(
                        children: [
                          TableRow(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 16.0),
                                  child: Text("Tempat Lahir",
                                      style: CustomText.heading12Grey),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child:
                                      Text("Bogor", style: CustomText.bold13),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 16.0),
                                  child: Text("Tanggal Lahir",
                                      style: CustomText.heading12Grey),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text("26/09/1997",
                                      style: CustomText.bold13),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 16.0),
                                  child: Text("Jenis Kelamin",
                                      style: CustomText.heading12Grey),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text("Laki - laki",
                                      style: CustomText.bold13),
                                )
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 16.0),
                                  child: Text("Agama",
                                      style: CustomText.heading12Grey),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child:
                                      Text("Islam", style: CustomText.bold13),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 16.0),
                                  child: Text("Nama Ibu Kandung",
                                      style: CustomText.heading12Grey),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text("Ibu Dimas",
                                      style: CustomText.bold13),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[],
                            ),
                          ]),
                          TableRow(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 16.0),
                                  child: Text("Status Perkawinan",
                                      style: CustomText.heading12Grey),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child:
                                      Text("Lajang", style: CustomText.bold13),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 16.0),
                                  child: Text("Pendidikan Terakhir",
                                      style: CustomText.heading12Grey),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text("S1", style: CustomText.bold13),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 16.0),
                                  child: Text("Gelar",
                                      style: CustomText.heading12Grey),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child:
                                      Text("S.Kom", style: CustomText.bold13),
                                )
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 16.0),
                                  child: Text("Kontak Darurat",
                                      style: CustomText.heading12Grey),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text("081234567890",
                                      style: CustomText.bold13),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 16.0),
                                  child: Text("Hubungan dengan Kontak Darurat",
                                      style: CustomText.heading12Grey),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text("ORANG TUA",
                                      style: CustomText.bold13),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[],
                            ),
                          ]),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.teal,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Status Tempat Tinggal Sesuai KTP",
                                style: CustomText.heading12Grey,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                "Pribadi",
                                style: CustomText.bold13,
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Image.asset(
                            "assets/images/pencil.png",
                            scale: 1,
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Alamat Sesuai KTP",
                              style: CustomText.heading12Grey,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Jl.Antariksa No.100",
                              style: CustomText.bold13,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "BABAKAN, BOGOR TENGAH, KOTA BOGOR, JAWA BARAT",
                              style: CustomText.bold13,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Status Tempat Tinggal Domisili",
                                  style: CustomText.heading12Grey,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Sewa",
                                  style: CustomText.bold13,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16.0),
                            child: Text(
                              "Alamat Sesuai KTP",
                              style: CustomText.heading12Grey,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Jl.Antariksa No.100",
                              style: CustomText.bold13,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "BABAKAN, BOGOR TENGAH, KOTA BOGOR, JAWA BARAT",
                              style: CustomText.bold13,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.teal,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Jenis Pekerjaan",
                                style: CustomText.heading12Grey,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                "Karyawan Swasta",
                                style: CustomText.bold13,
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Image.asset(
                            "assets/images/pencil.png",
                            scale: 1,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 16.0),
                          child: Text(
                            "Nama Instansi",
                            style: CustomText.heading12Grey,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "PT. HAHA HIHI HUHU HEHE HOHO",
                            style: CustomText.bold13,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 16.0, right: 50.0),
                              child: Text(
                                "Status Pekerjaan",
                                style: CustomText.heading12Grey,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                "Tetap",
                                style: CustomText.bold13,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 16.0),
                              child: Text(
                                "Lama Bekerja",
                                style: CustomText.heading12Grey,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                "1 - 3 Tahun",
                                style: CustomText.bold13,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.teal,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Spesimen Tanda Tangan",
                              style: CustomText.heading12Grey,
                            ),
                          ),
                          Container(
                            child: Image.asset(
                              "assets/images/pencil.png",
                              scale: 1,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.white,
                    child: MaterialButton(
                      onPressed: () {
                        _showDialog();
                      },
                      color: Color(0xff727272),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "KONFIRMASI",
                          textAlign: TextAlign.center,
                          style: CustomText.bold14White,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Konfirmasi Data Keanggotaan"),
          content: new Text("Apakah data yang dimasukan sudah semuanya benar?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Belum", style: CustomText.bold12Grey,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                "Ya",
                style: CustomText.bold12Teal,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MemberDataSaved()));
              },
            ),
          ],
        );
      },
    );
  }
}
