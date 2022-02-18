import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateAddressDataState extends Equatable {
  const UpdateAddressDataState();

  @override
  List<Object> get props => [];
}

class UpdateAddressDataInitial extends UpdateAddressDataState {}

class UpdateAddressDataLoading extends UpdateAddressDataState {}

class UpdateAddressDataFailure extends UpdateAddressDataState {
  final String error;

  const UpdateAddressDataFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UpdateAddressDataFailure { error: $error }';
}

