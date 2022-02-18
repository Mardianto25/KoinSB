import 'package:flutter_base/model/content/personal_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class ProfileStarted extends ProfileEvent {}

class ProfileSuccess extends ProfileEvent {
  
}

class ProfileError extends ProfileEvent {}


class ProfileButtonPressed extends ProfileEvent {
  // final String status;

  // const ProfileButtonPressed({
  //   @required this.status
  //   // @required this.otpCode,
  // });

  // @override
  // List<Object> get props => [status];

  // @override
  // String toString() {
  //   return 'Submitted { param: $status}';
  // }
}


class GetHomeButtonPressed extends ProfileEvent {
  
}



