import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/profile.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/model/response/spesimen_response.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileEmpty extends ProfileState {}

class ProfileInitial extends ProfileState {
  final ProfileResponse profile;
  final SpesimenResponse foto;

  const ProfileInitial({@required this.profile, @required this.foto});

  @override
  List<Object> get props => [profile, foto];
}

class ProfileLoading extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String error;
  final ProfileResponse profile;
  

  const ProfileFailure({@required this.error, @required this.profile});

  @override
  List<Object> get props => [error, profile];

  @override
  String toString() => 'ProfileFailure { error: $error, $profile }';
}



class GetHomeEmpty extends ProfileState {}

class GetHomeInitial extends ProfileState {
  final ProfileResponse home;

  const GetHomeInitial({@required this.home});

  @override
  List<Object> get props => [home];
}

class GetHomeLoading extends ProfileState {}

class GetHomeFailure extends ProfileState {
  final String error;
  final ProfileResponse home;
  

  const GetHomeFailure({@required this.error, @required this.home});

  @override
  List<Object> get props => [error, home];

  @override
  String toString() => 'ProfileFailure { error: $error }';
}
