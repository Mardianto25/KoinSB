import 'package:flutter_base/model/content/personal_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MemberDataSaveEvent extends Equatable {
  const MemberDataSaveEvent();
  @override
  List<Object> get props => [];
}


class MemberDataButtonPressed extends MemberDataSaveEvent {
  final String publicId;

  const MemberDataButtonPressed({
    @required this.publicId,
    
    // @required this.otpCode,
  });

  @override
  List<Object> get props => [publicId];

  @override
  String toString() {
    return 'Submitted {id: $publicId}';
  }
}


