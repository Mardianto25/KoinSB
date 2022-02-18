import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/address_data/address_data_bloc.dart';
import 'package:flutter_base/bloc/address_data/address_data_event.dart';
import 'package:flutter_base/bloc/address_data/address_data_state.dart';
import 'package:flutter_base/bloc/general_get/general_get_event.dart';
import 'package:flutter_base/bloc/general_get/general_get_param_bloc.dart';
import 'package:flutter_base/bloc/general_get/general_get_state.dart';
import 'package:flutter_base/bloc/update_address_data/update_address_data_bloc.dart';
import 'package:flutter_base/bloc/update_address_data/update_address_data_event.dart';
import 'package:flutter_base/bloc/update_address_data/update_address_data_state.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';
import 'package:flutter_base/model/content/address_data.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/show_data/show_data_page.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/widget/custom_radio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UpdateAddressDataForm extends StatefulWidget {
  @override
  State<UpdateAddressDataForm> createState() => _UpdateAddressDataFormState();

}

class _UpdateAddressDataFormState extends State<UpdateAddressDataForm> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _provinceController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _kecamatanController = TextEditingController();
  TextEditingController _kelurahanController = TextEditingController();
  
  String id_provinsi, id_kecamatan, id_kota, id_kelurahan, _tempatTinggal;
  ScrollController _scrollContainer = ScrollController();
  
  GeneralGetParamBloc _getBloc;
  List<GeneralData> list = List();
  List<GeneralData> listCity = List();
  List<GeneralData> listKelurahan = List();
  List<GeneralData> listKecamatan = List();
  
  List<RadioModel> homeStatus = new List<RadioModel>();


  List<RadioGroup> provinces = []
    ..add(RadioGroup("1", "Jawa Barat"))
    ..add(RadioGroup("2", "Jawa Tengah"))
    ..add(RadioGroup("3", "Jawa Timur"));

  List<RadioGroup> regencies = []
    ..add(RadioGroup("1", "Bogor"))
    ..add(RadioGroup("2", "Bekasi"))
    ..add(RadioGroup("3", "Bandung"));

  List<RadioGroup> districts = []
    ..add(RadioGroup("1", "Ciawi"))
    ..add(RadioGroup("2", "Citeureup"))
    ..add(RadioGroup("3", "Cibinong"));

  List<RadioGroup> locations = []
    ..add(RadioGroup("1", "Pandansari"))
    ..add(RadioGroup("2", "Sindangsari"));

  List<RadioGroup> buildingOwnins = []
    ..add(RadioGroup("1", "Milik Sendiri"))
    ..add(RadioGroup("2", "Sewa"));

  List<RadioModel> homeStatus2 = new List<RadioModel>();

  List<String> sampleData = [
    'Lorem Ipsum 1',
    'Lorem Ipsum 2',
    'Lorem Ipsum 3',
    'Lorem Ipsum 4',
    'Lorem Ipsum 5',
  ];
  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    homeStatus.add(new RadioModel(true, 'Pribadi'));
    homeStatus.add(new RadioModel(false, 'Sewa'));

    homeStatus2.add(new RadioModel(true, 'Milik Sendiri'));
    homeStatus2.add(new RadioModel(false, 'Sewa'));
    _getBloc = BlocProvider.of<GeneralGetParamBloc>(context);
    
    super.initState();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _onUpdateAddressDataButtonPressed();
    }
  }
  _onUpdateAddressDataButtonPressed() {
    // print("bismillah"+_data.namaIbuKandung);
    BlocProvider.of<UpdateAddressDataBloc>(context).add(
      UpdateAddressDataButtonPressed(
        dataAddress: AddressDataContent(
          statusRumah: _tempatTinggal,
          alamatLengkap: _addressController.text,
          kodePos: _postalCodeController.text,
          provinsi: _provinceController.text,
          kotaKabupaten: _cityController.text,
          kecamatan: _kecamatanController.text,
          kelurahan: _kelurahanController.text,
          isKtpAddress: isSwitched==true ? "YA" : "TIDAK",
          publicId: ""
        )
      ),
    );
  }

  _getProvince() {
    BlocProvider.of<GeneralGetParamBloc>(context).add(
      GetGeneralParamsButtonPressed(
        choose: "province",
        id: ""
      )
    );
  }
  
  _getCity() {
    BlocProvider.of<GeneralGetParamBloc>(context).add(
      GetGeneralParamsButtonPressed(
        choose: "city",
        id: id_provinsi
      )
    );
  }

  _getKecamatan() {
    BlocProvider.of<GeneralGetParamBloc>(context).add(
      GetGeneralParamsButtonPressed(
        choose: "district",
        id: id_kota
      )
    );
  }

  _getKelurahan() {
    BlocProvider.of<GeneralGetParamBloc>(context).add(
      GetGeneralParamsButtonPressed(
        choose: "village",
        id: id_kecamatan
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateAddressDataBloc, UpdateAddressDataState>(
      listener: (context, state) {
        if (state is UpdateAddressDataFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is UpdateAddressDataInitial) {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ShowDataPage()
          ));
          // BlocProvider.of<UpdateAddressDataHandleBloc>(context).add(UpdateAddressDataSuccess());
        }
       
      },
      child: BlocBuilder<UpdateAddressDataBloc, UpdateAddressDataState>(
        builder: (context, state) {
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
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    "Alamat Rumah Berdasarkan eKTP",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text("Status Tempat Tinggal"),
                                ),
                                Container(
                                  height: 50.0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeStatus.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return new Container(
                                        margin: EdgeInsets.only(right: 16.0),
                                        child: InkWell(
                                          //highlightColor: Colors.red,
                                          splashColor: Colors.blueAccent,
                                          onTap: () {
                                            setState(() {
                                              homeStatus.forEach((element) =>
                                                  element.isSelected = false);
                                              homeStatus[index].isSelected = true;
                                              _tempatTinggal=homeStatus[index].buttonText;
                                            });
                                          },

                                          child: RadioItem(
                                              homeStatus[index], 150.0, 18.0),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text("Alamat Lengkap", style: CustomText.regular12,),
                                ),
                                TextFormField(
                                  controller: _addressController,
                                  decoration: InputDecoration(
                                      fillColor: Theme.of(context).primaryColor,
                                      hintText: 'Cth: Jl.Antariksa No.xx'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text("Provinsi", style: CustomText.regular12,),
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
                                      controller: _provinceController,
                                      decoration: InputDecoration.collapsed(
                                          fillColor: Colors.teal,
                                          hintText: 'Pilih Provinsi'),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text("Kota/Kabupaten", style: CustomText.regular12,),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _showDialogCity(context);
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
                                      controller: _cityController,
                                      decoration: InputDecoration.collapsed(
                                          fillColor: Colors.teal,
                                          hintText: 'Pilih Kota/Kabupaten'),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text("Kecamatan", style: CustomText.regular12,),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _showDialogKecamatan(context);
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
                                      controller: _kecamatanController,
                                      decoration: InputDecoration.collapsed(
                                          fillColor: Colors.teal,
                                          hintText: 'Pilih Kecamatan'),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text("Kelurahan", style: CustomText.regular12,),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _showDialogKelurahan(context);
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
                                      controller: _kelurahanController,
                                      decoration: InputDecoration.collapsed(
                                          fillColor: Colors.teal,
                                          hintText: 'Pilih Kelurahan'),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text("Kode Pos", style: CustomText.regular12,),
                                ),
                                Container(
                                  child: TextFormField(
                                    controller: _postalCodeController,
                                    decoration: InputDecoration(
                                        fillColor: Theme.of(context).primaryColor,
                                        hintText: 'Masukkan kode pos'),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                    top: 20.0,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 15.0, top: 8.0, bottom: 8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Alamat Domisili sama dengan alamat KTP",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Switch(
                                          value: isSwitched,
                                          onChanged: (value) {
                                            setState(() {
                                              isSwitched = value;
                                            });
                                          },
                                          activeTrackColor: Colors.lightGreen,
                                          activeColor: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
                                  child: isSwitched == true ? _domisili(): _detailFalse(),
                                )
                                
                              ],
                            ))),
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
        },
      ),
    );
  }

  Widget _domisili() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Text(
            "Alamat Domisili/Tempat Tinggal Sehari-hari",
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text("Status Tempat Tinggal", style: CustomText.regular12,),
        ),
        Container(
          height: 50.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeStatus2.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                margin: EdgeInsets.only(right: 16.0),
                child: InkWell(
                  //highlightColor: Colors.red,
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      homeStatus2.forEach((element) =>
                          element.isSelected = false);
                      homeStatus2[index].isSelected = true;
                      
                    });
                  },

                  child: RadioItem(
                      homeStatus2[index], 150.0, 18.0),
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Text("Alamat Lengkap", style: CustomText.regular12,),
        ),
        TextFormField(
          decoration: InputDecoration(
              fillColor: Theme.of(context).primaryColor,
              hintText: 'Cth: Jl.Antariksa No.xx'),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text("Provinsi", style: CustomText.regular12,),
        ),
        CustomPopupSelect(
          radioGroup: provinces,
          title: "Pilih Provinsi",
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text("Kota/Kabupaten", style: CustomText.regular12,),
        ),
        CustomPopupSelect(
          radioGroup: regencies,
          title: "Pilih Kota/Kabupaten",
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text("Kecamatan", style: CustomText.regular12,),
        ),
        CustomPopupSelect(
          radioGroup: districts,
          title: "Pilih Kecamatan",
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text("Kelurahan", style: CustomText.regular12,),
        ),
        CustomPopupSelect(
          radioGroup: locations,
          title: "Pilih Kelurahan",
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Text("Kode Pos", style: CustomText.regular12,),
        ),
        Container(
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height *
                  0.1),
          child: TextFormField(
            decoration: InputDecoration(
                fillColor: Theme.of(context).primaryColor,
                hintText: 'Masukkan kode pos'),
          ),
        ),
      ],
    );
  }

  Widget _detailFalse(){
    return Container(child: Text(""),);
  }

  void _showDialog(BuildContext context) {
    // flutter defined function
    _getProvince();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Pilih Provinsi"),
          content: BlocBuilder<GeneralGetParamBloc, GeneralGetState>(
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
                          removeTop: true,
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
          _provinceController.text=list[index].name;
          id_provinsi=list[index].iD;
          _cityController.text="";
          _kecamatanController.text="";
          _kelurahanController.text="";
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

  void _showDialogCity(BuildContext context) {
    // flutter defined function
    _getCity();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Pilih Kota"),
          content: BlocBuilder<GeneralGetParamBloc, GeneralGetState>(
            bloc: _getBloc,
            builder: (context, state) {
              // if (state is GeneralGetEmpty){
              //   return LoadingIndicator();
              // }
              if (state is GeneralGetLoading){
                return LoadingIndicator();
              }
              if (state is GeneralGetInitial){
                listCity.addAll(state.general.data);
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
                            child: listCity.isEmpty ?
                              Center(
                                child: Text("No Data", style: TextStyle(color: Colors.red),),
                              ): ListView.builder(
                              controller: _scrollContainer,
                              itemCount: listCity.length,
                              itemBuilder: (context, index){
                                return _buildCellCity(context, index);
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
                listCity=[];
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCellCity(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
      ),
        child: ListTile(
          onTap: () {
            Navigator.pop(context);
            _cityController.text=listCity[index].name;
            id_kota=listCity[index].iD;
            _kecamatanController.text="";
            _kelurahanController.text="";
            listCity=[];
        },
        title: Text(listCity[index].name, style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
      ),
    );
  }


  void _showDialogKecamatan(BuildContext context) {
    // flutter defined function
    _getKecamatan();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Pilih Kecamatan"),
          content: BlocBuilder<GeneralGetParamBloc, GeneralGetState>(
            bloc: _getBloc,
            builder: (context, state) {
              // if (state is GeneralGetEmpty){
              //   return LoadingIndicator();
              // }
              if (state is GeneralGetLoading){
                return LoadingIndicator();
              }
              if (state is GeneralGetInitial){
                listKecamatan.addAll(state.general.data);
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
                            child: listKecamatan.isEmpty ?
                              Center(
                                child: Text("No Data", style: TextStyle(color: Colors.red),),
                              ): ListView.builder(
                              controller: _scrollContainer,
                              itemCount: listKecamatan.length,
                              itemBuilder: (context, index){
                                return _buildCellKecamatan(context, index);
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
                listKecamatan=[];
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCellKecamatan(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          _kecamatanController.text=listKecamatan[index].name;
          id_kecamatan=listKecamatan[index].iD;
          _kelurahanController.text="";
          listKecamatan=[];
      },
        title: Text(listKecamatan[index].name, style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
      ),
    );
  }

  void _showDialogKelurahan(BuildContext context) {
    // flutter defined function
    _getKelurahan();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Pilih Kelurahan"),
          content: BlocBuilder<GeneralGetParamBloc, GeneralGetState>(
            bloc: _getBloc,
            builder: (context, state) {
              // if (state is GeneralGetEmpty){
              //   return LoadingIndicator();
              // }
              if (state is GeneralGetLoading){
                return LoadingIndicator();
              }
              if (state is GeneralGetInitial){
                listKelurahan.addAll(state.general.data);
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
                            child: listKelurahan.isEmpty ?
                              Center(
                                child: Text("No Data", style: TextStyle(color: Colors.red),),
                              ): ListView.builder(
                              controller: _scrollContainer,
                              itemCount: listKelurahan.length,
                              itemBuilder: (context, index){
                                return _buildCellKelurahan(context, index);
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
                listKelurahan=[];
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCellKelurahan(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          _kelurahanController.text=listKelurahan[index].name;
          listKelurahan=[];
      },
        title: Text(listKelurahan[index].name, style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
      ),
    );
  }


}
