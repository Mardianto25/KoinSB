import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class SbmaxSimulasiDetailNonEvent extends Equatable {
  const SbmaxSimulasiDetailNonEvent();

  @override
  List<Object> get props => [];
}

class SubmittedSbmaxSimulasiDetailNon extends SbmaxSimulasiDetailNonEvent {
  final SbmaxSimulasiDetail param;

  const SubmittedSbmaxSimulasiDetailNon({
    @required this.param
  });

  @override
  List<Object> get props => [param];
}
