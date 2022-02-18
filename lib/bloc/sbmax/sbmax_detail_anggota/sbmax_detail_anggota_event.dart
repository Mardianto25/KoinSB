import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class SbmaxDetailAnggotaEvent extends Equatable {
  const SbmaxDetailAnggotaEvent();

  @override
  List<Object> get props => [];
}

class SubmittedSbmaxDetailAnggota extends SbmaxDetailAnggotaEvent {
  final String noac;

  const SubmittedSbmaxDetailAnggota({
    @required this.noac
    // @required this.otpCode,
  });

  @override
  List<Object> get props => [noac];
}
