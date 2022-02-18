import 'package:flutter_base/model/response/list_rekening.dart';
import 'package:flutter_base/model/response/sbmax_detail.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SbmaxDetailAnggotaState extends Equatable {
  const SbmaxDetailAnggotaState();

  @override
  List<Object> get props => [];
}

class SbmaxDetailAnggotaInitial extends SbmaxDetailAnggotaState {
  final SbmaxDetail sbmaxDetailAnggota;

  const SbmaxDetailAnggotaInitial({@required this.sbmaxDetailAnggota});

  @override
  List<Object> get props => [sbmaxDetailAnggota];
}

class SbmaxDetailAnggotaLoading extends SbmaxDetailAnggotaState {}

class SbmaxDetailAnggotaFailure extends SbmaxDetailAnggotaState {
  final String error;

  const SbmaxDetailAnggotaFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SbmaxDetailAnggotaFailure { error: $error }';
}
