import 'dart:async';

import 'package:flutter_base/bloc/update_job_data/update_job_data_event.dart';
import 'package:flutter_base/bloc/update_job_data/update_job_data_state.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UpdateJobDataBloc extends Bloc<UpdateJobDataEvent, UpdateJobDataState> {
  final UserRepository userRepository;

  UpdateJobDataBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  UpdateJobDataState get initialState => UpdateJobDataInitial();

  @override
  Stream<UpdateJobDataState> mapEventToState(UpdateJobDataEvent event) async* {

    if (event is UpdateJobDataButtonPressed) {
      yield UpdateJobDataLoading();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _token = prefs.getString('token');
        String _publicId = prefs.getString('publicId');        
        final token = await userRepository.changeJobData(
          event.dataJob,_publicId, _token
        );
        yield UpdateJobDataInitial();
      } catch (error) {
        yield UpdateJobDataFailure(error: error.toString());
      }
    }
  }
  
}
