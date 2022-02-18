
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GetFotoProfileEvent extends Equatable {
  const GetFotoProfileEvent();
  @override
  List<Object> get props => [];
}

class GetFotoProfileStarted extends GetFotoProfileEvent {}

class GetFotoProfileSuccess extends GetFotoProfileEvent {
  
}

class GetFotoProfileError extends GetFotoProfileEvent {}


class GetFotoProfileButtonPressed extends GetFotoProfileEvent {
  final String status;

  const GetFotoProfileButtonPressed({
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



