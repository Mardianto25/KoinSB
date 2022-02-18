import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UploadProfileEvent extends Equatable {
  const UploadProfileEvent();
  @override
  List<Object> get props => [];
}

class UploadProfileStarted extends UploadProfileEvent {}

class UploadProfileSuccess extends UploadProfileEvent {
  final String uploadProfile;

  const UploadProfileSuccess({@required this.uploadProfile});

  @override
  List<Object> get props => [uploadProfile];

  @override
  String toString() => 'Upload { token: $uploadProfile }';
}

class UploadProfileError extends UploadProfileEvent {}


class UploadProfileButtonPressed extends UploadProfileEvent {
  final uploadProfile;

  const UploadProfileButtonPressed({
    @required this.uploadProfile,
    // @required this.otpCode,
  });

  @override
  List<Object> get props => [uploadProfile];

  @override
  String toString() {
    return 'SubmittedUploadProfile { UploadProfile: $uploadProfile }';
  }
  
}




