import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SetPasswordEvent extends Equatable {
  const SetPasswordEvent();
  @override
  List<Object> get props => [];
}

class SetPasswordButtonPressed extends SetPasswordEvent {
  final String ktp;
  final String imei;
  final String phone;  
  final String email;
  final String name;
  final String password;
  final int isAnggota;
  

  const SetPasswordButtonPressed({
    @required this.ktp,
    @required this.imei,
    @required this.phone,
    @required this.email,
    @required this.name,
    @required this.password, 
    @required this.isAnggota,    
  });

  @override
  List<Object> get props => [ktp, imei, phone, email, name, password, isAnggota];

  @override
  String toString() {
    return 'SubmittedEmail { ktp: $ktp, imei: $imei, phone: $phone, email:$email, name:$name, password:$password, is: $isAnggota }';
  }
  
}




