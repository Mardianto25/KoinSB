import 'package:flutter_base/model/content/personal_data.dart';
import 'package:flutter_base/model/response/data_personal_response.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PersonalDataState extends Equatable {
  const PersonalDataState();

  @override
  List<Object> get props => [];
}

class PersonalDataInitial extends PersonalDataState {}
class PersonalDataUpdateInitial extends PersonalDataState {}
class PersonalDataLoading extends PersonalDataState {}

class PersonalDataFailure extends PersonalDataState {
  final String error;

  const PersonalDataFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PersonalDataFailure { error: $error }';
}
class GetPersonalDataDataEmpty extends PersonalDataState {}
class GetPersonalDataDataInitial extends PersonalDataState {
  final PersonalDataResponse dataPersonal;

  const GetPersonalDataDataInitial({@required this.dataPersonal});

  @override
  List<Object> get props => [dataPersonal];
}

class GetPersonalDataDataLoading extends PersonalDataState {}

class GetPersonalDataDataFailure extends PersonalDataState {
  final String error;
  final PersonalDataResponse dataPersonal;

  const GetPersonalDataDataFailure({@required this.error, @required this.dataPersonal});

  @override
  List<Object> get props => [error, dataPersonal];

  @override
  String toString() => 'PersonalDataFailure { error: $error }';
}
