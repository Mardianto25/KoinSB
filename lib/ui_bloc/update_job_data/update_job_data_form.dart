import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/general_get/general_get_bloc.dart';
import 'package:flutter_base/bloc/general_get/general_get_event.dart';
import 'package:flutter_base/bloc/general_get/general_get_state.dart';
import 'package:flutter_base/bloc/update_job_data/update_job_data_bloc.dart';
import 'package:flutter_base/bloc/update_job_data/update_job_data_event.dart';
import 'package:flutter_base/bloc/update_job_data/update_job_data_state.dart';
import 'package:flutter_base/model/content/job_data.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/show_data/show_data_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UpdateJobDataForm extends StatefulWidget {
  @override
  State<UpdateJobDataForm> createState() => _UpdateJobDataFormState();

}

class _UpdateJobDataFormState extends State<UpdateJobDataForm> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController _instansiController = TextEditingController();
  TextEditingController _jobsController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _lengthController = TextEditingController();
  
  
  GeneralGetBloc _getBloc;
  ScrollController _scrollContainer = ScrollController();
  
  List<GeneralData> list = List();
  List<GeneralData> listStatus = List();
  
  

  var _eKTP, _fullname, _bornAt;
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
    
    super.initState();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      
      _onUpdateJobDataButtonPressed();
    }
  }
  _onUpdateJobDataButtonPressed() {
    // print("bismillah");
    BlocProvider.of<UpdateJobDataBloc>(context).add(
      UpdateJobDataButtonPressed(
        dataJob: JobDataContent(
          namaInstansi: _instansiController.text,
          jenisPekerjaan: _jobsController.text,
          statusPekerjaan: _statusController.text,
          lamaBekerja: _lengthController.text,
          publicId: ""
        )
      ),
    );
  }

  _getJobs() {
    BlocProvider.of<GeneralGetBloc>(context).add(
      GetGeneralButtonPressed(
        choose: "jobs"
      )
    );
  }

  _getStatus() {
    BlocProvider.of<GeneralGetBloc>(context).add(
      GetGeneralButtonPressed(
        choose: "jobs_status"
      )
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateJobDataBloc, UpdateJobDataState>(
      listener: (context, state) {
        if (state is UpdateJobDataFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is UpdateJobDataInitial) {
          // BlocProvider.of<UpdateJobDataHandleBloc>(context).add(UpdateJobDataSuccess());
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_){
                  return ShowDataPage();
                }
            ));
        }
       
      },
      child: BlocBuilder<UpdateJobDataBloc, UpdateJobDataState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Padding(
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
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Jenis Pekerjaan", style: CustomText.regular12,),
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
                                    controller: _jobsController,
                                    decoration: InputDecoration.collapsed(
                                        fillColor: Colors.teal,
                                        hintText: 'Pilih Jenis Pekerjaan'),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Nama Instansi", style: CustomText.regular12,),
                              ),
                              TextFormField(
                                controller: _instansiController,
                                decoration: InputDecoration(
                                    fillColor: Theme.of(context).accentColor,
                                    hintText: 'Masukkan nama instansii', hintStyle: CustomText.regular16,),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Status pekerjaan", style: CustomText.regular12,),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _showDialogStatus(context);
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
                                    controller: _statusController,
                                    decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                            });
                                          },
                                          child: Icon(
                                            Icons.arrow_right,
                                            color: Colors.black,
                                          ),
                                        ),
                                        fillColor: Colors.teal,
                                        hintText: 'Pilih Status Pekerjaan'),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Lama Bekerja", style: CustomText.regular12,),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _showDialogLength(context);
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
                                    controller: _lengthController,
                                    decoration: InputDecoration.collapsed(
                                        fillColor: Colors.teal,
                                        hintText: 'Pilih Lama Pekerjaan'),
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
                      padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
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

  void _showDialog(BuildContext context) {
    // flutter defined function
    _getJobs();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Pilih Jenis Pekerjaan"),
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
          _jobsController.text=list[index].name;
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

  void _showDialogStatus(BuildContext context) {
    // flutter defined function
    _getStatus();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Pilih Status Pekerjaan"),
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
                            child: listStatus.isEmpty ?
                              Center(
                                child: Text("No Data", style: TextStyle(color: Colors.red),),
                              ): ListView.builder(
                              controller: _scrollContainer,
                              itemCount: listStatus.length,
                              itemBuilder: (context, index){
                                return _buildCellStatus(context, index);
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
                listStatus=[];
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
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          _statusController.text=listStatus[index].name;
          listStatus=[];
      },
        title: Text(listStatus[index].name, style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
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
          title: Text("Pilih Lama Pekerjaan"),
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
                      child: sampleData.isEmpty ?
                        Center(
                          child: Text("No Data", style: TextStyle(color: Colors.red),),
                        ): ListView.builder(
                        controller: _scrollContainer,
                        itemCount: sampleData.length,
                        itemBuilder: (context, index){
                          return _buildCellLength(context, index);
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
      }
    );
  }

  Widget _buildCellLength(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          _lengthController.text=sampleData[index];
      },
        title: Text(sampleData[index], style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
      ),
    );
  }

}
