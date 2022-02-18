import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class SbmaxSimulasiDetailEvent extends Equatable {
  const SbmaxSimulasiDetailEvent();

  @override
  List<Object> get props => [];
}

class SubmittedSbmaxSimulasiDetail extends SbmaxSimulasiDetailEvent {
  final SbmaxSimulasiDetail param;
  final String no;

  const SubmittedSbmaxSimulasiDetail({
    @required this.param,
    @required this.no
  });

  @override
  List<Object> get props => [param, no];
}
