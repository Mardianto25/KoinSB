import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SbmaxNominalState extends Equatable {
  const SbmaxNominalState();

  @override
  List<Object> get props => [];
}

class SbmaxNominalInitial extends SbmaxNominalState {
  final  ResponseSimulasi dataSbmax;

  const SbmaxNominalInitial({@required this.dataSbmax});

  @override
  List<Object> get props => [dataSbmax];
}

class SbmaxNominalLoading extends SbmaxNominalState {}

class SbmaxNominalFailure extends SbmaxNominalState {
  final String error;

  const SbmaxNominalFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SbmaxNominalFailure { error: $error }';
}
