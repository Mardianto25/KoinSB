import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateJobDataState extends Equatable {
  const UpdateJobDataState();

  @override
  List<Object> get props => [];
}

class UpdateJobDataInitial extends UpdateJobDataState {}

class UpdateJobDataLoading extends UpdateJobDataState {}

class UpdateJobDataFailure extends UpdateJobDataState {
  final String error;

  const UpdateJobDataFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UpdateJobDataFailure { error: $error }';
}

