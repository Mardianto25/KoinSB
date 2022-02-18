import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class ListSimpananEvent extends Equatable {
  const ListSimpananEvent();

  @override
  List<Object> get props => [];
}

class SubmittedListSimpanan extends ListSimpananEvent {}
