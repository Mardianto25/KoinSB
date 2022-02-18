import 'package:flutter_base/model/content/personal_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PersonalDataEvent extends Equatable {
  const PersonalDataEvent();
  @override
  List<Object> get props => [];
}

class PersonalDataStarted extends PersonalDataEvent {}

class PersonalDataSuccess extends PersonalDataEvent {
  
}

class PersonalDataError extends PersonalDataEvent {}


class PersonalDataButtonPressed extends PersonalDataEvent {
  final PersonalDataContent dataPersonal;

  const PersonalDataButtonPressed({
    @required this.dataPersonal
    }) : assert(dataPersonal != null);

  @override
  List<Object> get props => [dataPersonal] ;

  // @override
  // String toString() {
  //   return 'SubmittedEmail { Data: $dataPersonal }';
  // }
  
}



class GetPersonalDataStarted extends PersonalDataEvent {}

class GetPersonalDataSuccess extends PersonalDataEvent {
  
}

class GetPersonalDataError extends PersonalDataEvent {}


class GetPersonalDataButtonPressed extends PersonalDataEvent {
  final String type;

  const GetPersonalDataButtonPressed({
    @required this.type
    }) : assert(type != null);

  @override
  List<Object> get props => [type] ;
}


