import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/general_get/general_get_bloc.dart';
import 'package:flutter_base/bloc/general_get/general_get_event.dart';
import 'package:flutter_base/bloc/general_get/general_get_state.dart';
import 'package:flutter_base/bloc/personal_data/get_personal_data_bloc.dart';
import 'package:flutter_base/bloc/personal_data/personal_data_bloc.dart';
import 'package:flutter_base/bloc/personal_data/personal_data_event.dart';
import 'package:flutter_base/bloc/personal_data/personal_data_state.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';
import 'package:flutter_base/model/content/personal_data.dart';
import 'package:flutter_base/model/response/data_personal_response.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/show_data/show_data_page.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/widget/custom_radio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalDataForm extends StatefulWidget {
  String type;

  PersonalDataForm({Key key, @required this.type}) : super(key: key);

  @override
  State<PersonalDataForm> createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<PersonalDataForm> {
  TextEditingController _eKtpController = TextEditingController();
  TextEditingController _agama = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _bornAtController = TextEditingController();
  TextEditingController _matherController = TextEditingController();
  TextEditingController _lastEducation = TextEditingController();
  TextEditingController _degree = TextEditingController();
  TextEditingController _kontakDarurat = TextEditingController();
  TextEditingController _hubunganKontak = TextEditingController();

  final FocusNode _ktpFocus = FocusNode();
  final FocusNode _namaFocus = FocusNode();
  final FocusNode _bornFocus = FocusNode();
  

  ScrollController _arrowsController = ScrollController();

  ScrollController _scrollContainer = ScrollController();
  List<GeneralData> list = List();
  List<GeneralData> listDegree = List();
  List<GeneralData> listEducation = List();
  PersonalDataResponse listData;
  GeneralGetBloc _getBloc;
  // GetPersonalDataBloc _getDataAll;
  String param, _ktpLocal;

  // TextEditingController _matherController = TextEditingController();
  String _dateText = "Pilih tanggal";
  String _statusPerkawinan = "Lajang";
  String _jk = "Laki-laki";

  final format = DateFormat("dd-MM-yyyy");
  // final format = DateFormat("yyyy-MM-dd");

  final formKey = new GlobalKey<FormState>();

  List<RadioModel> sampleData = new List<RadioModel>();
  List<RadioModel> sampleData2 = new List<RadioModel>();

  List<RadioGroup> relationships = []
    ..add(RadioGroup("1", "Saudara"))
    ..add(RadioGroup("2", "Orang Tua"));

  List<String> emergencyContact = [
    'ORANG TUA',
    'SAUDARA',
    'WALI',
  ];

  bool _loading = false;

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
    // _getDataAll = BlocProvider.of<GetPersonalDataBloc>(context);
    _loading = true;
    _getDataPersonal();
    // print(listData);
    Timer timer = new Timer(new Duration(seconds: 3), () {
      print("tes");
      setState(() {
        _loading = false;  
        _eKtpController.text = listData.response.data == null
            ? ""
            : listData.response.data.nomorEktp;
        _fullNameController.text = listData.response.data == null
            ? ""
            : listData.response.data.namaLengkap;
        _bornAtController.text = listData.response.data == null
            ? ""
            : listData.response.data.tempatLahir;
        _dateText = listData.response.data == null
            ? ""
            : listData.response.data.tanggalLahir;
        _agama.text = listData.response.data == null
            ? ""
            : listData.response.data.agama;
        _matherController.text = listData.response.data == null
            ? ""
            : listData.response.data.namaIbuKandung;
        _lastEducation.text = listData.response.data == null
            ? ""
            : listData.response.data.pendidikanTerakhir;
        _degree.text = listData.response.data == null
            ? ""
            : listData.response.data.gelar;
        _kontakDarurat.text = listData.response.data == null
            ? ""
            : listData.response.data.kontakDarurat;
        _hubunganKontak.text = listData.response.data == null
            ? ""
            : listData.response.data.hubunganKontakDarurat;
        });

        if(listData.response.data.jenisKelamin == "Laki-laki"){
          sampleData[0].isSelected =true;
          sampleData[1].isSelected =false;
          
        }else{
          sampleData[0].isSelected =false;          
          sampleData[1].isSelected =true;
        }

        if(listData.response.data.statusPerkawinan == "Lajang"){
          sampleData2[0].isSelected =true;
          sampleData2[1].isSelected =false;
          sampleData2[2].isSelected =false;          
          
        }else if (listData.response.data.statusPerkawinan == "Menikah"){
          sampleData2[0].isSelected =false;          
          sampleData2[1].isSelected =true;
          sampleData2[2].isSelected =false;                    
        }else{
          sampleData2[0].isSelected =false;          
          sampleData2[1].isSelected =false;
          sampleData2[2].isSelected =true; 
        }
      });
    super.initState();
  }
  _getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _ktpLocal = prefs.getString("ktp");
    _eKtpController.text = _ktpLocal;
    print(_ktpLocal);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _onPersonalDataButtonPressed();
    }
  }

  _onPersonalDataButtonPressed() {
    print("bismillah"+_agama.text);
    BlocProvider.of<PersonalDataBloc>(context).add(
      PersonalDataButtonPressed(
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
              gelar: _degree.text,
              kontakDarurat: _kontakDarurat.text,
              hubunganKontakDarurat: _hubunganKontak.text)),
    );
  }

  _getReligion() {
    BlocProvider.of<GeneralGetBloc>(context)
        .add(GetGeneralButtonPressed(choose: "religion"));
  }

  _getDegree() {
    BlocProvider.of<GeneralGetBloc>(context)
        .add(GetGeneralButtonPressed(choose: "degree"));
  }

  _getEducation() {
    BlocProvider.of<GeneralGetBloc>(context)
        .add(GetGeneralButtonPressed(choose: "education"));
  }

  _getDataPersonal() {
    if (widget.type == "data_personal") {
      BlocProvider.of<GetPersonalDataBloc>(context)
          .add(GetPersonalDataButtonPressed(type: "data_personal"));
    }

    if(widget.type == ""){
      _getData();
    }
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
  }
  setParameter() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("personalSimpan", "done");

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalDataBloc, PersonalDataState>(

        listener: (context, state) {
          if (state is PersonalDataLoading){
            loading();
          }
          if (state is PersonalDataFailure) {
            Navigator.pop(context);            
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is PersonalDataUpdateInitial) {
              Navigator.of(context).pop();
              Navigator.push(
              context, MaterialPageRoute(builder: (context) => ShowDataPage()));
            // successEdit();
          }
          if (state is PersonalDataInitial) {
            setParameter();            
            Navigator.of(context).pop();
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => MemberData()));
            // success();
          }
        },
        child: 
          BlocBuilder<GetPersonalDataBloc, PersonalDataState>(
                // bloc: _getDataAll,
                builder: (context, state) {
                  if (state is GetPersonalDataDataLoading) {
                    _loading = true;
                  }
                  if (state is GetPersonalDataDataInitial) {
                    // setState(() {
                      _loading = false;
                      listData = state.dataPersonal;
                                          
                    // });
                    

                    return _loading ? Center(child: CircularProgressIndicator(),) : _buildPage();
                  }

                  if (state is GetPersonalDataDataFailure) {
                    _loading = false;
                    listData = state.dataPersonal;
                    return _loading ? Center(child: CircularProgressIndicator(),): _buildPage();
                    
                    // print(state.error);
                    // return Center(
                    //   child: Text(
                    //     "${state.error}",
                    //     style: TextStyle(color: Colors.red),
                    //   ),
                    // );
                  }
                  //
                },
              )
            
            );
  }

  Widget _buildPage() {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
                            keyboardType: TextInputType.number,
                            enabled: _ktpLocal == null || _ktpLocal.isEmpty ? true : false,                                      
                            controller: _eKtpController,
                            validator: Validator.validateEktp,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE6C125)),),
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
                            textInputAction: TextInputAction.done,                                           
                            controller: _fullNameController,
                            
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE6C125)),),
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
                            textInputAction: TextInputAction.done,                                    
                            controller: _bornAtController,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE6C125)),),
                                hintText: 'Masukkan tempat lahir'),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0),
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
                                  maxTime: DateTime.now(),
                                  onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                setState(() {
                                  _dateText =
                                      format.format(date).toString();
                                });
                                print('confirm ${date.day}');
                              },
                                  currentTime: DateTime(2000, 6, 6),
                                  locale: LocaleType.id);
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(
                                      color: Colors.teal,
                                      width: 2.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 16,
                                        left: 16,
                                        bottom: 16),
                                    child: Text(
                                      _dateText,
                                      style: CustomText.regular16,
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: 16),
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
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0),
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
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return new Container(
                                  margin:
                                      EdgeInsets.only(right: 15.0),
                                  child: InkWell(
                                    //highlightColor: Colors.red,
                                    splashColor: Colors.blueAccent,
                                    onTap: () {
                                      setState(() {
                                        sampleData.forEach(
                                            (element) => element
                                                .isSelected = false);
                                        sampleData[index].isSelected =
                                            true;
                                        _jk = sampleData[index]
                                            .buttonText;
                                      });
                                    },

                                    child: RadioItem(
                                        sampleData[index],
                                        150.0,
                                        18.0),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0),
                            child: Text(
                              "Agama",
                              style: CustomText.regular12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showDialog(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 16, right: 0, top: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.teal,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0))),
                              child: TextFormField(
                                enabled: false,
                                controller: _agama,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    fillColor: Colors.teal,
                                    hintText: 'Pilih Agama'),
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
                                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE6C125)),),
                                hintText:
                                    'Masukkan nama ibu kandung'),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0),
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
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return new Container(
                                  margin:
                                      EdgeInsets.only(right: 15.0),
                                  child: InkWell(
                                    //highlightColor: Colors.red,
                                    splashColor: Colors.blueAccent,
                                    onTap: () {
                                      setState(() {
                                        sampleData2.forEach(
                                            (element) => element
                                                .isSelected = false);
                                        sampleData2[index]
                                            .isSelected = true;
                                        _statusPerkawinan =
                                            sampleData2[index]
                                                .buttonText;
                                      });
                                    },
                                    child: RadioItem(
                                        sampleData2[index],
                                        95.0,
                                        13.0),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0),
                            child: Text(
                              "Pendidikan Terakhir",
                              style: CustomText.regular12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showDialogEducation(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 16, right: 0, top: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.teal,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0))),
                              child: TextFormField(
                                enabled: false,
                                controller: _lastEducation,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    fillColor: Colors.teal,
                                    hintText:
                                        'Pilih Pendidikan Terakhir'),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0),
                            child: Text(
                              "Gelar",
                              style: CustomText.regular12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showDialogDegree(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 16, right: 0, top: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.teal,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0))),
                              child: TextFormField(
                                enabled: false,
                                controller: _degree,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      ),
                                    ),
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
                            keyboardType: TextInputType.number,                                      
                            controller: _kontakDarurat,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE6C125)),),
                                hintText:
                                    'Masukkan nomor kontak darurat'),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0),
                            child: Text(
                              "Hubungan dengan Kontak Darurat",
                              style: CustomText.regular12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showDialogKontak(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 70),
                              padding: EdgeInsets.only(
                                  left: 16, right: 0, top: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.teal,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0))),
                              child: TextFormField(
                                enabled: false,
                                controller: _hubunganKontak,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    fillColor: Colors.teal,
                                    hintText:
                                    'Pilih Hubungan'),
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
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 10.0),
                child: MaterialButton(
                  onPressed: () {

                    if(_eKtpController.text.length >= 16 && _fullNameController.text.length >= 2 &&
                    _bornAtController.text.length >= 2 &&
                    _dateText.length >= 9 && _jk.length >= 0 && _agama.text.length >=2 && _matherController.text.length >=2 &&
                    _statusPerkawinan.length >= 2 && _degree.text.length >=2 && _lastEducation.text.length >= 2 &&
                    _kontakDarurat.text.length >= 2 && _hubunganKontak.text.length >=2){
                      _submit();
                    }else{
                      null;
                    }
                  },
                  color: _eKtpController.text.length >= 16 && _fullNameController.text.length >= 2 &&
                    _bornAtController.text.length >= 2 &&
                    _dateText.length >= 9 && _jk.length >= 0 && _agama.text.length >=2 && _matherController.text.length >=2 &&
                    _statusPerkawinan.length >= 2 && _degree.text.length >=2 && _lastEducation.text.length >= 2 &&
                    _kontakDarurat.text.length >= 2 && _hubunganKontak.text.length >=2 ? Color(0xff096d5c) : Color(0xff727272),
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

  void _showDialog(BuildContext context) {
    // flutter defined function
    _getReligion();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Pilih Agama"),
          content: BlocBuilder<GeneralGetBloc, GeneralGetState>(
              bloc: _getBloc,
              builder: (context, state) {
                // if (state is GeneralGetEmpty){
                //   return Center(                     child: CircularProgressIndicator(                       valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),                     ),                   );
                // }
                if (state is GeneralGetLoading) {
                  return Center(                     child: CircularProgressIndicator(                       valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),                     ),                   );
                }
                if (state is GeneralGetInitial) {
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
                            child: list.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return _buildCell(context, index);
                                    },
                                    shrinkWrap: true,
                                  )),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is GeneralGetFailure) {
                  // print(state.error);
                  return Center(
                    child: Text(
                      "${state.error}",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
              }),
          actions: <Widget>[
            FlatButton(
              child: Text("Batal", style: TextStyle(color: Color(0xff096D5C)),),
              onPressed: () {
                list = [];
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
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _agama.text = list[index].name;
            list = [];
                      
          });
        },
        title: Text(list[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Pilih Gelar"),
          content: BlocBuilder<GeneralGetBloc, GeneralGetState>(
              bloc: _getBloc,
              builder: (context, state) {
                // if (state is GeneralGetEmpty){
                //   return Center(                     child: CircularProgressIndicator(                       valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),                     ),                   );
                // }
                if (state is GeneralGetLoading) {
                  return Center(                     child: CircularProgressIndicator(                       valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),                     ),                   );
                }
                if (state is GeneralGetInitial) {
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
                            child: listDegree.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: listDegree.length,
                                    itemBuilder: (context, index) {
                                      return _buildCellDegree(context, index);
                                    },
                                    shrinkWrap: true,
                                  )),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is GeneralGetFailure) {
                  // print(state.error);
                  return Center(
                    child: Text(
                      "${state.error}",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
              }),
          actions: <Widget>[
            FlatButton(
              child: Text("Batal", style: TextStyle(color: Color(0xff096D5C)),),
              onPressed: () {
                listDegree = [];
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
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _degree.text = listDegree[index].name;
            listDegree = [];
                      
          });
        },
        title: Text(listDegree[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  success(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
            title: new Text('Data pribadi berhasil disimpan'),
            content: new Text('Success'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("personalSimpan", "done");
                  Navigator.of(context).pop();
                  Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MemberData()));
                }, 
                child: FlatButton(child: Text("OK", style: TextStyle(color: Colors.teal),),),
              ),
            ],
          ),
    ) ??
    false;
  }

  successEdit(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
            title: new Text('Data pribadi berhasil diupdate'),
            content: new Text('Success'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShowDataPage()));
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

  void _showDialogEducation(BuildContext context) {
    // flutter defined function
    _getEducation();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Pilih Pendidikan"),
          content: BlocBuilder<GeneralGetBloc, GeneralGetState>(
              bloc: _getBloc,
              builder: (context, state) {
                // if (state is GeneralGetEmpty){
                //   return Center(                     child: CircularProgressIndicator(                       valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),                     ),                   );
                // }
                if (state is GeneralGetLoading) {
                  return Center(                     child: CircularProgressIndicator(                       valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),                     ),                   );
                }
                if (state is GeneralGetInitial) {
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
                            child: listEducation.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: listEducation.length,
                                    itemBuilder: (context, index) {
                                      return _buildCellEducation(
                                          context, index);
                                    },
                                    shrinkWrap: true,
                                  )),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is GeneralGetFailure) {
                  // print(state.error);
                  return Center(
                    child: Text(
                      "${state.error}",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
              }),
          actions: <Widget>[
            FlatButton(
              child: Text("Batal", style: TextStyle(color: Color(0xff096D5C)),),
              onPressed: () {
                listEducation = [];
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
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _lastEducation.text = listEducation[index].name;
            listEducation = [];
                      
          });
        },
        title: Text(listEducation[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Pilih Hubungan Dengan Kontak"),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.46,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: emergencyContact.isEmpty
                        ? Center(
                            child: Text(
                              "No Data",
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : Scrollbar(
                            child: ListView.builder(
                            controller: _scrollContainer,
                            itemCount: emergencyContact.length,
                            itemBuilder: (context, index) {
                              return _buildCellKontak(context, index);
                            },
                            shrinkWrap: true,
                          )),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Batal", style: TextStyle(color: Color(0xff096D5C)),),
              onPressed: () {
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
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _hubunganKontak.text = emergencyContact[index];
                      
          });
        },
        title: Text(emergencyContact[index],
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

}