import 'package:flutter_base/model/response/religion.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class GeneralGetState extends Equatable {
  const GeneralGetState();

  @override
  List<Object> get props => [];
}

class GeneralGetEmpty extends GeneralGetState {}

class GeneralGetInitial extends GeneralGetState {
  final ResponseData general;

  const GeneralGetInitial({@required this.general});

  @override
  List<Object> get props => [general];
}

class GeneralGetLoading extends GeneralGetState {}

class GeneralGetFailure extends GeneralGetState {
  final String error;

  const GeneralGetFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GeneralGetFailure { error: $error }';
}
