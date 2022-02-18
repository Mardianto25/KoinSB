import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PinPhoneState extends Equatable {
  const PinPhoneState();

  @override
  List<Object> get props => [];
}

class PinPhoneInitial extends PinPhoneState {}
class PinPhonePikoInitial extends PinPhoneState {}
class PinPhonePikoFailure extends PinPhoneState {
  final String error;

  const PinPhonePikoFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PinPhoneFailure { error: $error }';
}


class PinPhoneLoading extends PinPhoneState {}

class PinPhoneFailure extends PinPhoneState {
  final String error;

  const PinPhoneFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PinPhoneFailure { error: $error }';
}

class PinPhoneUninitialized extends PinPhoneState {}

class PinPhoneAuthenticated extends PinPhoneState {}

class PinPhoneUnauthenticated extends PinPhoneState {}

class PinPhoneAuthLoading extends PinPhoneState {}
