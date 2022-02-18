import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/general_get/general_get_bloc.dart';
import 'package:flutter_base/bloc/general_get/general_get_event.dart';
import 'package:flutter_base/bloc/general_get/general_get_state.dart';
import 'package:flutter_base/bloc/job_data/get_job_data_bloc.dart';
import 'package:flutter_base/bloc/job_data/job_data_bloc.dart';
import 'package:flutter_base/bloc/job_data/job_data_event.dart';
import 'package:flutter_base/bloc/job_data/job_data_state.dart';
import 'package:flutter_base/member_data.dart';
import 'package:flutter_base/model/content/RadioGroup.dart';
import 'package:flutter_base/model/content/job_data.dart';
import 'package:flutter_base/model/response/job_data_response.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/show_data/show_data_page.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobDataForm extends StatefulWidget {
  String type;

  JobDataForm({Key key, @required this.type}) : super(key: key);

  @override
  State<JobDataForm> createState() => _JobDataFormState();
}

class _JobDataFormState extends State<JobDataForm> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController _instansiController = TextEditingController();
  TextEditingController _jobsController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _lengthController = TextEditingController();

  // TextEditingController _instansiEditController = TextEditingController();
  // TextEditingController _jobsEditController = TextEditingController();
  // TextEditingController _statusEditController = TextEditingController();
  // TextEditingController _lengthEditController = TextEditingController();

  String param;
  GeneralGetBloc _getBloc;
  GetJobDataBloc _getJob;
  JobDataResponse listDataJob;
  bool _cekData = false;

  ScrollController _scrollContainer = ScrollController();

  List<GeneralData> list = List();
  List<GeneralData> listStatus = List();

  String _selectedJob, _selectedJobTime;
  final format = DateFormat("yyyy-MM-dd");
  List<String> sampleData = [
    '> 1 Tahun',
    '> 2 Tahun',
    '> 3 Tahun',
    '> 4 Tahun',
    '> 5 Tahun'
  ];

  @override
  void initState() {
    // TODO: implement initState
    _getBloc = BlocProvider.of<GeneralGetBloc>(context);
    _getJob = BlocProvider.of<GetJobDataBloc>(context);
    _getDataJob();

    super.initState();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      // if(_statusController.text.length >= 2 && _jobsController.text.length >= 2 && _instansiController.text.length >= 2 && _lengthController.text.length >= 2){
        _onJobDataButtonPressed();
      // }
    }
  }

  _onJobDataButtonPressed() {
    // print("bismillah");
    BlocProvider.of<JobDataBloc>(context).add(
      JobDataButtonPressed(
          dataJob: JobDataContent(
              namaInstansi:_instansiController.text,
              jenisPekerjaan: _jobsController.text,
              statusPekerjaan: _statusController.text,
              lamaBekerja: _lengthController.text,
              publicId: "")
            ),
    );
  }

  _getJobs() {
    BlocProvider.of<GeneralGetBloc>(context)
        .add(GetGeneralButtonPressed(choose: "jobs"));
  }

  _getStatus() {
    BlocProvider.of<GeneralGetBloc>(context)
        .add(GetGeneralButtonPressed(choose: "jobs_status"));
  }

  _getDataJob() {
    if (widget.type == "jobs") {
      BlocProvider.of<GetJobDataBloc>(context)
          .add(GetJobDataButtonPressed(type: "jobs"));
    }
  }

  setParameter()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("jobSimpan", "done");
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobDataBloc, JobDataState>(
        listener: (context, state) {
          if (state is JobDataLoading){
            loading();
          }
          if (state is JobDataFailure) {
            Navigator.pop(context);            
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is JobDataInitial) {
            // BlocProvider.of<JobDataHandleBloc>(context).add(JobDataSuccess());
            setParameter();            
            Navigator.pop(context);
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => MemberData()));
            // success();
          }

          if (state is JobDataUpdateInitial) {
            Navigator.pop(context);
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowDataPage()));
            
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ShowDataPage()));
          }
        },
        child: widget.type == "jobs"
            ? BlocBuilder<GetJobDataBloc, JobDataState>(
                builder: (context, state) {
                  if (state is GetJobDataDataLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff096D5C)),
                      ),
                    );
                  }
                  if (state is GetJobDataDataInitial) {
                    listDataJob = state.dataJob;
                    _jobsController.text = listDataJob.response.data == null
                        ? ""
                        : listDataJob.response.data.jenisPekerjaan;
                    _instansiController.text = listDataJob.response.data == null
                        ? ""
                        : listDataJob.response.data.namaInstansi;
                    _statusController.text = listDataJob.response.data == null
                        ? ""
                        : listDataJob.response.data.statusPekerjaan;
                    _lengthController.text = listDataJob.response.data == null
                        ? ""
                        : listDataJob.response.data.lamaBekerja;
                    return Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: <Widget>[
                          Padding(
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
                                          padding: EdgeInsets.only(
                                              top: 10.0, bottom: 10.0),
                                          child: Text(
                                            "Jenis Pekerjaan",
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
                                              controller: _jobsController,
                                              onChanged: (_){
                                                setState(() {
                                                  if(_statusController.text.length >= 2 && _.length >= 2 && _instansiController.text.length >= 2 && _lengthController.text.length >= 2){
                                                    _cekData = true;
                                                  }else{
                                                    _cekData = false;
                                                  }  
                                                                                                  
                                                });
                                              },  
                                              decoration: InputDecoration(
                                                  suffixIcon: GestureDetector(
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  fillColor: Colors.teal,
                                                  hintText:
                                                  'Pilih Jenis Pekerjaan'),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            "Nama Instansi",
                                            style: CustomText.regular12,
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _instansiController,
                                          validator: Validator.validate,
                                          onChanged: (_){
                                            setState(() {
                                              if(_statusController.text.length >= 2 && _jobsController.text.length >= 2 && _.length >= 2 && _lengthController.text.length >= 2){
                                                _cekData = true;
                                              }else{
                                                _cekData = false;
                                              }                                           
                                            });
                                          },
                                          decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Color(0xffE6C125)),), 
                                            hintText: 'Masukkan nama instansii',
                                            hintStyle: CustomText.regular16,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 10.0, bottom: 10.0),
                                          child: Text(
                                            "Status pekerjaan",
                                            style: CustomText.regular12,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _showDialogStatus(context);
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
                                              controller: _statusController,
                                              onChanged: (_){
                                                setState(() {
                                                  if(_.length >= 2 && _jobsController.text.length >= 2 && _instansiController.text.length >= 2 && _lengthController.text.length >= 2){
                                                    _cekData = true;
                                                  }else{
                                                    _cekData = false;
                                                  }                                           
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  suffixIcon: GestureDetector(
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  fillColor: Colors.teal,
                                                  hintText:
                                                      'Pilih Status Pekerjaan'),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 10.0, bottom: 10.0),
                                          child: Text(
                                            "Lama Bekerja",
                                            style: CustomText.regular12,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _showDialogLength(context);
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
                                              controller: _lengthController,
                                              onChanged: (_){
                                                setState(() {
                                                  if(_statusController.text.length >= 2 && _jobsController.text.length >= 2 && _instansiController.text.length >= 2 && _.length >= 2){
                                                    _cekData = true;
                                                  }else{
                                                    _cekData = false;
                                                  }                                           
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  suffixIcon: GestureDetector(
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  fillColor: Colors.teal,
                                                  hintText:
                                                  'Pilih Lama Pekerjaan'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 16.0, right: 16.0, bottom: 16.0),
                                child: MaterialButton(
                                  onPressed: () {
                                   setState(() {
                                      if(_statusController.text.length >= 2 && _jobsController.text.length >= 2 && _instansiController.text.length >= 2 && _lengthController.text.length >= 2){
                                        _submit();
                                      }else{
                                        null;
                                      }
                                                                    
                                    });
                                  },
                                  color: _statusController.text.length >= 2 && _jobsController.text.length >= 2 && _instansiController.text.length >= 2 && _lengthController.text.length >= 2 ? Color(0xff096d5c) :Color(0xff727272),
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
                  if (state is GetJobDataDataFailure) {
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
                    Padding(
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
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: Text(
                                      "Jenis Pekerjaan",
                                      style: CustomText.regular12,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _showDialog(context);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 16, right: 0, top: 3),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.teal,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: TextFormField(
                                        enabled: false,
                                        controller: _jobsController,
                                        onChanged: (_){
                                          print(_);
                                          setState(() {
                                            if(_statusController.text.length >= 2 && _.length >= 2 && _instansiController.text.length >= 2 && _lengthController.text.length >= 2){
                                              _cekData = true;
                                            }else{
                                              _cekData = false;
                                            }  
                                                                                            
                                          });
                                        }, 
                                        decoration: InputDecoration(
                                            suffixIcon: GestureDetector(
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            fillColor: Colors.teal,
                                            hintText:
                                            'Pilih Jenis Pekerjaan'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      "Nama Instansi",
                                      style: CustomText.regular12,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _instansiController,
                                    validator: Validator.validate,
                                    onChanged: (value){
                                      setState(() {
                                        _instansiController.text;                                               
                                      });
                                    },
                                    decoration: InputDecoration(
                                      // fillColor: Color(0xffE6C125),
                                      focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffE6C125)),),
                                      hintText: 'Masukan nama instansi',
                                      hintStyle: CustomText.regular16,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: Text(
                                      "Status pekerjaan",
                                      style: CustomText.regular12,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _showDialogStatus(context);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 16, right: 0, top: 3),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.teal,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: TextFormField(
                                        enabled: false,
                                        controller: _statusController,
                                        onChanged: (_){
                                          setState(() {
                                            if(_.length >= 2 && _jobsController.text.length >= 2 && _instansiController.text.length >= 2 && _lengthController.text.length >= 2){
                                              _cekData = true;
                                            }else{
                                              _cekData = false;
                                            }                                           
                                          });
                                        },
                                        decoration: InputDecoration(
                                            suffixIcon: GestureDetector(
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            fillColor: Colors.teal,
                                            hintText: 'Pilih Status Pekerjaan'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: Text(
                                      "Lama Bekerja",
                                      style: CustomText.regular12,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _showDialogLength(context);
                                      
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 16, right: 0, top: 3),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.teal,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: TextFormField(
                                        enabled: false,
                                        controller: _lengthController,
                                        onChanged: (_){
                                          setState(() {
                                            if(_statusController.text.length >= 2 && _jobsController.text.length >= 2 && _instansiController.text.length >= 2 && _.length >= 2){
                                              _cekData = true;
                                            }else{
                                              _cekData = false;
                                            }                                           
                                          });
                                        },
                                        // onChanged: (_){
                                        //   setState(() {
                                        //     _lengthController.text;                                     
                                        //   });
                                        // },
                                        decoration: InputDecoration(
                                            suffixIcon: GestureDetector(
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            fillColor: Colors.teal,
                                            hintText:
                                            'Pilih Lama Pekerjaaaan'),
                                      ),
                                    ),
                                  ),
                                ],
                              ))),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 16.0),
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                if(_statusController.text.length >= 2 && _jobsController.text.length >= 2 && _instansiController.text.length >= 2 && _lengthController.text.length >= 2){
                                  _submit();
                                }else{
                                  null;
                                }
                                                              
                              });
                              // _submit();
                            },
                            color: _statusController.text.length >= 2 && _jobsController.text.length >= 2 && _instansiController.text.length >= 2 && _lengthController.text.length >= 2 ? Color(0xff096d5c) :Color(0xff727272),
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

  void _showDialog(BuildContext context) {
    // flutter defined function
    _getJobs();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Pilih Jenis Pekerjaan"),
          content: BlocBuilder<GeneralGetBloc, GeneralGetState>(
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
            _jobsController.text = list[index].name;
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

  void _showDialogStatus(BuildContext context) {
    // flutter defined function
    _getStatus();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Pilih Status Pekerjaan"),
          content: BlocBuilder<GeneralGetBloc, GeneralGetState>(
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
                  listStatus.addAll(state.general.data);
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
                            child: listStatus.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                    controller: _scrollContainer,
                                    itemCount: listStatus.length,
                                    itemBuilder: (context, index) {
                                      return _buildCellStatus(context, index);
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
                listStatus = [];
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildCellStatus(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _statusController.text = listStatus[index].name;
            listStatus = [];
                      
          });
        },
        title: Text(listStatus[index].name,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  void _showDialogLength(BuildContext context) {
    // flutter defined function
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text("Pilih Lama Pekerjaan"),
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
                      child: sampleData.isEmpty
                          ? Center(
                              child: Text(
                                "No Data",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : Scrollbar(
                              child: ListView.builder(
                              controller: _scrollContainer,
                              itemCount: sampleData.length,
                              itemBuilder: (context, index) {
                                return _buildCellLength(context, index);
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
        });
  }

  Widget _buildCellLength(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _lengthController.text = sampleData[index];
          
          });
        },
        title: Text(sampleData[index],
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
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

  success(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
            title: new Text('Data pekerjaan berhasil disimpan'),
            content: new Text('Success'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("jobSimpan", "done");
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
            title: new Text('Data pekerjaan berhasil diupdate'),
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

}
