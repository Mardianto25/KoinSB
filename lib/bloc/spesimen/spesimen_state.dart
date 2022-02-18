import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SpesimenState extends Equatable {
  const SpesimenState();

  @override
  List<Object> get props => [];
}

class SpesimenInitial extends SpesimenState {}

class SpesimenLoading extends SpesimenState {}

class SpesimenFailure extends SpesimenState {
  final String error;

  const SpesimenFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SpesimenFailure { error: $error }';
}