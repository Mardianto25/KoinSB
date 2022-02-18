import 'package:flutter_base/model/content/personal_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ChangeEmailEvent extends Equatable {
  const ChangeEmailEvent();
  @override
  List<Object> get props => [];
}

class ChangeEmailStarted extends ChangeEmailEvent {}

class ChangeEmailSuccess extends ChangeEmailEvent {
  
}

class ChangeEmailError extends ChangeEmailEvent {}


class ChangeEmailButtonPressed extends ChangeEmailEvent {
  final String email;
  

  const ChangeEmailButtonPressed({
    @required this.email  
  });

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'Submitted { param: $email}';
  }
}



