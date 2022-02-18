import 'package:flutter_base/model/content/personal_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UpdatePersonalDataEvent extends Equatable {
  const UpdatePersonalDataEvent();
  @override
  List<Object> get props => [];
}

class UpdatePersonalDataStarted extends UpdatePersonalDataEvent {}

class UpdatePersonalDataSuccess extends UpdatePersonalDataEvent {
  
}

class UpdatePersonalDataError extends UpdatePersonalDataEvent {}


class UpdatePersonalDataButtonPressed extends UpdatePersonalDataEvent {
  final PersonalDataContent dataPersonal;

  const UpdatePersonalDataButtonPressed({
    @required this.dataPersonal
    }) : assert(dataPersonal != null);

  @override
  List<Object> get props => [dataPersonal] ;

  // @override
  // String toString() {
  //   return 'SubmittedEmail { Data: $dataPersonal }';
  // }
  
}



class GetReligionStarted extends UpdatePersonalDataEvent {}

class GetReligionSuccess extends UpdatePersonalDataEvent {
  
}

class GetReligionError extends UpdatePersonalDataEvent {}


class GetReligionButtonPressed extends UpdatePersonalDataEvent {}


