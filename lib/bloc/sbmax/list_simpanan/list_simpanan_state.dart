import 'package:flutter_base/model/response/list_rekening.dart';
import 'package:flutter_base/model/response/list_simpanan.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ListSimpananState extends Equatable {
  const ListSimpananState();

  @override
  List<Object> get props => [];
}

class ListSimpananInitial extends ListSimpananState {
  final ListSimpanan listSimpanan;

  const ListSimpananInitial({@required this.listSimpanan});

  @override
  List<Object> get props => [listSimpanan];
}

class ListSimpananLoading extends ListSimpananState {}

class ListSimpananFailure extends ListSimpananState {
  final String error;

  const ListSimpananFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ListSimpananFailure { error: $error }';
}
