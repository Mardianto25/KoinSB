import 'package:flutter_base/model/response/religion.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UpdatePersonalDataState extends Equatable {
  const UpdatePersonalDataState();

  @override
  List<Object> get props => [];
}

class UpdatePersonalDataInitial extends UpdatePersonalDataState {}

class UpdatePersonalDataLoading extends UpdatePersonalDataState {}

class UpdatePersonalDataFailure extends UpdatePersonalDataState {
  final String error;

  const UpdatePersonalDataFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UpdatePersonalDataFailure { error: $error }';
}
