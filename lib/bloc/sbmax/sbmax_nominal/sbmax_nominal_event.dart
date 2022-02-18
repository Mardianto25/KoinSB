import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class SbmaxNominalEvent extends Equatable {
  const SbmaxNominalEvent();

  @override
  List<Object> get props => [];
}

class SubmittedNominal extends SbmaxNominalEvent {
  final int nominal;


  const SubmittedNominal({
    @required this.nominal
  });

  @override
  List<Object> get props => [nominal];

  @override
  String toString() {
    return 'Submitted { nominal: $nominal }';
  }
}
