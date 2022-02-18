import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SetPasswordState extends Equatable {
  const SetPasswordState();

  @override
  List<Object> get props => [];
}

class SetPasswordInitial extends SetPasswordState {}

class SetPasswordLoading extends SetPasswordState {}

class SetPasswordFailure extends SetPasswordState {
  final String error;

  const SetPasswordFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SetPasswordFailure { error: $error }';
}

// class SetPasswordUninitialized extends SetPasswordState {}

// class SetPasswordAuthenticated extends SetPasswordState {}

// class SetPasswordUnauthenticated extends SetPasswordState {}

// class SetPasswordAuthLoading extends SetPasswordState {}
