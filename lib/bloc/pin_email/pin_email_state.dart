import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PinEmailState extends Equatable {
  const PinEmailState();

  @override
  List<Object> get props => [];
}

class PinEmailInitial extends PinEmailState {}

class PinEmailLoading extends PinEmailState {}

class PinEmailFailure extends PinEmailState {
  final String error;

  const PinEmailFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PinEmailFailure { error: $error }';
}

class PinEmailUninitialized extends PinEmailState {}

class PinEmailAuthenticated extends PinEmailState {}

class PinEmailUnauthenticated extends PinEmailState {}

class PinEmailAuthLoading extends PinEmailState {}
