import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class ListRekeningEvent extends Equatable {
  const ListRekeningEvent();

  @override
  List<Object> get props => [];
}

class SubmittedListRekening extends ListRekeningEvent {}
