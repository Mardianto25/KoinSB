import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SpesimenEvent extends Equatable {
  const SpesimenEvent();
  @override
  List<Object> get props => [];
}

class SpesimenStarted extends SpesimenEvent {}

class SpesimenSuccess extends SpesimenEvent {
  final String spesimen;

  const SpesimenSuccess({@required this.spesimen});

  @override
  List<Object> get props => [spesimen];

  @override
  String toString() => 'EmailIn { token: $spesimen }';
}

class SpesimenError extends SpesimenEvent {}


class SpesimenButtonPressed extends SpesimenEvent {
  final spesimen;

  const SpesimenButtonPressed({
    @required this.spesimen,
    // @required this.otpCode,
  });

  @override
  List<Object> get props => [spesimen];

  @override
  String toString() {
    return 'SubmittedSpesimen { spesimen: $spesimen }';
  }
  
}




