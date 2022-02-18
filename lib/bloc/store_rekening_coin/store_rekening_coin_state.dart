import 'package:flutter_base/model/response/rekeing_coin.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class StoreRekeningCoinState extends Equatable {
  const StoreRekeningCoinState();

  @override
  List<Object> get props => [];
}
class StoreRekeningCoinEmpty extends StoreRekeningCoinState {}

class StoreRekeningCoinInitial extends StoreRekeningCoinState {
  final RekeningCoin dataRekening;

  const StoreRekeningCoinInitial({@required this.dataRekening});

  @override
  List<Object> get props => [dataRekening];
}

class StoreRekeningCoinLoading extends StoreRekeningCoinState {}

class StoreRekeningCoinFailure extends StoreRekeningCoinState {
  final String error;

  const StoreRekeningCoinFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'StoreRekeningCoinFailure { error: $error }';
}

