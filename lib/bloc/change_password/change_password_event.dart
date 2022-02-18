import 'package:flutter_base/model/content/personal_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
  @override
  List<Object> get props => [];
}

class ChangePasswordStarted extends ChangePasswordEvent {}

class ChangePasswordSuccess extends ChangePasswordEvent {
  
}

class ChangePasswordError extends ChangePasswordEvent {}


class ChangePasswordButtonPressed extends ChangePasswordEvent {
  final String imei;
  final String oldPass;
  final String newPass;
  

  const ChangePasswordButtonPressed({
    @required this.imei,
    @required this.oldPass,
    @required this.newPass    
  });

  @override
  List<Object> get props => [imei];

  @override
  String toString() {
    return 'Submitted { param: $imei, $oldPass, $newPass}';
  }
}



