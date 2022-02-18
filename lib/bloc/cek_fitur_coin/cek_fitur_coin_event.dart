import 'package:flutter_base/model/content/personal_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CekFiturCoinEvent extends Equatable {
  const CekFiturCoinEvent();
  @override
  List<Object> get props => [];
}

class CekFiturCoinStarted extends CekFiturCoinEvent {}

class CekFiturCoinSuccess extends CekFiturCoinEvent {
  
}

class CekFiturCoinError extends CekFiturCoinEvent {}


class CekFiturCoinButtonPressed extends CekFiturCoinEvent {
  // final String status;

  // const CekFiturCoinButtonPressed({
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



