import 'package:flutter_base/model/content/address_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateAddressDataEvent extends Equatable {
  const UpdateAddressDataEvent();
  @override
  List<Object> get props => [];
}

class UpdateAddressDataStarted extends UpdateAddressDataEvent {}

class UpdateAddressDataSuccess extends UpdateAddressDataEvent {
  
}

class UpdateAddressDataError extends UpdateAddressDataEvent {}


class UpdateAddressDataButtonPressed extends UpdateAddressDataEvent {
  final AddressDataContent dataAddress;

  const UpdateAddressDataButtonPressed({
    @required this.dataAddress
    }) : assert(dataAddress != null);

  @override
  List<Object> get props => [dataAddress] ;

  // @override
  // String toString() {
  //   return 'SubmittedEmail { Data: $dataAddress }';
  // }
  
}




