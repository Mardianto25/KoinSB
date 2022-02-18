import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/general_get/general_get_bloc.dart';
import 'package:flutter_base/bloc/general_get/general_get_event.dart';
import 'package:flutter_base/bloc/general_get/general_get_state.dart';
import 'package:flutter_base/bloc/personal_data/get_personal_data_bloc.dart';
import 'package:flutter_base/bloc/personal_data/personal_data_event.dart';
import 'package:flutter_base/bloc/personal_data/personal_data_state.dart';
import 'package:flutter_base/bloc/update_personal_data/update_personal_data_bloc.dart';
import 'package:flutter_base/bloc/update_personal_data/update_personal_data_event.dart';
import 'package:flutter_base/bloc/update_personal_data/update_personal_data_state.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';
import 'package:flutter_base/model/content/personal_data.dart';
import 'package:flutter_base/model/response/data_personal_response.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/widget/custom_radio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class UpdatePersonalDataForm extends StatefulWidget {
  @override
  State<UpdatePersonalDataForm> createState() => _UpdatePersonalDataFormState();

}

class _UpdatePersonalDataFormState extends State<UpdatePersonalDataForm> {
  TextEditingController _eKtpController = TextEditingController();
  TextEditingController _agama = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _bornAtController = TextEditingController();
  TextEditingController _matherController = TextEditingController();
  TextEditingController _lastEducation = TextEditingController();
  TextEditingController _degree = TextEditingController();
  TextEditingController _kontakDarurat = TextEditingController();
  TextEditingController _hubunganKontak = TextEditingController();
  ScrollController _scrollContainer = ScrollController();
  List<GeneralData> list = List();
  List<GeneralData> listDegree = List();
  List<GeneralData> listEducation = List();

  PersonalDataResponse listData;
  GeneralGetBloc _getBloc;
  GetPersonalDataBloc _getDataAll;

  // TextEditingController _matherController = TextEditingController();
  String _dateText = "Pilih tanggal";
  String _statusPerkawinan, _jk;
  // final format = DateFormat("dd-MM-yyyy");
  final format = DateFormat("yyyy-MM-dd");
  
  final formKey = new GlobalKey<FormState>();

  List<RadioModel> sampleData = new List<RadioModel>();
  List<RadioModel> sampleData2 = new List<RadioModel>();

  List<RadioGroup> relationships = []
    ..add(RadioGroup("1", "Saudara"))
    ..add(RadioGroup("2", "Orang Tua"));


  List<String> emergencyContact = [
    'ORANG TUA',
    'WALI',
  ];

  @override
  void initState() {
    // TODO: implement initState
    sampleData.add(new RadioModel(true, 'Laki-laki'));
    sampleData.add(new RadioModel(false, 'Perempuan'));

    sampleData2.add(new RadioModel(true, 'Lajang'));
    sampleData2.add(new RadioModel(false, 'Menikah'));
    sampleData2.add(new RadioModel(false, 'Janda / Duda'));
    // _getReligion();
    _getBloc = BlocProvider.of<GeneralGetBloc>(context);
    _getDataAll = BlocProvider.of<GetPersonalDataBloc>(context);
    _getDataPersonal();
    super.initState();
  }

  void _submit() {
    print("tes");
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _onUpdatePersonalDataButtonPressed();
    }
  }
  _onUpdatePersonalDataButtonPressed() {
    // print("bismillah"+_data.namaIbuKandung);
    BlocProvider.of<UpdatePersonalDataBloc>(context).add(
      UpdatePersonalDataButtonPressed(
        dataPersonal: PersonalDataContent(
          namaIbuKandung: _matherController.text,
          namaLengkap: _fullNameController.text,
          nomorEktp: _eKtpController.text,
          tempatLahir: _bornAtController.text,
          agama: _agama.text,
          tanggalLahir: _dateText.toString(),
          statusPerkawinan: _statusPerkawinan,
          jenisKelamin: _jk,
          pendidikanTerakhir: _lastEducation.text,
          gelar: _degree.text
        )
      ),
    );
  }

  _getReligion() {
    BlocProvider.of<GeneralGetBloc>(context).add(
      GetGeneralButtonPressed(
        choose: "religion"
      )
    );
  }

  _getDegree() {
    BlocProvider.of<GeneralGetBloc>(context).add(
      GetGeneralButtonPressed(
        choose: "degree"
      )
    );
  }
  
  _getEducation() {
    BlocProvider.of<GeneralGetBloc>(context).add(
      GetGeneralButtonPressed(
        choose: "education"
      )
    );
  }

  _getDataPersonal() {
    BlocProvider.of<GetPersonalDataBloc>(context).add(
      GetPersonalDataButtonPressed(
        type: "data_personal"
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdatePersonalDataBloc, UpdatePersonalDataState>(
      listener: (context, state) {
        if (state is UpdatePersonalDataFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is UpdatePersonalDataInitial) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => MemberData()
          ));
        }
      
      },
      child: 
      BlocBuilder<GetPersonalDataBloc, PersonalDataState>(
      bloc: _getDataAll,
      builder: (context, state) {
        // if(state is GetPersonalDataDataEmpty){
        //   return LoadingIndicator();
        // }
        if(state is GetPersonalDataDataLoading){
          return LoadingIndicator();
        }
        if (state is GetPersonalDataDataInitial){
          listData=state.dataPersonal;
          _eKtpController.text=listData.response.data.nomorEktp;
          _fullNameController.text=listData.response.data.namaLengkap;
          _bornAtController.text=listData.response.data.tempatLahir;
          _dateText=listData.response.data.tanggalLahir;
          _agama.text=listData.response.data.agama;
          _matherController.text=listData.response.data.namaIbuKandung;
          _lastEducation.text=listData.response.data.pendidikanTerakhir;
          _degree.text=listData.response.data.gelar;
          return Container(
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
                                  padding: EdgeInsets.only(top: 0.0),
                                  child: Text(
                                    "Nomor eKTP",
                                    style: CustomText.regular12,
                                  ),
                                ),
                                TextFormField(
                                  controller: _eKtpController,
                                  validator: Validator.validateEktp,
                                  decoration: InputDecoration(
                                      fillColor: Theme.of(context).primaryColor,
                                      labelStyle: CustomText.regular16,
                                      hintText: 'Masukkan nomor eKTP'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Nama Lengkap",
                                    style: CustomText.regular12,
                                  ),
                                ),
                                TextFormField(
                                  validator: (String value) {
                                    if(value.isEmpty || value ==null){
                                      return "Silahkan isi nama anda";
                                    }
                                  },
                                  controller: _fullNameController,
                                  decoration: InputDecoration(
                                      fillColor: Theme.of(context).accentColor,
                                      hintText: 'Masukkan nama lengkap'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Tempat Lahir",
                                    style: CustomText.regular12,
                                  ),
                                ),
                                TextFormField(
                                  controller: _bornAtController,
                                  validator: (String value) {
                                    if(value.isEmpty || value ==null){
                                      return "Silahkan isi tempat lahir anda";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Theme.of(context).accentColor,
                                      hintText: 'Masukkan tempat lahir'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    "Tanggal Lahir",
                                    style: CustomText.regular12,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(1900, 3, 5),
                                        maxTime: DateTime.now(), onChanged: (date) {
                                      print('change $date');
                                    }, onConfirm: (date) {
                                      setState(() {
                                        _dateText = format.format(date).toString();

                                      });
                                      print('confirm ${date.day}');
                                    },
                                        currentTime: DateTime(2000, 6, 6),
                                        locale: LocaleType.id);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(
                                            color: Colors.teal,
                                            width: 2.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 16, left: 16, bottom: 16),
                                          child: Text(
                                            _dateText,
                                            style: CustomText.regular16,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 16),
                                          child: Image.asset(
                                            "assets/images/right_arrow.png",
                                            scale: 2.2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    "Jenis Kelamin",
                                    style: CustomText.regular12,
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: sampleData.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return new Container(
                                        margin: EdgeInsets.only(right: 15.0),
                                        child: InkWell(
                                          //highlightColor: Colors.red,
                                          splashColor: Colors.blueAccent,
                                          onTap: () {
                                            setState(() {
                                              sampleData.forEach((element) =>
                                                  element.isSelected = false);
                                              sampleData[index].isSelected = true;
                                              _jk=sampleData[index].buttonText;
                                            });
                                          },

                                          child: RadioItem(
                                              sampleData[index], 150.0, 18.0),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    "Agama",
                                    style: CustomText.regular12,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _showDialog(context);
                                  } ,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.teal,
                                        width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                    child: TextFormField(  
                                      enabled: false,                                  
                                      controller: _agama,
                                      decoration: InputDecoration.collapsed(
                                          fillColor: Colors.teal,
                                          hintText: 'Masukkan Agama'),
                                    ),
                                  ),
                                ),
                                // CustomPopupSelect(
                                //   radioGroup: religions,
                                //   title: "Pilih Agama",
                                // ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Nama Ibu Kandung",
                                    style: CustomText.regular12,
                                  ),
                                ),
                                TextFormField(
                                  controller: _matherController,
                                  decoration: InputDecoration(
                                      fillColor: Theme.of(context).accentColor,
                                      hintText: 'Masukkan nama ibu kandung'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    "Status Perkawinan",
                                    style: CustomText.regular12,
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: sampleData2.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return new Container(
                                        margin: EdgeInsets.only(right: 15.0),
                                        child: InkWell(
                                          //highlightColor: Colors.red,
                                          splashColor: Colors.blueAccent,
                                          onTap: () {
                                            setState(() {
                                              sampleData2.forEach((element) =>
                                                  element.isSelected = false);
                                              sampleData2[index].isSelected = true;
                                              _statusPerkawinan=sampleData2[index].buttonText;
                                            });
                                          },
                                          child: RadioItem(
                                              sampleData2[index], 95.0, 13.0),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    "Pendidikan Terakhir",
                                    style: CustomText.regular12,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _showDialogEducation(context);
                                  } ,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.teal,
                                        width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                    child: TextFormField(  
                                      enabled: false,                                  
                                      controller: _lastEducation,
                                      decoration: InputDecoration.collapsed(
                                          fillColor: Colors.teal,
                                          hintText: 'Pilih Pendidikan Terakhir'),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    "Gelar",
                                    style: CustomText.regular12,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _showDialogDegree(context);
                                  } ,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.teal,
                                        width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                    child: TextFormField(  
                                      enabled: false,                                  
                                      controller: _degree,
                                      decoration: InputDecoration.collapsed(
                                          fillColor: Colors.teal,
                                          hintText: 'Pilih Gelar'),
                                    ),
                                  ),
                                ),
                                
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Kontak Darurat",
                                    style: CustomText.regular12,
                                  ),
                                ),
                                TextFormField(
                                  controller: _kontakDarurat,
                                  decoration: InputDecoration(
                                      fillColor: Colors.greenAccent,
                                      hintText: 'Masukkan nomor kontak darurat'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    "Hubungan dengan Kontak Darurat",
                                    style: CustomText.regular12,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _showDialogKontak(context);
                                  } ,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 70),
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.teal,
                                        width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                    child: TextFormField(  
                                      enabled: false,                                  
                                      controller: _hubunganKontak,
                                      decoration: InputDecoration.collapsed(
                                          fillColor: Colors.teal,
                                          hintText: 'Pilih Hubungan'),
                                    ),
                                  ),
                                ),
                              ],
                            ))),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
                      child: MaterialButton(
                        onPressed: () {
                          _submit();
                        },
                        color: Color(0xff727272),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "LANJUT",
                            textAlign: TextAlign.center,
                            style: CustomText.regular14White,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          );
        }

        if(state is GetPersonalDataDataFailure){
                // print(state.error);
          return Center(
            child: Text("${state.error}", style: TextStyle(color: Colors.red),),
          );
        }
        // 
      },
    ),
    );
    
  }

   void _showDialog(BuildContext context) {
    // flutter defined function
    _getReligion();
    showDialog(
      
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Pilih Agama"),
          content: BlocBuilder<GeneralGetBloc, GeneralGetState>(
            bloc: _getBloc,
            builder: (context, state) {
              // if (state is GeneralGetEmpty){
              //   return LoadingIndicator();
              // }
              if (state is GeneralGetLoading){
                return LoadingIndicator();
              }
              if (state is GeneralGetInitial){
                list.addAll(state.general.data);
                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.46,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                            child: list.isEmpty ?
                              Center(
                                child: Text("No Data", style: TextStyle(color: Colors.red),),
                              ): ListView.builder(
                              controller: _scrollContainer,
                              itemCount: list.length,
                              itemBuilder: (context, index){
                                return _buildCell(context, index);
                              },
                              shrinkWrap: true,
                            ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              if(state is GeneralGetFailure){
                // print(state.error);
                return Center(
                  child: Text("${state.error}", style: TextStyle(color: Colors.red),),
                );
              }
              
            }
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Batal"),
              onPressed: (){
                list=[];
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCell(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          _agama.text=list[index].name;
          list=[];
      },
        title: Text(list[index].name, style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
      ),
    );
  }

  void _showDialogDegree(BuildContext context) {
    // flutter defined function
    _getDegree();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Pilih Gelar"),
          content: BlocBuilder<GeneralGetBloc, GeneralGetState>(
            bloc: _getBloc,
            builder: (context, state) {
              // if (state is GeneralGetEmpty){
              //   return LoadingIndicator();
              // }
              if (state is GeneralGetLoading){
                return LoadingIndicator();
              }
              if (state is GeneralGetInitial){
                listDegree.addAll(state.general.data);
                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.46,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                            child: listDegree.isEmpty ?
                              Center(
                                child: Text("No Data", style: TextStyle(color: Colors.red),),
                              ): ListView.builder(
                              controller: _scrollContainer,
                              itemCount: listDegree.length,
                              itemBuilder: (context, index){
                                return _buildCellDegree(context, index);
                              },
                              shrinkWrap: true,
                            ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              if(state is GeneralGetFailure){
                // print(state.error);
                return Center(
                  child: Text("${state.error}", style: TextStyle(color: Colors.red),),
                );
              }
              
            }
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Batal"),
              onPressed: (){
                listDegree=[];
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCellDegree(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          _degree.text=listDegree[index].name;
          listDegree=[];
      },
        title: Text(listDegree[index].name, style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
      ),
    );
  }

  void _showDialogEducation(BuildContext context) {
    // flutter defined function
    _getEducation();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Pilih Pendidikan"),
          content: BlocBuilder<GeneralGetBloc, GeneralGetState>(
            bloc: _getBloc,
            builder: (context, state) {
              // if (state is GeneralGetEmpty){
              //   return LoadingIndicator();
              // }
              if (state is GeneralGetLoading){
                return LoadingIndicator();
              }
              if (state is GeneralGetInitial){
                listEducation.addAll(state.general.data);
                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.46,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                            child: listEducation.isEmpty ?
                              Center(
                                child: Text("No Data", style: TextStyle(color: Colors.red),),
                              ): ListView.builder(
                              controller: _scrollContainer,
                              itemCount: listEducation.length,
                              itemBuilder: (context, index){
                                return _buildCellEducation(context, index);
                              },
                              shrinkWrap: true,
                            ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              if(state is GeneralGetFailure){
                // print(state.error);
                return Center(
                  child: Text("${state.error}", style: TextStyle(color: Colors.red),),
                );
              }
              
            }
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Batal"),
              onPressed: (){
                listEducation=[];
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCellEducation(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          _lastEducation.text=listEducation[index].name;
          listEducation=[];
      },
        title: Text(listEducation[index].name, style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
      ),
    );
  }

  void _showDialogKontak(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Pilih Hubungan Dengan Kontak"),
          content: 
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.46,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                        child: emergencyContact.isEmpty ?
                          Center(
                            child: Text("No Data", style: TextStyle(color: Colors.red),),
                          ): ListView.builder(
                          controller: _scrollContainer,
                          itemCount: emergencyContact.length,
                          itemBuilder: (context, index){
                            return _buildCellKontak(context, index);
                          },
                          shrinkWrap: true,
                        ),
                    ),
                  ),
                ],
              ),
            ),
    
          actions: <Widget>[
            FlatButton(
              child: Text("Batal"),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCellKontak(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          _hubunganKontak.text=emergencyContact[index];
          emergencyContact=[];
      },
        title: Text(emergencyContact[index], style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
      ),
    );
  }

  

}
