import 'package:flutter_base/model/content/job_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateJobDataEvent extends Equatable {
  const UpdateJobDataEvent();
  @override
  List<Object> get props => [];
}

class UpdateJobDataStarted extends UpdateJobDataEvent {}

class UpdateJobDataSuccess extends UpdateJobDataEvent {
  
}

class UpdateJobDataError extends UpdateJobDataEvent {}


class UpdateJobDataButtonPressed extends UpdateJobDataEvent {
  final JobDataContent dataJob;

  const UpdateJobDataButtonPressed({
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




