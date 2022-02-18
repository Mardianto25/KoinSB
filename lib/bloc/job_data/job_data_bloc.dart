import 'dart:async';

import 'package:flutter_base/bloc/job_data/job_data_event.dart';
import 'package:flutter_base/bloc/job_data/job_data_state.dart';
import 'package:flutter_base/model/response/job_data_response.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class JobDataBloc extends Bloc<JobDataEvent, JobDataState> {
  final UserRepository userRepository;

  JobDataBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  JobDataState get initialState => JobDataInitial();

  @override
  Stream<JobDataState> mapEventToState(JobDataEvent event) async* {

    if (event is JobDataButtonPressed) {
      yield JobDataLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        String _publicId = prefs.getString('publicId');  
        String _type = prefs.getString('typeJobs'); 
        print(_type);
        if(_type == "jobs"){
          LoginResponse tokenUpdate = await userRepository.changeJobData(
            event.dataJob,_publicId, _token
          );
          if (tokenUpdate.response.respCode =="00"){
            yield JobDataUpdateInitial();
            prefs.remove("typeJob");

          }else{
            JobDataFailure(error: tokenUpdate.response.respMessage);
          }
        }else{
          LoginResponse token = await userRepository.updateJobData(
            event.dataJob,_publicId, _token
          );
          if (token.response.respCode =="00"){
            yield JobDataInitial();
          }else{
            JobDataFailure(error: token.response.respMessage);
          }

        }


      } catch (error) {
        yield JobDataFailure(error: error.toString());
      }
    }
  }
  
}
