import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UploadProfileState extends Equatable {
  const UploadProfileState();

  @override
  List<Object> get props => [];
}

class UploadProfileInitial extends UploadProfileState {}

class UploadProfileLoading extends UploadProfileState {}

class UploadProfileFailure extends UploadProfileState {
  final String error;

  const UploadProfileFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UploadProfileFailure { error: $error }';
}