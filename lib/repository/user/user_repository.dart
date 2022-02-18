import 'package:flutter_base/model/response/user_response.dart';
import 'package:flutter_base/repository/user/user_api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository{
  UserApiProvider _apiProvider = UserApiProvider();
  String _tokenString = "", _phoneString="";
  String _emailString = "";

  Future<UserResponse> getUser(){
    return _apiProvider.getUser();
  }

  // Future add(imei, phone, password){
  //   return _apiProvider.login(imei, phone, password);
  // }

  // Future login(data){
  //   return _apiProvider.loginModel(data);
  // }

  Future login(username, password, imei){
    return _apiProvider.loginModel(username, password, imei);
  }

  Future loginPiko(ktp, username, password, imei, piko){
    return _apiProvider.loginPiko(ktp, username, password, imei, piko);
  }

  Future register(ktp, firstName, lastName, imei, oneSignal){
    return _apiProvider.register(ktp, firstName, lastName, imei, oneSignal);
  }

  Future cekMember(rekening){
    return _apiProvider.cekMember(rekening);
  }

  Future cekStatus(ktp){
    return _apiProvider.cekStatus(ktp);
  }

  Future cekStatusLogin(token){
    return _apiProvider.cekStatusLogin(token);
  }

  Future emailOtp(email, ktp, imei){
    return _apiProvider.emailOtp(email, ktp, imei);
  }

  Future storeEmailOtp(email, ktp, imei, otp, otpId){
    return _apiProvider.storeEmailOtp(email, ktp, imei, otp, otpId);
  }

  Future phoneOtp(phone, ktp, imei){
    return _apiProvider.phoneOtp(phone, ktp, imei);
  }

  Future storePhoneOtp(phone, ktp, imei, otp, otpId){
    return _apiProvider.storePhoneOtp(phone, ktp, imei, otp, otpId);
  }

  Future storeLoginOtp(phone, ktp, imei, otp, otpId, piko, email, password){
    return _apiProvider.storeLoginOtp(phone, ktp, imei, otp, otpId, piko, email, password);
  }

  Future setPassword(ktp, imei, phone,email,name,password, isAnggota){
    return _apiProvider.setPassword(ktp, imei, phone,email,name,password, isAnggota);
  }

  Future getGeneral(type, publicId, auth){
    return _apiProvider.getGeneral(type, publicId, auth);
  }

  Future getPersonalData(type, auth){
    return _apiProvider.getPersonalData(type, auth);
  }

  Future getAddressData(type, auth){
    return _apiProvider.getAddressData(type, auth);
  }

  Future getSecondAddressData(type, auth){
    return _apiProvider.getSecondAddressData(type, auth);
  }

  Future getJobData(type, auth){
    return _apiProvider.getJobData(type, auth);
  }

  Future getGeneralParams(type, id, publicId, auth){
    return _apiProvider.getGeneralParams(type, id, publicId, auth);
  }

  Future getDataAll(public, auth){
    return _apiProvider.getShowData(public, auth);
  }

  Future getSpesimen(auth){
    return _apiProvider.getShowSpesimen(auth);
  }

  Future storeDataAll(public, auth){
    return _apiProvider.storeData(public, auth);
  }

  Future registerDone(public, auth){
    return _apiProvider.registerDone(public, auth);
  }

  Future referralCode(public, refCode, auth){
    return _apiProvider.referralCode(public, refCode, auth);
  }

  Future updatePersonalData(data, publicId, auth){
    return _apiProvider.updatePersonalData(data, publicId, auth);
  }

  Future changePersonalData(data, publicId, auth){
    return _apiProvider.changePersonalData(data, publicId, auth);
  }

  Future updateAddressData(data, publicId, auth){
    return _apiProvider.updateAddressData(data, publicId, auth);
  }

  Future changeAddressData(data, publicId, auth){
    return _apiProvider.changeAddressData(data, publicId, auth);
  }

  Future updateSecondAddress(data, publicId, auth){
    return _apiProvider.updateSecondAddress(data, publicId, auth);
  }

  Future changeSecondAddress(data, publicId, auth){
    return _apiProvider.changeSecondAddress(data, publicId, auth);
  }

  Future updateJobData(data, publicId, auth){
    return _apiProvider.updateJobData(data, publicId, auth);
  }

  Future changeJobData(data, publicId, auth){
    return _apiProvider.changeJobData(data, publicId, auth);
  }

  Future uploadKtp(userFile, token){
    return _apiProvider.uploadSelfie(userFile, token);
  }

  Future uploadSpesimen(spesimen, token){
    return _apiProvider.uploadSpesimen(spesimen, token);
  }


  Future sbmaxSimulasi(nominal, token){
    return _apiProvider.sbmaxNominal(nominal, token);
  }

  Future pinVerify(imei, pin, token){
    return _apiProvider.sbmaxPinVerify(imei, pin, token);
  }

  Future listRekeningKoin(token){
    return _apiProvider.listRekeningKoin(token);
  }

  Future listSimpanan(token){
    return _apiProvider.listSimpanan(token);
  }

  Future sbmaxDetailAnggota(noac,token){
    return _apiProvider.sbmaxDetailAnggota(noac,token);
  }

  Future sbmaxSimulasiDetail(data,token, no){
    return _apiProvider.sbmaxSimulasiDetail(data,token, no);
  }
  Future sbmaxSimulasiDetailNon(data,token){
    return _apiProvider.sbmaxSimulasiDetailNon(data,token);
  }

  Future sbmaxInisiasi(data,token, no){
    return _apiProvider.sbmaxInisiasi(data,token, no);
  }

  Future sbmaxPencairan(imei, noac, password, token){
    return _apiProvider.sbmaxPencairan(imei,noac, password, token);
  }
  

  Future getProfile(token){
    return _apiProvider.getProfile(token);
  }

  Future changePass(imei,old,newpass,token){
    return _apiProvider.changePass(imei,old, newpass, token);
  }

  Future uploadProfile(profile, token){
    return _apiProvider.uploadProfile(profile, token);
  }

  Future sentEmail(email,token){
    return _apiProvider.sentEmail(email, token);
  }

  Future verifyEmail(email,otpCode, otpId, token){
    return _apiProvider.verifyEmail(email, otpCode, otpId, token);
  }

  Future getFotoProfile(auth){
    return _apiProvider.getFotoProfile(auth);
  }

  Future cekFiturCoin(auth){
    return _apiProvider.cekFiturCoin(auth);
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    await Future.delayed(Duration(seconds: 1));
    return ;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    _tokenString = token;
    print(_tokenString);
    await Future.delayed(Duration(seconds: 1));
    return _tokenString;
  }

  Future<void> persistEmail(String email) async {
    /// write to keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    _emailString = email;
    await Future.delayed(Duration(seconds: 1));
    return _emailString;
  }

  Future<void> persistPhone(String phone) async {
    /// write to keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("phone", phone);
    _phoneString = phone;
    await Future.delayed(Duration(seconds: 1));
    return _phoneString;
  }

  Future<String> hasToken() async {
    /// read from keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tokenString = prefs.get("token");
    await Future.delayed(Duration(seconds: 1));
    return _tokenString;
  }

  Future<String> loginData() async {
    String data;
    /// read from keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.get("loginStatus");
    await Future.delayed(Duration(seconds: 1));
    return data;
  }

  Future<String> registerData() async {
    String data;
    /// read from keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.get("registerStatus");
    await Future.delayed(Duration(seconds: 1));
    return data;
  }

  

  Future<bool> hasEmail() async {
    /// read from keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.get("email");
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

  Future<bool> hasPhone() async {
    /// read from keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.get("phone");
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
  

}