import 'package:flutter_base/model/content/sbmax_inisiasi.dart';
import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class SbmaxInisiasiEvent extends Equatable {
  const SbmaxInisiasiEvent();

  @override
  List<Object> get props => [];
}

class SubmittedSbmaxInisiasi extends SbmaxInisiasiEvent {
  final SbmaxInisiasi param;
  final String no;

  const SubmittedSbmaxInisiasi({
    @required this.param,
    @required this.no
  });

  @override
  List<Object> get props => [param, no];
}
