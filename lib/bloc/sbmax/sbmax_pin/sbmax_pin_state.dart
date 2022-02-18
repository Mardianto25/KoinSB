import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SbmaxPinState extends Equatable {
  const SbmaxPinState();

  @override
  List<Object> get props => [];
}

class SbmaxPinInitial extends SbmaxPinState {}

class SbmaxPinLoading extends SbmaxPinState {}

class SbmaxPinFailure extends SbmaxPinState {
  final String error;

  const SbmaxPinFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SbmaxPinFailure { error: $error }';
}
