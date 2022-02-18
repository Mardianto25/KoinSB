import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class StoreRekeningCoinEvent extends Equatable {
  const StoreRekeningCoinEvent();
  @override
  List<Object> get props => [];
}

class StoreRekeningCoinButtonPressed extends StoreRekeningCoinEvent {
  final String rekening;
  

  const StoreRekeningCoinButtonPressed({
    @required this.rekening   
  });

  @override
  List<Object> get props => [rekening];

  @override
  String toString() {
    return 'Submitted { rekening: $rekening }';
  }
  
}




