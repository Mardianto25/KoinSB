import 'package:flutter_base/model/content/job_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class JobDataEvent extends Equatable {
  const JobDataEvent();
  @override
  List<Object> get props => [];
}

class JobDataStarted extends JobDataEvent {}

class JobDataSuccess extends JobDataEvent {
  
}

class JobDataError extends JobDataEvent {}


class JobDataButtonPressed extends JobDataEvent {
  final JobDataContent dataJob;

  const JobDataButtonPressed({
    @required this.dataJob
    }) : assert(dataJob != null);

  @override
  List<Object> get props => [dataJob];
  
  @override
  String toString() {
    print(dataJob);
    return 'SubmittedEmail { Data: $dataJob }';
  }

  
}

class GetJobDataStarted extends JobDataEvent {}

class GetJobDataSuccess extends JobDataEvent {
  
}

class GetJobDataError extends JobDataEvent {}


class GetJobDataButtonPressed extends JobDataEvent {
  final String type;

  const GetJobDataButtonPressed({
    @required this.type
    }) : assert(type != null);

  @override
  List<Object> get props => [type] ;
}




