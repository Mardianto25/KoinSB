import 'package:flutter_base/model/content/personal_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ShowDataEvent extends Equatable {
  const ShowDataEvent();
  @override
  List<Object> get props => [];
}


class ShowDataButtonPressed extends ShowDataEvent {
  final String publicId;

  const ShowDataButtonPressed({
    @required this.publicId
    // @required this.otpCode,
  });

  @override
  List<Object> get props => [publicId];

  @override
  String toString() {
    return 'Submitted { param: $publicId}';
  }
}

class ShowSpesimenButtonPressed extends ShowDataEvent {
}


class PostDataButtonPressed extends ShowDataEvent {
  final String publicId;

  const PostDataButtonPressed({
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


