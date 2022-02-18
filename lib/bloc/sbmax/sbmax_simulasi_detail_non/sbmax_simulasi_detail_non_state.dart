
import 'package:flutter_base/model/response/sbmax_simulasi_detail_response.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SbmaxSimulasiDetailNonState extends Equatable {
  const SbmaxSimulasiDetailNonState();

  @override
  List<Object> get props => [];
}

class SbmaxSimulasiDetailNonInitial extends SbmaxSimulasiDetailNonState {
  final SbmaxSimulasiDetailResponse sbmaxSimulasiDetailNon;

  const SbmaxSimulasiDetailNonInitial({@required this.sbmaxSimulasiDetailNon});

  @override
  List<Object> get props => [sbmaxSimulasiDetailNon];
}

class SbmaxSimulasiDetailNonLoading extends SbmaxSimulasiDetailNonState {}

class SbmaxSimulasiDetailNonFailure extends SbmaxSimulasiDetailNonState {
  final String error;
  final SbmaxSimulasiDetailResponse sbmaxSimulasiDetailNon;
  

  const SbmaxSimulasiDetailNonFailure({@required this.error, @required this.sbmaxSimulasiDetailNon});

  @override
  List<Object> get props => [error, sbmaxSimulasiDetailNon];

  @override
  String toString() => 'SbmaxSimulasiDetailNonFailure { error: $error }';
}
