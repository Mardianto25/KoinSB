import 'package:flutter_base/model/content/personal_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ReferralEvent extends Equatable {
  const ReferralEvent();
  @override
  List<Object> get props => [];
}


class ReferralButtonPressed extends ReferralEvent {
  final String publicId;
  final String refcode;
  

  const ReferralButtonPressed({
    @required this.publicId,
    @required this.refcode,
    
    // @required this.otpCode,
  });

  @override
  List<Object> get props => [publicId, refcode];

  @override
  String toString() {
    return 'Submitted {id: $publicId, ref: $refcode}';
  }
}


