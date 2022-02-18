import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/address_data/address_data_bloc.dart';
import 'package:flutter_base/bloc/address_data/address_data_event.dart';
import 'package:flutter_base/bloc/address_data/address_data_state.dart';
import 'package:flutter_base/bloc/address_data/get_address_data_bloc.dart';
import 'package:flutter_base/bloc/address_data/second_address_data_bloc.dart';
import 'package:flutter_base/bloc/general_get/general_get_event.dart';
import 'package:flutter_base/bloc/general_get/general_get_param_bloc.dart';
import 'package:flutter_base/bloc/general_get/general_get_state.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';
import 'package:flutter_base/model/content/address_data.dart';
import 'package:flutter_base/model/response/address_data_response.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/show_data/show_data_page.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_base/widget/custom_popup_select.dart';
import 'package:flutter_base/widget/custom_radio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressDataForm extends StatefulWidget {
  String type;

  AddressDataForm({Key key, @required this.type}) : super(key: key);

  @override
  State<AddressDataForm> createState() => _AddressDataFormState();
}

class _AddressDataFormState extends State<AddressDataForm> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _provinceController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _kecamatanController = TextEditingController();
  TextEditingController _kelurahanController = TextEditingController();
  TextEditingController _cariController = TextEditingController();
  TextEditingController _cariKotaController = TextEditingController();
  TextEditingController _cariKecamatanController = TextEditingController();
  TextEditingController _cariKelurahanController = TextEditingController();
    


  String id_provinsi, id_kecamatan, id_kota, id_kelurahan;
  String _tempatTinggal = "Pribadi";

  TextEditingController _address2Controller = TextEditingController();
  TextEditingController _postalCode2Controller = TextEditingController();
  TextEditingController _province2Controller = TextEditingController();
  TextEditingController _city2Controller = TextEditingController();
  TextEditingController _kecamatan2Controller = TextEditingController();
  TextEditingController _kelurahan2Controller = TextEditingController();
  TextEditingController _cari2Controller = TextEditingController();
  

  String id_provinsi2, id_kecamatan2, id_kota2, id_kelurahan2;
  String _tempatTinggal2 = "Milik Sendiri";
  ScrollController _scrollContainer = ScrollController();

  GeneralGetParamBloc _getBloc;
  GetAddressDataBloc _getDataAll;
  String param;

  List<GeneralData> list = List();
  List<GeneralData> listCity = List();
  List<GeneralData> listKelurahan = List();
  List<GeneralData> listKecamatan = List();
  AddressDataResponse listAddress;

  List<GeneralData> list2 = List();
  List<GeneralData> _searchProvinsi = List();
  List<GeneralData> _searchKota = List();
  List<GeneralData> _searchKecamatan = List();
  List<GeneralData> _searchKelurahan = List();
  
  
  
  List<GeneralData> listCity2 = List();
  List<GeneralData> listKelurahan2 = List();
  List<GeneralData> listKecamatan2 = List();
  AddressDataResponse listAddress2;

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
    _getDataAll = BlocProvider.of<GetAddressDataBloc>(context);
    _getDataAddress();

    Timer timer = new Timer(new Duration(seconds: 3), () {
      print("tes");
        setState(() {
          _addressController.text = listAddress.response.data == null
              ? ""
              : listAddress.response.data.alamatLengkap;
          _provinceController.text = listAddress.response.data == null
              ? ""
              : listAddress.response.data.provinsi;
          _cityController.text = listAddress.response.data == null
              ? ""
              : listAddress.response.data.kotaKabupaten;
          _kecamatanController.text =
              listAddress.response.data == null
                  ? ""
                  : listAddress.response.data.kecamatan;
          _kelurahanController.text =
              listAddress.response.data == null
                  ? ""
                  : listAddress.response.data.kelurahan;
          _postalCodeController.text =
              listAddress.response.data == null
                  ? ""
                  : listAddress.response.data.kodePos;

          _address2Controller.text =
              listAddress2.response.data == null
                  ? ""
                  : listAddress2.response.data.alamatLengkap;
          _province2Controller.text =
              listAddress2.response.data == null
                  ? ""
                  : listAddress2.response.data.provinsi;
          _city2Controller.text = listAddress2.response.data == null
              ? ""
              : listAddress2.response.data.kotaKabupaten;
          _kecamatan2Controller.text =
              listAddress2.response.data == null
                  ? ""
                  : listAddress2.response.data.kecamatan;
          _kelurahan2Controller.text =
              listAddress2.response.data == null
                  ? ""
                  : listAddress2.response.data.kelurahan;
          _postalCode2Controller.text =
              listAddress2.response.data == null
                  ? ""
                  : listAddress2.response.data.kodePos;
          if(listAddress.response.data.statusRumah == "Pribadi"){
            homeStatus[0].isSelected = true;
            homeStatus[1].isSelected = false;
            
          }else{
            homeStatus[0].isSelected = false;
            homeStatus[1].isSelected = true;
          }

          if(listAddress2.response.data.statusRumah == "Milik Sendiri"){
            homeStatus[0].isSelected = true;
            homeStatus[1].isSelected = false;
            
          }else{
            homeStatus[0].isSelected = false;
            homeStatus[1].isSelected = true;
          }
        });
        
      });

    super.initState();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _onAddressDataButtonPressed();
      _onSecondAddressDataButtonPressed();
    }
  }

  _onAddressDataButtonPressed() {
    String dataChange;
    if (isSwitched == true) {
      dataChange = "YA";
    } else {
      dataChange = "TIDAK";
    }
    print(dataChange);
    BlocProvider.of<AddressDataBloc>(context).add(
      AddressDataButtonPressed(
          dataAddress: AddressDataContent(
              alamatLengkap: _addressController.text,
              statusRumah: _tempatTinggal,
              kodePos: _postalCodeController.text,
              provinsi: _provinceController.text,
              kotaKabupaten: _cityController.text,
              kecamatan: _kecamatanController.text,
              kelurahan: _kelurahanController.text,
              isKtpAddress: dataChange,
              publicId: "")),
    );
  }

  _onSecondAddressDataButtonPressed() {
    print("bismillah");
    BlocProvider.of<SecondAddressDataBloc>(context).add(
      SecondAddressButtonPressed(
          dataAddress: AddressDataContent(
              alamatLengkap: isSwitched == true
                  ? _addressController.text
                  : _address2Controller.text,
              statusRumah:
                  isSwitched == true ? _tempatTinggal : _tempatTinggal2,
              kodePos: isSwitched == true
                  ? _postalCodeController.text
                  : _postalCode2Controller.text,
              provinsi: isSwitched == true
                  ? _provinceController.text
                  : _province2Controller.text,
              kotaKabupaten: isSwitched == true
                  ? _cityController.text
                  : _city2Controller.text,
              kecamatan: isSwitched == true
                  ? _kecamatanController.text
                  : _kecamatan2Controller.text,
              kelurahan: isSwitched == true
                  ? _kelurahanController.text
                  : _kelurahan2Controller.text,
              isKtpAddress: "TIDAK",
              publicId: ""
        )),
    );
  }

  _getProvince() {
    BlocProvider.of<GeneralGetParamBloc>(context)
        .add(GetGeneralParamsButtonPressed(choose: "province", id: ""));
  }

  _getCity() {
    BlocProvider.of<GeneralGetParamBloc>(context)
        .add(GetGeneralParamsButtonPressed(choose: "city", id: id_provinsi));
  }

  _getKecamatan() {
    BlocProvider.of<GeneralGetParamBloc>(context)
        .add(GetGeneralParamsButtonPressed(choose: "district", id: id_kota));
  }

  _getKelurahan() {
    BlocProvider.of<GeneralGetParamBloc>(context).add(
        GetGeneralParamsButtonPressed(choose: "village", id: id_kecamatan));
  }

  _getCity2() {
    BlocProvider.of<GeneralGetParamBloc>(context)
        .add(GetGeneralParamsButtonPressed(choose: "city", id: id_provinsi2));
  }

  _getKecamatan2() {
    BlocProvider.of<GeneralGetParamBloc>(context)
        .add(GetGeneralParamsButtonPressed(choose: "district", id: id_kota2));
  }

  _getKelurahan2() {
    BlocProvider.of<GeneralGetParamBloc>(context).add(
        GetGeneralParamsButtonPressed(choose: "village", id: id_kecamatan2));
  }

  _getDataAddress() {
    if (widget.type == "address") {
      BlocProvider.of<GetAddressDataBloc>(context)
          .add(GetAddressDataButtonPressed(type: "address"));
    }
  }

  void onSearchTextChanged(String text) async {
    // list = [];
    _getProvince();
    _searchProvinsi.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    setState(() {
      list.forEach((items) {
        if (items.name.toLowerCase().contains(text)){
          _searchProvinsi.add(items);
          print(_searchProvinsi.length);
        }
          
        
      });
    });   
    // setState(() {});
  }

  void onSearchKota(String text) async {
    // list = [];
    _getCity();
    _searchKota.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    setState(() {
      listCity.forEach((items) {
        if (items.name.toLowerCase().contains(text)){
          _searchKota.add(items);
        }
          
        
      });
    });   
    // setState(() {});
  }

  void onSearchKecamatan(String text) async {
    // list = [];
    _getKecamatan();
    _searchKecamatan.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    setState(() {
      listKecamatan.forEach((items) {
        if (items.name.toLowerCase().contains(text)){
          _searchKecamatan.add(items);
        }
          
        
      });
    });   
    // setState(() {});
  }

  void onSearchKelurahan(String text) async {
    // list = [];
    _getKelurahan();
    _searchKelurahan.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    setState(() {
      listKelurahan.forEach((items) {
        if (items.name.toLowerCase().contains(text)){
          _searchKelurahan.add(items);
        }
          
        
      });
    });   
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<AddressDataBloc, AddressDataState>(
            listener: (context, state) {
              if (state is AddressDataLoading){
                // loading();
              }
              if (state is AddressDataFailure) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (state is AddressDataInitial) {
                // Navigator.pop(context);
                // success();
                // BlocProvider.of<AddressDataHandleBloc>(context).add(AddressDataSuccess());
              }

              if (state is AddressDataUpdateInitial) {
                // successEdit();
                // Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ShowDataPage()));
              }
            },
          ),
          BlocListener<SecondAddressDataBloc, AddressDataState>(
            listener: (context, state) {
              if (state is AddressDataLoading){
                // loading();
                success2();
              }
              if (state is SecondAddressDataFailure) {
                Navigator.pop(context);            
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (state is SecondAddressDataInitial) {
                setParameter();                
                Navigator.pop(context);
                Navigator.push(
                context, MaterialPageRoute(builder: (context) => MemberData()));
                // success();
                // BlocProvider.of<AddressDataHandleBloc>(context).add(AddressDataSuccess());
              }

              if (state is SecondAddressDataUpdateInitial) {
                Navigator.pop(context);
                Navigator.push(
                context, MaterialPageRoute(builder: (context) => ShowDataPage()));
                // successEdit();
                
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) => ShowDataPage()
                // ));
              }
            },
          ),
        ],
        child: widget.type == "address"
            ? BlocBuilder<GetAddressDataBloc, AddressDataState>(
                bloc: _getDataAll,
                builder: (context, state) {
                  if (state is GetAddressDataDataLoading) {
                    return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                    ),
                  );
                  }

                  // if(state is GetSecondAddressDataDataInitial){
                  //   listAddress2=state.dataAddress;
                  //   print("tes $listAddress2");
                  // }

                  if (state is GetAddressDataDataInitial) {
                    listAddress2 = state.secondAddress;
                    listAddress = state.dataAddress;

                    

                    return Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 20.0),
                              child: Container(
                                  child: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 10.0),
                                            child: Text(
                                              "Alamat Rumah Berdasarkan eKTP",
                                              style: TextStyle(fontSize: 12.0),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            child:
                                                Text("Status Tempat Tinggal"),
                                          ),
                                          Container(
                                            height: 50.0,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: homeStatus.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return new Container(
                                                  margin: EdgeInsets.only(
                                                      right: 16.0),
                                                  child: InkWell(
                                                    //highlightColor: Colors.red,
                                                    splashColor:
                                                        Colors.blueAccent,
                                                    onTap: () {
                                                      setState(() {
                                                        homeStatus.forEach(
                                                            (element) => element
                                                                    .isSelected =
                                                                false);
                                                        homeStatus[index]
                                                            .isSelected = true;
                                                        _tempatTinggal =
                                                            homeStatus[index]
                                                                .buttonText;
                                                      });
                                                    },

                                                    child: RadioItem(
                                                        homeStatus[index],
                                                        150.0,
                                                        18.0),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Text(
                                              "Alamat Lengkap",
                                              style: CustomText.regular12,
                                            ),
                                          ),
                                          TextFormField(
                                            controller: _addressController,
                                            decoration: InputDecoration(
                                                focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xffE6C125)),),
                                                hintText:
                                                    'Cth: Jl.Antariksa No.xx'),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            child: Text(
                                              "Provinsi",
                                              style: CustomText.regular12,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _showDialog(context, "");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 16, right: 0, top: 3),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.teal,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                              child: TextFormField(
                                                enabled: false,
                                                controller: _provinceController,
                                                decoration: InputDecoration(
                                                    suffixIcon: GestureDetector(
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    fillColor: Colors.teal,
                                                    hintText: 'Pilih Provinsi'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            child: Text(
                                              "Kota/Kabupaten",
                                              style: CustomText.regular12,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _showDialogCity(context, "");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 16, right: 0, top: 3),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.teal,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                              child: TextFormField(
                                                enabled: false,
                                                controller: _cityController,
                                                decoration: InputDecoration(
                                                    suffixIcon: GestureDetector(
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    fillColor: Colors.teal,
                                                    hintText:
                                                        'Pilih Kota/Kabupaten'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            child: Text(
                                              "Kecamatan",
                                              style: CustomText.regular12,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _showDialogKecamatan(context, "");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 16, right: 0, top: 3),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.teal,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                              child: TextFormField(
                                                enabled: false,
                                                controller:
                                                    _kecamatanController,
                                                decoration: InputDecoration(
                                                    suffixIcon: GestureDetector(
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    fillColor: Colors.teal,
                                                    hintText:
                                                        'Pilih Kecamatan'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            child: Text(
                                              "Kelurahan",
                                              style: CustomText.regular12,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _showDialogKelurahan(context, "");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 16, right: 0, top: 3),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.teal,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                              child: TextFormField(
                                                enabled: false,
                                                controller:
                                                    _kelurahanController,
                                                decoration: InputDecoration(
                                                    suffixIcon: GestureDetector(
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    fillColor: Colors.teal,
                                                    hintText:
                                                        'Pilih Kelurahan'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Text(
                                              "Kode Pos",
                                              style: CustomText.regular12,
                                            ),
                                          ),
                                          Container(
                                            child: TextFormField(
                                              controller: _postalCodeController,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                  focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0xffE6C125)),),
                                                  hintText:
                                                      'Masukkan kode pos'),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.teal,
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            width: double.infinity,
                                            margin: EdgeInsets.only(
                                              top: 20.0,
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 15.0,
                                                  top: 8.0,
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    "Alamat Domisili sama dengan alamat KTP",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 16),
                                                    child: Switch(
                                                      value: isSwitched,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isSwitched = value;
                                                        });
                                                      },
                                                      activeTrackColor:
                                                          Colors.lightGreen,
                                                      activeColor: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1),
                                            child: isSwitched == false
                                                ? _domisili()
                                                : _detailFalse(),
                                          )
                                        ],
                                      ))),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 16.0, right: 16.0, bottom: 16.0),
                                child: MaterialButton(
                                  onPressed: () {
                                     if(_tempatTinggal.length >=2 && _addressController.text.length >= 2 && _provinceController.text.length >= 2 &&
                                      _cityController.text.length >= 2 && _kelurahanController.text.length >=2 && _kecamatanController.text.length >=2 && 
                                      _postalCodeController.text.length >= 2) {
                                        _submit();

                                      }else{
                                        null;
                                      }
                                  },
                                  color: _tempatTinggal.length >=2 && _addressController.text.length >= 2 && _provinceController.text.length >= 2 &&
                              _cityController.text.length >= 2 && _kelurahanController.text.length >=2 && _kecamatanController.text.length >=2 && 
                              _postalCodeController.text.length >= 2 ? Color(0xff096d5c): Color(0xff727272),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
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
                  if (state is GetAddressDataDataFailure) {
                    return Center(
                      child: Text("${state.error}"),
                    );
                  }
                },
              )
            : Container(
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
                                      padding: EdgeInsets.only(bottom: 10.0),
                                      child: Text(
                                        "Alamat Rumah Berdasarkan eKTP",
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text("Status Tempat Tinggal"),
                                    ),
                                    Container(
                                      height: 50.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: homeStatus.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return new Container(
                                            margin:
                                                EdgeInsets.only(right: 16.0),
                                            child: InkWell(
                                              //highlightColor: Colors.red,
                                              splashColor: Colors.blueAccent,
                                              onTap: () {
                                                setState(() {
                                                  homeStatus.forEach(
                                                      (element) => element
                                                          .isSelected = false);
                                                  homeStatus[index].isSelected =
                                                      true;
                                                  _tempatTinggal =
                                                      homeStatus[index]
                                                          .buttonText;
                                                });
                                              },

                                              child: RadioItem(
                                                  homeStatus[index],
                                                  150.0,
                                                  18.0),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "Alamat Lengkap",
                                        style: CustomText.regular12,
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _addressController,
                                      decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffE6C125)),),
                                          hintText: 'Cth: Jl.Antariksa No.xx'),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text(
                                        "Provinsi",
                                        style: CustomText.regular12,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _showDialog(context, "");
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
                                          controller: _provinceController,
                                          decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              fillColor: Colors.teal,
                                              hintText: 'Pilih Provinsi'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text(
                                        "Kota/Kabupaten",
                                        style: CustomText.regular12,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _showDialogCity(context, "");
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
                                          controller: _cityController,
                                          decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              fillColor: Colors.teal,
                                              hintText: 'Pilih Kota/Kabupaten'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text(
                                        "Kecamatan",
                                        style: CustomText.regular12,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _showDialogKecamatan(context, "");
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
                                          controller: _kecamatanController,
                                          decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              fillColor: Colors.teal,
                                              hintText: 'Pilih Kecamatan'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text(
                                        "Kelurahan",
                                        style: CustomText.regular12,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _showDialogKelurahan(context, "");
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
                                          controller: _kelurahanController,
                                          decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              fillColor: Colors.teal,
                                              hintText: 'Pilih Kelurahan'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "Kode Pos",
                                        style: CustomText.regular12,
                                      ),
                                    ),
                                    Container(
                                      child: TextFormField(
                                        controller: _postalCodeController,
                                        keyboardType: TextInputType.number,

                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Color(0xffE6C125)),),
                                            hintText: 'Masukkan kode pos'),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      width: double.infinity,
                                      margin: EdgeInsets.only(
                                        top: 20.0,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 15.0, top: 8.0, bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Alamat Domisili sama dengan alamat KTP",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: Switch(
                                                value: isSwitched,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isSwitched = value;
                                                  });
                                                },
                                                activeTrackColor:
                                                    Colors.lightGreen,
                                                activeColor: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1),
                                      child: isSwitched == false
                                          ? _domisili()
                                          : _detailFalse(),
                                    )
                                  ],
                                ))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 16.0),
                          child: MaterialButton(
                            onPressed: () {
                              if(_tempatTinggal.length >=2 && _addressController.text.length >= 2 && _provinceController.text.length >= 2 &&
                              _cityController.text.length >= 2 && _kelurahanController.text.length >=2 && _kecamatanController.text.length >=2 && 
                              _postalCodeController.text.length >= 2) {

                                _submit();

                              }else{
                                null;
                              }
                            },
                            color: _tempatTinggal.length >=2 && _addressController.text.length >= 2 && _provinceController.text.length >= 2 &&
                              _cityController.text.length >= 2 && _kelurahanController.text.length >=2 && _kecamatanController.text.length >=2 && 
                              _postalCodeController.text.length >= 2 ? Color(0xff096d5c): Color(0xff727272),
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
              ));
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
          child: Text("Status Tempat Tinggal"),
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
                      homeStatus2
                          .forEach((element) => element.isSelected = false);
                      homeStatus2[index].isSelected = true;
                      _tempatTinggal2 = homeStatus2[index].buttonText;
                    });
                  },

                  child: RadioItem(homeStatus2[index], 150.0, 18.0),
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            "Alamat Lengkap",
            style: CustomText.regular12,
          ),
        ),
        TextFormField(
          controller: _address2Controller,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffE6C125)),),
              hintText: 'Cth: Jl.Antariksa No.xx'),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            "Provinsi",
            style: CustomText.regular12,
          ),
        ),
        GestureDetector(
          onTap: () {
            _showDialog2(context, "dua");
          },
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 0, top: 3),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: TextFormField(
              enabled: false,
              controller: _province2Controller,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ),
                  fillColor: Colors.teal,
                  hintText: 'Pilih Provinsi'),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            "Kota/Kabupaten",
            style: CustomText.regular12,
          ),
        ),
        GestureDetector(
          onTap: () {
            _showDialogCity2(context, "dua");
          },
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 0, top: 3),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: TextFormField(
              enabled: false,
              controller: _city2Controller,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ),
                  fillColor: Colors.teal,
                  hintText: 'Pilih Kota/Kabupaten'),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            "Kecamatan",
            style: CustomText.regular12,
          ),
        ),
        GestureDetector(
          onTap: () {
            _showDialogKecamatan2(context, "dua");
          },
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 0, top: 3),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: TextFormField(
              enabled: false,
              controller: _kecamatan2Controller,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ),
                  fillColor: Colors.teal,
                  hintText: 'Pilih Kecamatan'),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            "Kelurahan",
            style: CustomText.regular12,
          ),
        ),
        GestureDetector(
          onTap: () {
            _showDialogKelurahan2(context, "dua");
          },
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 0, top: 3),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: TextFormField(
              enabled: false,
              controller: _kelurahan2Controller,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ),
                  fillColor: Colors.teal,
                  hintText: 'Pilih Kelurahan'),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            "Kode Pos",
            style: CustomText.regular12,
          ),
        ),
        Container(
          child: TextFormField(
            controller: _postalCode2Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE6C125)),),
                hintText: 'Masukkan kode pos'),
          ),
        ),
      ],
    );
  }

  Widget _detailFalse() {
    return Container(
      child: Text(""),
    );
  }

  void _showDialog(BuildContext context, param) {
    // flutter defined function
    _getProvince();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Column(
            children: <Widget>[
              Text("Pilih Provinsi"),
              Container(
                child: TextFormField(
                  controller: _cariController,
                  onChanged: (value){
                    setState(() {
                      onSearchTextChanged(value);
                                          
                    });
                  },
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE6C125)),),
                      hintText: 'Cari ...'),
                ),
              )
            ],
          ),
          content: BlocBuilder<GeneralGetParamBloc, GeneralGetState>(
              bloc: _getBloc,
              builder: (context, state) {
                // if (state is GeneralGetEmpty){
                //   return LoadingIndicator();
                // }
                if (state is GeneralGetLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                    ),
                  );
                }
                if (state is GeneralGetInitial) {
                  if(_cariController.text.isEmpty){
                    _searchProvinsi.clear();
                    list.clear();                                       
                    list.addAll(state.general.data);
                  }else{
                    list.clear();                   
                    list.addAll(_searchProvinsi);
                  }

                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.46,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _searchProvinsi.length !=0 || _cariController.text.isNotEmpty ? 
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: _searchProvinsi.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: _searchProvinsi.length,
                                    itemBuilder: (context, index) {
                                      return _buildCellSearch(context, index);
                                    },
                                    shrinkWrap: true,
                                  )),
                          ),
                        )
                        :
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
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
                _cariController.text="";
                _searchProvinsi.clear();
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
            _provinceController.text = list[index].name;
            id_provinsi = list[index].iD;
            _cityController.text = "";
            _kecamatanController.text = "";
            _kelurahanController.text = "";
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

  Widget _buildCellSearch(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _provinceController.text = _searchProvinsi[index].name;
            id_provinsi = _searchProvinsi[index].iD;
            _cityController.text = "";
            _kecamatanController.text = "";
            _kelurahanController.text = "";
            _searchProvinsi = [];
                      
          });
        },
        title: Text(_searchProvinsi[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  void _showDialog2(BuildContext context, param) {
    // flutter defined function
    _getProvince();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Pilih Provinsi"),
          content: BlocBuilder<GeneralGetParamBloc, GeneralGetState>(
              bloc: _getBloc,
              builder: (context, state) {
                // if (state is GeneralGetEmpty){
                //   return LoadingIndicator();
                // }
                if (state is GeneralGetLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                    ),
                  );
                }
                if (state is GeneralGetInitial) {
                  list2.addAll(state.general.data);

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
                            child: list2.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: list2.length,
                                    itemBuilder: (context, index) {
                                      return _buildCell2(context, index);
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
                list2 = [];
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCell2(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _province2Controller.text = list2[index].name;
            id_provinsi2 = list2[index].iD;
            _city2Controller.text = "";
            _kecamatan2Controller.text = "";
            _kelurahan2Controller.text = "";
            list2 = [];
                      
          });
        },
        title: Text(list2[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  void _showDialogCity(BuildContext context, param) {
    // flutter defined function
    _getCity();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Column(
            children: <Widget>[
              Text("Pilih Kota"),
              Container(
                child: TextFormField(
                  controller: _cariKotaController,
                  onChanged: (value){
                    setState(() {
                      onSearchKota(value);
                                          
                    });
                  },
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE6C125)),),
                      hintText: 'Cari ...'),
                ),
              )
            ],
          ),
          content: BlocBuilder<GeneralGetParamBloc, GeneralGetState>(
              bloc: _getBloc,
              builder: (context, state) {
                // if (state is GeneralGetEmpty){
                //   return LoadingIndicator();
                // }
                if (state is GeneralGetLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                    ),
                  );
                }
                if (state is GeneralGetInitial) {
                  if(_cariKotaController.text.isEmpty){
                    _searchKota.clear();
                    listCity.clear();                                       
                    listCity.addAll(state.general.data);
                  }else{
                    listCity.clear();                   
                    listCity.addAll(_searchKota);
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.46,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _searchKota.length !=0 || _cariKotaController.text.isNotEmpty ? 
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: _searchKota.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: _searchKota.length,
                                    itemBuilder: (context, index) {
                                      return _buildSearchKota(context, index);
                                    },
                                    shrinkWrap: true,
                                  )),
                          ),
                        )
                        :
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: listCity.isEmpty
                                ? Center(
                                    child: Text(
                                      "Pilih Provinsi terlebih dahulu",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: listCity.length,
                                    itemBuilder: (context, index) {
                                      return _buildCellCity(context, index);
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
                listCity = [];
                _cariKotaController.text="";
                _searchKota.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildSearchKota(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _cityController.text = _searchKota[index].name;
            id_kota = _searchKota[index].iD;
            _kecamatanController.text = "";
            _kelurahanController.text = "";
            _searchKota = [];
                      
          });
        },
        title: Text(_searchKota[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  Widget _buildCellCity(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _cityController.text = listCity[index].name;
            id_kota = listCity[index].iD;
            _kecamatanController.text = "";
            _kelurahanController.text = "";
            listCity = [];
                      
          });
        },
        title: Text(listCity[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  void _showDialogCity2(BuildContext context, param) {
    // flutter defined function
    _getCity2();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Pilih Kota"),
          content: BlocBuilder<GeneralGetParamBloc, GeneralGetState>(
              bloc: _getBloc,
              builder: (context, state) {
                // if (state is GeneralGetEmpty){
                //   return LoadingIndicator();
                // }
                if (state is GeneralGetLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                    ),
                  );
                }
                if (state is GeneralGetInitial) {
                  listCity2.addAll(state.general.data);
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
                            child: listCity2.isEmpty
                                ? Center(
                                    child: Text(
                                      "Pilih provinsi terlebih dahulu",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: listCity2.length,
                                    itemBuilder: (context, index) {
                                      return _buildCellCity2(context, index);
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
                listCity = [];
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCellCity2(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _city2Controller.text = listCity2[index].name;
            id_kota2 = listCity2[index].iD;
            _kecamatan2Controller.text = "";
            _kelurahan2Controller.text = "";
            listCity2 = [];
                      
          });
        },
        title: Text(listCity2[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  void _showDialogKecamatan(BuildContext context, param) {
    // flutter defined function
    _getKecamatan();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Column(
            children: <Widget>[
              Text("Pilih Kecamatan"),
              Container(
                child: TextFormField(
                  controller: _cariKecamatanController,
                  onChanged: (value){
                    setState(() {
                      onSearchKecamatan(value);
                                          
                    });
                  },
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE6C125)),),
                      hintText: 'Cari ...'),
                ),
              )
            ],
          ),
          content: BlocBuilder<GeneralGetParamBloc, GeneralGetState>(
              bloc: _getBloc,
              builder: (context, state) {
                // if (state is GeneralGetEmpty){
                //   return LoadingIndicator();
                // }
                if (state is GeneralGetLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                    ),
                  );
                }
                if (state is GeneralGetInitial) {
                  if(_cariKecamatanController.text.isEmpty){
                    _searchKecamatan.clear();
                    listKecamatan.clear();                                       
                    listKecamatan.addAll(state.general.data);
                  }else{
                    listKecamatan.clear();                   
                    listKecamatan.addAll(_searchKecamatan);
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.46,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _searchKecamatan.length !=0 || _cariKecamatanController.text.isNotEmpty ? 
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: _searchKecamatan.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: _searchKecamatan.length,
                                    itemBuilder: (context, index) {
                                      return _buildSearchKecamatan(context, index);
                                    },
                                    shrinkWrap: true,
                                  )),
                          ),
                        )
                        :
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: listKecamatan.isEmpty
                                ? Center(
                                    child: Text(
                                      "Pilih kota/kabupaten terlebih dahulu",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: listKecamatan.length,
                                    itemBuilder: (context, index) {
                                      return _buildCellKecamatan(
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
                listKecamatan = [];
                _cariKecamatanController.text="";
                _searchKecamatan.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildSearchKecamatan(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _kecamatanController.text = _searchKecamatan[index].name;
            id_kecamatan = _searchKecamatan[index].iD;
            _kelurahanController.text = "";
            _searchKecamatan = [];
                      
          });
        },
        title: Text(_searchKecamatan[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  Widget _buildCellKecamatan(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _kecamatanController.text = listKecamatan[index].name;
            id_kecamatan = listKecamatan[index].iD;
            _kelurahanController.text = "";
            listKecamatan = [];
                      
          });
        },
        title: Text(listKecamatan[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  void _showDialogKecamatan2(BuildContext context, param) {
    // flutter defined function
    _getKecamatan2();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Pilih Kecamatan"),
          content: BlocBuilder<GeneralGetParamBloc, GeneralGetState>(
              bloc: _getBloc,
              builder: (context, state) {
                // if (state is GeneralGetEmpty){
                //   return LoadingIndicator();
                // }
                if (state is GeneralGetLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                    ),
                  );
                }
                if (state is GeneralGetInitial) {
                  listKecamatan2.addAll(state.general.data);
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
                            child: listKecamatan2.isEmpty
                                ? Center(
                                    child: Text(
                                      "Pilih kota/kabupaten terlebih dahulu",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: listKecamatan2.length,
                                    itemBuilder: (context, index) {
                                      return _buildCellKecamatan2(
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
                listKecamatan2 = [];
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCellKecamatan2(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _kecamatan2Controller.text = listKecamatan2[index].name;
            id_kecamatan2 = listKecamatan2[index].iD;
            _kelurahan2Controller.text = "";
            listKecamatan2 = [];
                      
          });
        },
        title: Text(listKecamatan2[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  void _showDialogKelurahan(BuildContext context, param) {
    // flutter defined function
    _getKelurahan();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Column(
            children: <Widget>[
              Text("Pilih Kelurahan"),
              Container(
                child: TextFormField(
                  controller: _cariKelurahanController,
                  onChanged: (value){
                    setState(() {
                      onSearchKelurahan(value);
                                          
                    });
                  },
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE6C125)),),
                      hintText: 'Cari ...'),
                ),
              )
            ],
          ),
          content: BlocBuilder<GeneralGetParamBloc, GeneralGetState>(
              bloc: _getBloc,
              builder: (context, state) {
                // if (state is GeneralGetEmpty){
                //   return LoadingIndicator();
                // }
                if (state is GeneralGetLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                    ),
                  );
                }
                if (state is GeneralGetInitial) {
                  if(_cariKelurahanController.text.isEmpty){
                    _searchKelurahan.clear();
                    listKelurahan.clear();                                       
                    listKelurahan.addAll(state.general.data);
                  }else{
                    listKelurahan.clear();                   
                    listKelurahan.addAll(_searchKelurahan);
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.46,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _searchKelurahan.length !=0 || _cariKelurahanController.text.isNotEmpty ? 
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: _searchKelurahan.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: _searchKelurahan.length,
                                    itemBuilder: (context, index) {
                                      return _buildSearchKelurahan(context, index);
                                    },
                                    shrinkWrap: true,
                                  )),
                          ),
                        )
                        :
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: listKelurahan.isEmpty
                                ? Center(
                                    child: Text(
                                      "Pilih kecamatan terlebih dahulu",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: listKelurahan.length,
                                    itemBuilder: (context, index) {
                                      return _buildCellKelurahan(
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
                listKelurahan = [];
                _cariKelurahanController.text="";
                _searchKelurahan.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
  Widget _buildSearchKelurahan(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _kelurahanController.text = _searchKelurahan[index].name;
            _searchKelurahan = [];
                      
          });
        },
        title: Text(_searchKelurahan[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }
  Widget _buildCellKelurahan(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _kelurahanController.text = listKelurahan[index].name;
            listKelurahan = [];
                      
          });
        },
        title: Text(listKelurahan[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  void _showDialogKelurahan2(BuildContext context, param) {
    // flutter defined function
    _getKelurahan2();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Pilih Kelurahan"),
          content: BlocBuilder<GeneralGetParamBloc, GeneralGetState>(
              bloc: _getBloc,
              builder: (context, state) {
                // if (state is GeneralGetEmpty){
                //   return LoadingIndicator();
                // }
                if (state is GeneralGetLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                    ),
                  );
                }
                if (state is GeneralGetInitial) {
                  listKelurahan2.addAll(state.general.data);
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
                            child: listKelurahan2.isEmpty
                                ? Center(
                                    child: Text(
                                      "Pilih kecamatan terlebih dahulu",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: listKelurahan2.length,
                                    itemBuilder: (context, index) {
                                      return _buildCellKelurahan2(
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
                listKelurahan2 = [];
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCellKelurahan2(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _kelurahan2Controller.text = listKelurahan2[index].name;
            listKelurahan2 = [];
                      
          });
        },
        title: Text(listKelurahan2[index].name,
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
            title: new Text('Data alamat berhasil disimpan'),
            content: new Text('Success'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () async{
                 
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
            title: new Text('Data alamat berhasil diupdate'),
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

  setParameter() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("addressSimpan", "done");
  }

  loading(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
            content:
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.4, 
            child: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
              ),
            ),
          )
        ),
    ) ??
    false;
  }

  success2(){
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
  
  _widget(){
    Navigator.of(context).pop();
  }
}
