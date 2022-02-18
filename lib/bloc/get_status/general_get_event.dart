import 'package:flutter_base/model/content/personal_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CekStatusEvent extends Equatable {
  const CekStatusEvent();
  @override
  List<Object> get props => [];
}

class CekStatusStarted extends CekStatusEvent {}

class CekStatusSuccess extends CekStatusEvent {
  
}

class CekStatusError extends CekStatusEvent {}


class CekStatusButtonPressed extends CekStatusEvent {
  final String status;

  const CekStatusButtonPressed({
    @required this.status
    // @required this.otpCode,
  });

  @override
  List<Object> get props => [status];

  @override
  String toString() {
    return 'Submitted { param: $status}';
  }
}



