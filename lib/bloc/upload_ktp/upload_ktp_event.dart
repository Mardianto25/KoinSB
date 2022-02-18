import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UploadKtpEvent extends Equatable {
  const UploadKtpEvent();
  @override
  List<Object> get props => [];
}

class UploadKtpStarted extends UploadKtpEvent {}

class UploadKtpSuccess extends UploadKtpEvent {
  // final String ktp;

  // const UploadKtpSuccess({@required this.ktp});

  // @override
  // List<Object> get props => [ktp];

  // @override
  // String toString() => 'EmailIn { token: $ktp }';
}

class UploadKtpError extends UploadKtpEvent {}


class UploadKtpButtonPressed extends UploadKtpEvent {
  final usersFile;
  // final String public_id;  

  const UploadKtpButtonPressed({
    @required this.usersFile,
    // @required this.public_id,    
  });

  @override
  List<Object> get props => [usersFile];

  @override
  String toString() {
    return 'SubmittedKtp { usersFile: $usersFile }';
  }
  
}




