import 'dart:async';

import 'package:flutter_base/bloc/job_data/job_data_event.dart';
import 'package:flutter_base/bloc/job_data/job_data_state.dart';
import 'package:flutter_base/model/response/job_data_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetJobDataBloc extends Bloc<JobDataEvent, JobDataState> {
  final UserRepository userRepository;

  GetJobDataBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  JobDataState get initialState => GetJobDataDataEmpty();

  @override
  Stream<JobDataState> mapEventToState(JobDataEvent event) async* {
    if (event is GetJobDataButtonPressed) {
      yield GetJobDataDataLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        JobDataResponse _general = await userRepository.getJobData(
          event.type, _token
        );
        if (_general.response.respCode == "00"){
          yield GetJobDataDataInitial(dataJob: _general);
          prefs.remove("typeJob");
        }else{
          yield GetJobDataDataFailure(error: _general.response.respMessage);
        }
      } catch (error) {
        yield GetJobDataDataFailure(error: error.toString());
      }
    }
  }
  
}
