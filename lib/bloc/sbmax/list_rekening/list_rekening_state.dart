import 'package:flutter_base/model/response/list_rekening.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ListRekeningState extends Equatable {
  const ListRekeningState();

  @override
  List<Object> get props => [];
}

class ListRekeningInitial extends ListRekeningState {
  final ListRekening listRekening;

  const ListRekeningInitial({@required this.listRekening});

  @override
  List<Object> get props => [listRekening];
}

class ListRekeningLoading extends ListRekeningState {}

class ListRekeningFailure extends ListRekeningState {
  final String error;

  const ListRekeningFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ListRekeningFailure { error: $error }';
}
