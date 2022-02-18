import 'package:flutter_base/model/response/cek_fitur_coin.dart';
import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CekFiturCoinState extends Equatable {
  const CekFiturCoinState();

  @override
  List<Object> get props => [];
}

class CekFiturCoinEmpty extends CekFiturCoinState {}

class CekFiturCoinInitial extends CekFiturCoinState {
  final CekFiturCoin status;

  const CekFiturCoinInitial({@required this.status});

  @override
  List<Object> get props => [status];
}

class CekFiturCoinLoading extends CekFiturCoinState {}

class CekFiturCoinFailure extends CekFiturCoinState {
  final String error;

  const CekFiturCoinFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CekFiturCoinFailure { error: $error }';
}
