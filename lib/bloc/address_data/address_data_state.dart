import 'package:flutter_base/model/response/address_data_response.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddressDataState extends Equatable {
  const AddressDataState();

  @override
  List<Object> get props => [];
}

class AddressDataInitial extends AddressDataState {}
class AddressDataUpdateInitial extends AddressDataState {}

class AddressDataLoading extends AddressDataState {}

class AddressDataFailure extends AddressDataState {
  final String error;

  const AddressDataFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddressDataFailure { error: $error }';
}


class SecondAddressDataInitial extends AddressDataState {}
class SecondAddressDataUpdateInitial extends AddressDataState {}

class SecondAddressDataLoading extends AddressDataState {}

class SecondAddressDataFailure extends AddressDataState {
  final String error;

  const SecondAddressDataFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddressDataFailure { error: $error }';
}

class GetAddressDataDataEmpty extends AddressDataState {}
class GetAddressDataDataInitial extends AddressDataState {
  final AddressDataResponse dataAddress;
  final AddressDataResponse secondAddress;

  const GetAddressDataDataInitial({@required this.dataAddress, @required this.secondAddress});
  @override
  List<Object> get props => [dataAddress, secondAddress];
}


class GetAddressDataDataLoading extends AddressDataState {}
class GetAddressDataDataFailure extends AddressDataState {
  final String error;
  const GetAddressDataDataFailure({@required this.error});
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddressDataFailure { error: $error }';
}


class GetSecondAddressDataEmpty extends AddressDataState {}
class GetSecondAddressDataInitial extends AddressDataState {
  final AddressDataResponse dataAddress;
  const GetSecondAddressDataInitial({@required this.dataAddress});
  @override
  List<Object> get props => [dataAddress];
}
class GetSecondAddressDataLoading extends AddressDataState {}
class GetSecondAddressDataFailure extends AddressDataState {
  final String error;
  const GetSecondAddressDataFailure({@required this.error});
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddressDataFailure { error: $error }';
}

