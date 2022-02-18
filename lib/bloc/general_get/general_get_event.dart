import 'package:flutter_base/model/content/personal_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class GeneralGetEvent extends Equatable {
  const GeneralGetEvent();
  @override
  List<Object> get props => [];
}

class GetGeneralStarted extends GeneralGetEvent {}

class GetGeneralSuccess extends GeneralGetEvent {
  
}

class GetGeneralError extends GeneralGetEvent {}


class GetGeneralButtonPressed extends GeneralGetEvent {
  final String choose;

  const GetGeneralButtonPressed({
    @required this.choose
    // @required this.otpCode,
  });

  @override
  List<Object> get props => [choose];

  @override
  String toString() {
    return 'Submitted { param: $choose}';
  }
}


class GetGeneralParamsButtonPressed extends GeneralGetEvent {
  final String choose;
  final String id;

  const GetGeneralParamsButtonPressed({
    @required this.choose,
    @required this.id
    
    // @required this.otpCode,
  });

  @override
  List<Object> get props => [choose, id];

  @override
  String toString() {
    return 'Submitted { param: $choose, id: $id}';
  }
}


