import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CekStatusState extends Equatable {
  const CekStatusState();

  @override
  List<Object> get props => [];
}

class CekStatusEmpty extends CekStatusState {}

class CekStatusInitial extends CekStatusState {
  final CekStatusResponse status;

  const CekStatusInitial({@required this.status});

  @override
  List<Object> get props => [status];
}

class CekStatusLoading extends CekStatusState {}

class CekStatusFailure extends CekStatusState {
  final String error;

  const CekStatusFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CekStatusFailure { error: $error }';
}
