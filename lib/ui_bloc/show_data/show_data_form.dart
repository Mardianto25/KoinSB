import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/show_data/get_data_spesimen_bloc..dart';
import 'package:flutter_base/bloc/show_data/post_data_bloc.dart';
import 'package:flutter_base/bloc/show_data/show_data_bloc.dart';
import 'package:flutter_base/bloc/show_data/show_data_event.dart';
import 'package:flutter_base/bloc/show_data/show_data_state.dart';
import 'package:flutter_base/model/response/show.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/address_data/address_data_page.dart';
import 'package:flutter_base/ui_bloc/job_data/job_data_page.dart';
import 'package:flutter_base/ui_bloc/member_data_save/member_data_save_page.dart';
import 'package:flutter_base/ui_bloc/personal_data/personal_data_page.dart';
import 'package:flutter_base/ui_bloc/spesimen/spesimen_page.dart';
import 'package:flutter_base/ui_bloc/update_address_data/update_address_data_page.dart';
import 'package:flutter_base/ui_bloc/update_job_data/update_job_data_page.dart';
import 'package:flutter_base/ui_bloc/update_personal_data/update_personal_data_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ShowDataForm extends StatefulWidget {
  @override
  _ShowDataFormState createState() => _ShowDataFormState();
}

class _ShowDataFormState extends State<ShowDataForm> {
  ShowDataBloc _getDataAll;
  GetSpesimenBloc _getDataSpesimen;

  ShowData list;
  String _publicId;

  @override
  void initState() {
    // TODO: implement initState
    _getDataAll = BlocProvider.of<ShowDataBloc>(context);
    // _getDataSpesimen = BlocProvider.of<GetSpesimenBloc>(context);
    _getPublicId();
    super.initState();
  }
  _getPublicId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _publicId = prefs.getString('publicId');
    _getData();
    
  }
  _getData() {
    BlocProvider.of<ShowDataBloc>(context).add(
      ShowDataButtonPressed(
        publicId: ""
      )
    );
  }

  // _getSpesimen() {
  //   BlocProvider.of<GetSpesimenBloc>(context).add(
  //     ShowSpesimenButtonPressed(
  //     )
  //   );
  // }

  _onButtonPressed() {
      BlocProvider.of<PostDataBloc>(context).add(
        PostDataButtonPressed(
         publicId: ""
          // imei: "35540407445625"
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostDataBloc, ShowDataState>(
      listener: (context, state) {
        if (state is PostDataLoading){
          loading();
        }
        if (state is PostDataFailure) {
          Navigator.pop(context);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is PostDataInitial) {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_){
                return MemberSavePage();
              }
          ));
          // success();
          // BlocProvider.of<RegisterHandleBloc>(context).add(RegisterSuccess());
        }
       
      },
        
    child:
      BlocBuilder<ShowDataBloc, ShowDataState>(
        bloc: _getDataAll,
        builder: (context, state) {
          if (state is ShowDataLoading){
            return LoadingIndicator();
          }
          if (state is ShowDataInitial){
            list=state.showAll.response.data;
            String _base64;
            _base64 = state.spesimen.response.data.image;
            Uint8List bytes = base64.decode(_base64.replaceAll("data:image/png;base64, ", ""));
            return 
            Container(
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
                                    list.dataPersonal.nomorEktp,
                                    style: CustomText.bold13,
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("typePersonal", "data_personal");
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_){
                                      return PersonalDataPage(type: "data_personal");
                                    }
                                ));
                              },
                              child: Container(
                                child: Image.asset(
                                  "assets/images/pencil.png",
                                  scale: 1,
                                ),
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
                                child: Text(list.dataPersonal.namaLengkap,
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
                                          Text(list.dataPersonal.tempatLahir, style: CustomText.bold13),
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
                                      child: Text(list.dataPersonal.tanggalLahir,
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
                                      child: Text(list.dataPersonal.jenisKelamin,
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
                                          Text(list.dataPersonal.agama, style: CustomText.bold13),
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
                                      child: Text(list.dataPersonal.namaIbuKandung,
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
                                          Text(list.dataPersonal.statusPerkawinan, style: CustomText.bold13),
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
                                      child: Text(list.dataPersonal.pendidikanTerakhir, style: CustomText.bold13),
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
                                          Text(list.dataPersonal.gelar, style: CustomText.bold13),
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
                                      child: Text(list.dataPersonal.kontakDarurat,
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
                                      child: Text(list.dataPersonal.hubunganKontakDarurat,
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
                                    list.address.statusRumah == null ? "Pribadi" : list.address.statusRumah,
                                    style: CustomText.bold13,
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("typeAddress", "address");
                                prefs.setString("second_address", "second_address");
                                Navigator.pop(context);                                
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_){
                                      return AddressDataPage(type: "address",);
                                    }
                                ));
                              },
                              child: Container(
                                child: Image.asset(
                                  "assets/images/pencil.png",
                                  scale: 1,
                                ),
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
                                  list.address.alamatLengkap == null ? "" : list.address.alamatLengkap,
                                  style: CustomText.bold13,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "${list.address.kelurahan}, ${list.address.kecamatan}, ${list.address.kotaKabupaten}, ${list.address.provinsi}",
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
                                      list.address.statusRumah == null ? "Milik Sendiri" : list.address.statusRumah,
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
                                  list.address.alamatLengkap,
                                  style: CustomText.bold13,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "${list.address.kelurahan}, ${list.address.kecamatan}, ${list.address.kotaKabupaten}, ${list.address.provinsi}",
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
                                    list.jobs.jenisPekerjaan,
                                    style: CustomText.bold13,
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("typeJobs", "jobs");
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_){
                                        return JobDataPage(type: "jobs",);
                                      }
                                  ));
                              },
                              child: Container(
                                child: Image.asset(
                                  "assets/images/pencil.png",
                                  scale: 1,
                                ),
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
                                list.jobs.namaInstansi,
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
                                    list.jobs.statusPekerjaan,
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
                                    list.jobs.lamaBekerja,
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
                              bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Spesimen Tanda Tangan",
                                  style: CustomText.heading12Grey,
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () async{
                              //     Navigator.pop(context);                                
                              //     Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //         builder: (_){
                              //           return SpesimenPage(type: "update",);
                              //         }
                              //     ));
                              //   },
                              //   child: Container(
                              //     child: Image.asset(
                              //       "assets/images/pencil.png",
                              //       scale: 1,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: new Image.memory(bytes),
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
                          color:Colors.teal,
                          //  Color(0xff727272),
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
            );// This trailing comma makes auto-formatting nicer for build methods.
          }
          if(state is ShowDataFailure){
            return Center(
              child: Text("${state.error}"),
            );
          }
        }
        
      ) 
    );
  }

  success(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
            title: new Text('Data disimpan'),
            content: new Text('Success'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_){
                        return MemberSavePage();
                      }
                  ));
                }, 
                child: FlatButton(child: Text("OK", style: TextStyle(color: Colors.teal),),),
              ),
            ],
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
                Navigator.pop(context);
               _onButtonPressed();
              },
            ),
          ],
        );
      },
    );
  }
}
