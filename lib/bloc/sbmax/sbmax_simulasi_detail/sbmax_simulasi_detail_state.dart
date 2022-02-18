import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:flutter_base/model/response/list_rekening.dart';
import 'package:flutter_base/model/response/sbmax_detail.dart';
import 'package:flutter_base/model/response/sbmax_simulasi_detail_response.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SbmaxSimulasiDetailState extends Equatable {
  const SbmaxSimulasiDetailState();

  @override
  List<Object> get props => [];
}

class SbmaxSimulasiDetailInitial extends SbmaxSimulasiDetailState {
  final SbmaxSimulasiDetailResponse sbmaxSimulasiDetail;

  const SbmaxSimulasiDetailInitial({@required this.sbmaxSimulasiDetail});

  @override
  List<Object> get props => [sbmaxSimulasiDetail];
}

class SbmaxSimulasiDetailLoading extends SbmaxSimulasiDetailState {}

class SbmaxSimulasiDetailFailure extends SbmaxSimulasiDetailState {
  final String error;
  final SbmaxSimulasiDetailResponse sbmaxSimulasiDetail;
  

  const SbmaxSimulasiDetailFailure({@required this.error, @required this.sbmaxSimulasiDetail});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SbmaxSimulasiDetailFailure { error: $error }';
}
