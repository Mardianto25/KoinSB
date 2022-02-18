import 'package:flutter_base/model/response/job_data_response.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class JobDataState extends Equatable {
  const JobDataState();

  @override
  List<Object> get props => [];
}

class JobDataInitial extends JobDataState {}
class JobDataUpdateInitial extends JobDataState {}

class JobDataLoading extends JobDataState {}

class JobDataFailure extends JobDataState {
  final String error;

  const JobDataFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'JobDataFailure { error: $error }';
}

class GetJobDataDataEmpty extends JobDataState {}
class GetJobDataDataInitial extends JobDataState {
  final JobDataResponse dataJob;

  const GetJobDataDataInitial({@required this.dataJob});

  @override
  List<Object> get props => [dataJob];
}

class GetJobDataDataLoading extends JobDataState {}

class GetJobDataDataFailure extends JobDataState {
  final String error;

  const GetJobDataDataFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'JobDataFailure { error: $error }';
}
