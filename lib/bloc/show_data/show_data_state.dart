import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/model/response/show.dart';
import 'package:flutter_base/model/response/spesimen_response.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ShowDataState extends Equatable {
  const ShowDataState();

  @override
  List<Object> get props => [];
}

class ShowDataEmpty extends ShowDataState {}

class ShowDataInitial extends ShowDataState {
  final ShowAll showAll;
  final SpesimenResponse spesimen;

  const ShowDataInitial({@required this.showAll, this.spesimen});

  @override
  List<Object> get props => [showAll, spesimen];
}

class ShowDataLoading extends ShowDataState {}

class ShowDataFailure extends ShowDataState {
  final String error;

  const ShowDataFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ShowDataFailure { error: $error }';
}

class ShowSpesimenEmpty extends ShowDataState {}

class ShowSpesimenInitial extends ShowDataState {
  final SpesimenResponse showAll;

  const ShowSpesimenInitial({@required this.showAll});

  @override
  List<Object> get props => [showAll];
}

class ShowSpesimenLoading extends ShowDataState {}

class ShowSpesimenFailure extends ShowDataState {
  final String error;

  const ShowSpesimenFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ShowDataFailure { error: $error }';
}

class PostDataEmpty extends ShowDataState {}

class PostDataInitial extends ShowDataState {
}

class PostDataLoading extends ShowDataState {}

class PostDataFailure extends ShowDataState {
  final String error;

  const PostDataFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ShowDataFailure { error: $error }';
}
