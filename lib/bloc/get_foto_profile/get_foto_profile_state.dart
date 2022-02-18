import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/model/response/spesimen_response.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class GetFotoProfileState extends Equatable {
  const GetFotoProfileState();

  @override
  List<Object> get props => [];
}

class GetFotoProfileEmpty extends GetFotoProfileState {}

class GetFotoProfileInitial extends GetFotoProfileState {
  final SpesimenResponse getFotoProfile;

  const GetFotoProfileInitial({@required this.getFotoProfile});

  @override
  List<Object> get props => [getFotoProfile];
}

class GetFotoProfileLoading extends GetFotoProfileState {}

class GetFotoProfileFailure extends GetFotoProfileState {
  final String error;
  // final GetFotoProfileResponse GetFotoProfile;
  

  const GetFotoProfileFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GetFotoProfileFailure { error: $error }';
}
