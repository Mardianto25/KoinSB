import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class SbmaxPinEvent extends Equatable {
  const SbmaxPinEvent();

  @override
  List<Object> get props => [];
}

class SubmittedPin extends SbmaxPinEvent {
  final String imei;
  final String pin;
  
  const SubmittedPin({
    @required this.imei,
    @required this.pin,
    
  });

  @override
  List<Object> get props => [imei, pin];

  @override
  String toString() {
    return 'Submitted { imei: $imei, pin: $pin }';
  }
}
