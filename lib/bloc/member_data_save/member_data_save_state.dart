
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MemberDataSaveState extends Equatable {
  const MemberDataSaveState();

  @override
  List<Object> get props => [];
}

class MemberDataSaveInitial extends MemberDataSaveState {
  
}

class MemberDataSaveLoading extends MemberDataSaveState {}

class MemberDataSaveFailure extends MemberDataSaveState {
  final String error;

  const MemberDataSaveFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ShowDataFailure { error: $error }';
}
