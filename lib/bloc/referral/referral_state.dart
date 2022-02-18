
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ReferralState extends Equatable {
  const ReferralState();

  @override
  List<Object> get props => [];
}

class ReferralInitial extends ReferralState {
}

class ReferralLoading extends ReferralState {}

class ReferralFailure extends ReferralState {
  final String error;

  const ReferralFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ShowDataFailure { error: $error }';
}
