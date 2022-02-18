import 'package:flutter_base/model/content/sbmax_inisiasi.dart';
import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:flutter_base/model/response/sbmax_detail.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class SbmaxPencairanEvent extends Equatable {
  const SbmaxPencairanEvent();

  @override
  List<Object> get props => [];
}

class SubmittedSbmaxPencairan extends SbmaxPencairanEvent {
  final String imei;
  final String noac;
  final String password;

  const SubmittedSbmaxPencairan({
    @required this.imei,
    @required this.noac,
    @required this.password
    
  });

  @override
  List<Object> get props => [imei, noac, password];
}
