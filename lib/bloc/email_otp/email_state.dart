import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class EmailState extends Equatable {
  const EmailState();

  @override
  List<Object> get props => [];
}

class EmailInitial extends EmailState {}

class EmailLoading extends EmailState {}

class EmailFailure extends EmailState {
  final String error;

  const EmailFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EmailFailure { error: $error }';
}

// class EmailUninitialized extends EmailState {}

// class EmailAuthenticated extends EmailState {}

// class EmailUnauthenticated extends EmailState {}

// class EmailAuthLoading extends EmailState {}
