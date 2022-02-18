import 'package:flutter_base/model/content/sbmax_inisiasi.dart';
import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:flutter_base/model/response/list_rekening.dart';
import 'package:flutter_base/model/response/sbmax_detail.dart';
import 'package:flutter_base/model/response/sbmax_simulasi_detail_response.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SbmaxPencairanState extends Equatable {
  const SbmaxPencairanState();

  @override
  List<Object> get props => [];
}

class SbmaxPencairanInitial extends SbmaxPencairanState {
  // final SbmaxDetail sbmaxPencairan;

  // const SbmaxPencairanInitial({@required this.sbmaxPencairan});

  // @override
  // List<Object> get props => [sbmaxPencairan];
}

class SbmaxPencairanLoading extends SbmaxPencairanState {}

class SbmaxPencairanFailure extends SbmaxPencairanState {
  final String error;

  const SbmaxPencairanFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SbmaxPencairanFailure { error: $error }';
}
