import 'package:flutter_base/model/content/sbmax_inisiasi.dart';
import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:flutter_base/model/response/list_rekening.dart';
import 'package:flutter_base/model/response/sbmax_detail.dart';
import 'package:flutter_base/model/response/sbmax_simulasi_detail_response.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SbmaxInisiasiState extends Equatable {
  const SbmaxInisiasiState();

  @override
  List<Object> get props => [];
}

class SbmaxInisiasiInitial extends SbmaxInisiasiState {
  final SbmaxSimulasiDetailResponse sbmaxInisiasi;

  const SbmaxInisiasiInitial({@required this.sbmaxInisiasi});

  @override
  List<Object> get props => [SbmaxInisiasi];
}

class SbmaxInisiasiLoading extends SbmaxInisiasiState {}

class SbmaxInisiasiFailure extends SbmaxInisiasiState {
  final String error;

  const SbmaxInisiasiFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SbmaxInisiasiFailure { error: $error }';
}
