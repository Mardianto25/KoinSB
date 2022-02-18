import 'package:flutter_base/model/content/address_data.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddressDataEvent extends Equatable {
  const AddressDataEvent();
  @override
  List<Object> get props => [];
}

class AddressDataStarted extends AddressDataEvent {}
class AddressDataSuccess extends AddressDataEvent {}
class AddressDataError extends AddressDataEvent {}
class AddressDataButtonPressed extends AddressDataEvent {
  final AddressDataContent dataAddress;

  const AddressDataButtonPressed({
    @required this.dataAddress
    }) : assert(dataAddress != null);

  @override
  List<Object> get props => [dataAddress] ;

  // @override
  // String toString() {
  //   return 'SubmittedEmail { Data: $dataAddress }';
  // }
  
}
class SecondAddressButtonPressed extends AddressDataEvent {
  final AddressDataContent dataAddress;

  const SecondAddressButtonPressed({
    @required this.dataAddress
    }) : assert(dataAddress != null);

  @override
  List<Object> get props => [dataAddress] ;

  // @override
  // String toString() {
  //   return 'SubmittedEmail { Data: $dataAddress }';
  // }
  
}

class GetAddressDataStarted extends AddressDataEvent {}
class GetAddressDataSuccess extends AddressDataEvent {}
class GetAddressDataError extends AddressDataEvent {}
class GetAddressDataButtonPressed extends AddressDataEvent {
  final String type;

  const GetAddressDataButtonPressed({
    @required this.type
    }) : assert(type != null);

  @override
  List<Object> get props => [type] ;
}

class GetSecondAddressButtonPressed extends AddressDataEvent {
  final String type;

  const GetSecondAddressButtonPressed({
    @required this.type
    }) : assert(type != null);

  @override
  List<Object> get props => [type] ;
}




