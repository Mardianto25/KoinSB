import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_base/bloc/auth_provider.dart';
import 'package:flutter_base/model/content/address_data.dart';
import 'package:flutter_base/model/content/job_data.dart';
import 'package:flutter_base/model/content/personal_data.dart';
import 'package:flutter_base/model/content/sbmax_inisiasi.dart';
import 'package:flutter_base/model/content/sbmax_simulasi_detail.dart';
import 'package:flutter_base/model/response/address_data_response.dart';
import 'package:flutter_base/model/response/cek_fitur_coin.dart';
import 'package:flutter_base/model/response/cek_status.dart';
import 'package:flutter_base/model/response/data_personal_response.dart';
import 'package:flutter_base/model/response/job_data_response.dart';
import 'package:flutter_base/model/response/list_rekening.dart';
import 'package:flutter_base/model/response/list_simpanan.dart';
import 'package:flutter_base/model/response/login_cek_status.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/model/response/otp_response.dart';
import 'package:flutter_base/model/response/profile.dart';
import 'package:flutter_base/model/response/register_done.dart';
import 'package:flutter_base/model/response/register_response.dart';
import 'package:flutter_base/model/response/rekeing_coin.dart';
import 'package:flutter_base/model/response/religion.dart';
import 'package:flutter_base/model/response/response_login.dart';
import 'package:flutter_base/model/response/sbmax_detail.dart';
import 'package:flutter_base/model/response/sbmax_pin_response.dart';
import 'package:flutter_base/model/response/sbmax_simulasi.dart';
import 'package:flutter_base/model/response/sbmax_simulasi_detail_response.dart';
import 'package:flutter_base/model/response/show.dart';
import 'package:flutter_base/model/response/spesimen_response.dart';
import 'package:flutter_base/model/response/user_response.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_provider.dart';

class UserApiProvider extends BaseProvider{
  final String _endpoint = BaseProvider.baseUrl + "";
  final String _asesme = BaseProvider.basAsesme ;  
  final String _login = BaseProvider.baseUrlPost + "unauthorized/proxy";
  final String _auth = BaseProvider.baseUrlPost + "interfaces/proxy";
  final String _form = BaseProvider.baseUrlPost + "interfaces/form/proxy";
  
  
  final Dio _dio = Dio();

  final AuthProvider authProvider = AuthProvider();

  Future<UserResponse> getUser() async {
    try {
      Response response = await _dio.get(_endpoint);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  

  Future<int> login(String imei, String phoneNumber, String password) async {
    print(phoneNumber);
    try {
      Response response = await _dio.post(_login, data:{
        "public_id": "6248fe24-2393-4aae-965a-6cf5fe1c5064",
        "imei": "354921076706315",
        "phonenumber": phoneNumber.toString(),
        "password": password.toString()
      });
      print(response.statusCode);
      return response.statusCode;

    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }
  
  Future<CekStatusResponse> cekStatus(ktp) async {
    try {
      Response response = await _dio.post(_login, data: {
        "no_ktp": ktp,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "3670c3f0-176a-4725-8dec-5d3b976a1ebd"
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return CekStatusResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<RekeningCoin> cekMember(rekening) async {
    try {
      Response response = await _dio.post(_login, data: {
        "koinku": rekening,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "9a7d24a2-e23d-41a0-acec-1e9d4eb2c081"
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return RekeningCoin.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<ResponseLogin> loginModel(phone, password, imei) async {
    print(imei);
    try {
      Response response = await _dio.post(_login, data: {
        "imei": imei,
        "phonenumber": phone,
        "password": password
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "6248fe24-2393-4aae-965a-6cf5fe1c5064"
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return ResponseLogin.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<ResponseLogin> loginPiko(ktp, phone, password, imei, piko) async {
    try {
      Response response = await _dio.post(_login, data: {
        "no_ktp": ktp,
        "imei": imei,
        "phonenumber": phone,
        "password": password,
        "piko_status": piko
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "6248fe24-2393-4aae-965a-6cf5fe1c5064"
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return ResponseLogin.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  // Register

  Future<RegisterResponse> register(ktp, firstName, lastName, imei, oneSignal) async {
    print(oneSignal);
    try {
      Response response = await _dio.post(_login, data: {
        "no_ktp": ktp.toString(),
        "first_name": firstName.toString(),
        "last_name":lastName.toString(),
        "imei": imei,
        "onesignal_id": oneSignal
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "d92f63db-17c7-4000-8a30-9af5ec45e22a"
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return RegisterResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<OtpResponse> emailOtp(email, ktp, imei) async {
    try {
      Response response = await _dio.post(_login, data: {
        "email_address": email,
        "imei": imei,
        "no_ktp": ktp
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "79e5c007-4fdb-4de9-9997-55880fd7afeb"
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return OtpResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginResponse> storeEmailOtp(email, ktp, imei, otp, otpId) async {
    print(email+ktp+imei+otp);
    try {
      Response response = await _dio.post(_login, data: {
        "email_address": email,
        "imei": imei,
        "no_ktp": ktp,
        "otp_code": otp,
        "otp_id": otpId
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "79e5c007-4fdb-4de9-9997-55880fd7afeb"
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<OtpResponse> phoneOtp(phone, ktp, imei) async {
    try {
      Response response = await _dio.post(_login, data: {
        "phonenumber": phone,
        "imei": imei,
        "no_ktp": ktp,
        // "otp_code": otp
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "79e5c007-4fdb-4de9-9997-55880fd7afeb"
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return OtpResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginResponse> storePhoneOtp(phone, ktp, imei, otp, otpId) async {
    try {
      Response response = await _dio.post(_login, data: {
        "phonenumber": phone,
        "imei": imei,
        "no_ktp": ktp,
        "otp_code": otp,
        "otp_id": otpId
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "79e5c007-4fdb-4de9-9997-55880fd7afeb"
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response.statusCode);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginResponse> storeLoginOtp(phone, ktp, imei, otp, otpId, piko, email, password) async {
    print(password + otp + email + phone+ ktp + imei );
    print(piko);
    try {
      Response response = await _dio.post(_login, data: {
        "phonenumber": phone,
        "imei": imei,
        "no_ktp": ktp,
        "otp_code": otp,
        "otp_id": otpId,
        "piko_status": piko,
        "email": email,
        "password": password
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "79e5c007-4fdb-4de9-9997-55880fd7afeb"
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

   Future<ResponseLogin> setPassword(ktp, imei, phone, email, name, password, isAnggota) async {
    print(imei);
    try {
      Response response = await _dio.post(_login, data: {
        "no_ktp": ktp,
        "imei": imei,
        "phonenumber": phone,
        "email": email,
        "name": name,
        "password": password,
        "is_anggota": isAnggota
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "2938defc-d079-4f10-95cd-e25e2c7d55de"
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return ResponseLogin.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  // Member DATA

  Future<LoginResponse> updatePersonalData(PersonalDataContent data,String publicId, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
        "nomor_ektp": (data.nomorEktp == null) ? "" : data.nomorEktp,
        "nama_lengkap": (data.namaLengkap == null) ? "" : data.namaLengkap,
        "tempat_lahir": (data.tempatLahir == null) ? "" : data.tempatLahir,
        "tanggal_lahir": (data.tanggalLahir == null) ? "" : data.tanggalLahir,
        "jenis_kelamin": (data.jenisKelamin == null) ? "" : data.jenisKelamin,
        "agama": (data.agama == null) ? "" : data.agama,
        "nama_ibu_kandung": (data.namaIbuKandung == null) ? "" : data.namaIbuKandung,
        "status_perkawinan": (data.statusPerkawinan == null) ? "" : data.statusPerkawinan,
        "pendidikan_terakhir": (data.pendidikanTerakhir == null) ? "" : data.pendidikanTerakhir,
        "gelar": (data.gelar == null) ? "" : data.gelar,
        "kontak_darurat": (data.kontakDarurat == null) ? "" : data.kontakDarurat,
        "hubungan_kontak_darurat": (data.hubunganKontakDarurat == null) ? "" : data.hubunganKontakDarurat,
      },
      options: Options(
          headers: {
            "Content-Type": "application/json",
            "service_id": "d22433b1-42c9-4d12-b494-25b986f0a38b",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginResponse> changePersonalData(PersonalDataContent data,String publicId, String auth) async {
    try {
      // print(data.agama);
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
        "type": "data_personal",
        "nomor_ektp": (data.nomorEktp == null) ? "" : data.nomorEktp,
        "nama_lengkap": (data.namaLengkap == null) ? "" : data.namaLengkap,
        "tempat_lahir": (data.tempatLahir == null) ? "" : data.tempatLahir,
        "tanggal_lahir": (data.tanggalLahir == null) ? "" : data.tanggalLahir,
        "jenis_kelamin": (data.jenisKelamin == null) ? "" : data.jenisKelamin,
        "agama": (data.agama == null) ? "" : data.agama,
        "nama_ibu_kandung": (data.namaIbuKandung == null) ? "" : data.namaIbuKandung,
        "status_perkawinan": (data.statusPerkawinan == null) ? "" : data.statusPerkawinan,
        "pendidikan_terakhir": (data.pendidikanTerakhir == null) ? "" : data.pendidikanTerakhir,
        "gelar": (data.gelar == null) ? "" : data.gelar,
        "kontak_darurat": (data.kontakDarurat == null) ? "" : data.kontakDarurat,
        "hubungan_kontak_darurat": (data.hubunganKontakDarurat == null) ? "" : data.hubunganKontakDarurat,
      },
      options: Options(
          headers: {
            "Content-Type": "application/json",
            "service_id": "cff44aa7-1860-4960-99d8-4c2fcabc04d0",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginResponse> updateAddressData(AddressDataContent data,String publicId, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
        "status_rumah": (data.statusRumah == null) ? "" : data.statusRumah,
        "alamat_lengkap": (data.alamatLengkap == null) ? "" : data.alamatLengkap,
        "provinsi": (data.provinsi == null) ? "" : data.provinsi,
        "kota_kabupaten": (data.kotaKabupaten == null) ? "" : data.kotaKabupaten,
        "kecamatan": (data.kecamatan == null) ? "" : data.kecamatan,
        "kelurahan": (data.kelurahan == null) ? "" : data.kelurahan,
        "kode_pos": (data.kodePos == null) ? "" : data.kodePos,
        "is_ktp_address": (data.isKtpAddress == null) ? "" : data.isKtpAddress
      },
      options: Options(
          headers: {
            "Content-Type": "application/json",
            "service_id": "32cca189-285b-4dd6-b020-f314af9bc69d",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginResponse> changeAddressData(AddressDataContent data,String publicId, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
        "type": "address",
        "status_rumah": (data.statusRumah == null) ? "" : data.statusRumah,        
        "alamat_lengkap": (data.alamatLengkap == null) ? "" : data.alamatLengkap,
        "provinsi": (data.provinsi == null) ? "" : data.provinsi,
        "kota_kabupaten": (data.kotaKabupaten == null) ? "" : data.kotaKabupaten,
        "kecamatan": (data.kecamatan == null) ? "" : data.kecamatan,
        "kelurahan": (data.kelurahan == null) ? "" : data.kelurahan,
        "kode_pos": (data.kodePos == null) ? "" : data.kodePos,
        "is_ktp_address": (data.isKtpAddress == null) ? "" : data.isKtpAddress
      },
      options: Options(
          headers: {
            "Content-Type": "application/json",
            "service_id": "cff44aa7-1860-4960-99d8-4c2fcabc04d0",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginCekStatusResponse> cekStatusLogin(String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {},
      options: Options(
          headers: {
            "Content-Type": "application/json",
            "service_id": "750b9bef-0cdf-46cb-8a65-51f5bdc63951",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
      );
      print(response);
      return LoginCekStatusResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginResponse> updateSecondAddress(AddressDataContent data,String publicId, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
        "status_rumah": (data.statusRumah == null) ? "" : data.statusRumah,
        "alamat_lengkap": (data.alamatLengkap == null) ? "" : data.alamatLengkap,
        "provinsi": (data.provinsi == null) ? "" : data.provinsi,
        "kota_kabupaten": (data.kotaKabupaten == null) ? "" : data.kotaKabupaten,
        "kecamatan": (data.kecamatan == null) ? "" : data.kecamatan,
        "kelurahan": (data.kelurahan == null) ? "" : data.kelurahan,
        "kode_pos": (data.kodePos == null) ? "" : data.kodePos,
        "is_ktp_address": (data.isKtpAddress == null) ? "" : data.isKtpAddress
      },
      options: Options(
          headers: {
            "Content-Type": "application/json",
            "service_id": "42164ae6-86cf-42e9-a5cb-471231e1c93d",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginResponse> changeSecondAddress(AddressDataContent data,String publicId, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
        "type": "second_address",
        "status_rumah": (data.statusRumah == null) ? "" : data.statusRumah,        
        "alamat_lengkap": (data.alamatLengkap == null) ? "" : data.alamatLengkap,
        "provinsi": (data.provinsi == null) ? "" : data.provinsi,
        "kota_kabupaten": (data.kotaKabupaten == null) ? "" : data.kotaKabupaten,
        "kecamatan": (data.kecamatan == null) ? "" : data.kecamatan,
        "kelurahan": (data.kelurahan == null) ? "" : data.kelurahan,
        "kode_pos": (data.kodePos == null) ? "" : data.kodePos,
        "is_ktp_address": (data.isKtpAddress == null) ? "" : data.isKtpAddress
      },
      options: Options(
          headers: {
            "Content-Type": "application/json",
            "service_id": "cff44aa7-1860-4960-99d8-4c2fcabc04d0",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginResponse> updateJobData(JobDataContent data, String publicId, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
        "jenis_pekerjaan": (data.jenisPekerjaan == null) ? "" : data.jenisPekerjaan,
        "nama_instansi": (data.namaInstansi == null) ? "" : data.namaInstansi,
        "status_pekerjaan": (data.statusPekerjaan == null) ? "" : data.statusPekerjaan,
        "lama_bekerja": (data.lamaBekerja == null) ? "" : data.lamaBekerja
      },
      options: Options(
          headers: {
            "Content-Type": "application/json",
            "service_id": "89e1dfc0-a8d7-41b9-88de-b10beed7b370",            
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

 Future<LoginResponse> changeJobData(JobDataContent data, String publicId, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
        "type": "jobs",
        "jenis_pekerjaan": (data.jenisPekerjaan == null) ? "" : data.jenisPekerjaan,
        "nama_instansi": (data.namaInstansi == null) ? "" : data.namaInstansi,
        "status_pekerjaan": (data.statusPekerjaan == null) ? "" : data.statusPekerjaan,
        "lama_bekerja": (data.lamaBekerja == null) ? "" : data.lamaBekerja
      },
      options: Options(
          headers: {
            "Content-Type": "application/json",
            "service_id": "cff44aa7-1860-4960-99d8-4c2fcabc04d0",            
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<General> getGeneral(String type,String publicId, String auth) async {
    print(auth);
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId.toString(),
        // "public_id": "a9be7fd4-3d90-48e5-b138-1cd96fb68e3e",
        "type": type
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"96aabcac-5102-4629-a132-b16a2922029e",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return General.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<PersonalDataResponse> getPersonalData(String type, String auth) async {
    print(auth);
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId.toString(),
        // "public_id": "a9be7fd4-3d90-48e5-b138-1cd96fb68e3e",
        "type": type
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"5773b1fd-6520-447f-a5cf-9d9a0f7df0aa",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return PersonalDataResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<AddressDataResponse> getAddressData(String type, String auth) async {
    print(auth);
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId.toString(),
        // "public_id": "a9be7fd4-3d90-48e5-b138-1cd96fb68e3e",
        "type": type
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"5773b1fd-6520-447f-a5cf-9d9a0f7df0aa",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return AddressDataResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<AddressDataResponse> getSecondAddressData(String type, String auth) async {
    print(auth);
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId.toString(),
        // "public_id": "a9be7fd4-3d90-48e5-b138-1cd96fb68e3e",
        "type": type
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"5773b1fd-6520-447f-a5cf-9d9a0f7df0aa",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return AddressDataResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<JobDataResponse> getJobData(String type, String auth) async {
    print(auth);
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId.toString(),
        // "public_id": "a9be7fd4-3d90-48e5-b138-1cd96fb68e3e",
        "type": type
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"5773b1fd-6520-447f-a5cf-9d9a0f7df0aa",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return JobDataResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<General> getGeneralParams(String type,String id, String publicId, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
        // "public_id": "a9be7fd4-3d90-48e5-b138-1cd96fb68e3e",        
        "type": type,
        "pattern_id": id
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"d5de701e-54fb-441c-aaaf-816f345004e9",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return General.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<ShowAll> getShowData(String publicId, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"ecc7d0c7-6e80-4529-9f4f-6dad76ad8607",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return ShowAll.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<SpesimenResponse> getShowSpesimen(String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"5026af40-a99a-4053-a6a3-6a5692e737bd",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return SpesimenResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }
  

  Future<LoginResponse> uploadSelfie(File imageFile, String _auth) async {
    //for upload
    FormData formData = new FormData();
    formData.add("userfiles", new UploadFileInfo(imageFile, "SELFIE-KTP.png"));
    // formData.add("public_id", "17211398-d240-4655-a39d-400c93c1d99d");
    try {
       Response response = await _dio.post(_form, data: formData,
        options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "cd6bc759-abba-4bb5-9469-02fd22eec063",
          "Authorization": "Bearer $_auth"
          
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginResponse> uploadSpesimen(File imageFile, String _auth) async {
    //for upload
    FormData formData = new FormData();
    formData.add("userfiles",new UploadFileInfo(imageFile, "SPESIMEN.png"));
    // formData.add("public_id", "17211398-d240-4655-a39d-400c93c1d99d");
    try {
       Response response = await _dio.post(_form, data: formData,
        options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "cd6bc759-abba-4bb5-9469-02fd22eec063",
          "Authorization": "Bearer $_auth"
          
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginResponse> uploadProfile(File imageFile, String _auth) async {
    //for upload
    FormData formData = new FormData();
    formData.add("userfiles",new UploadFileInfo(imageFile, "PROFILE.png"));
    // formData.add("public_id", "17211398-d240-4655-a39d-400c93c1d99d");
    try {
       Response response = await _dio.post(_form, data: formData,
        options: Options(
        headers: {
          "Content-Type": "application/json",
          "service_id": "70dad021-084f-4d1e-88f2-867a8b3f42e9",
          "Authorization": "Bearer $_auth"
          
        },
        method: 'POST',
        responseType: ResponseType.json, // or ResponseType.JSON,
        validateStatus: (status) { return status < 500; },// or ResponseType.JSON
      )
      );
      print(response);
      return LoginResponse.fromJson(response.data);

     } on DioError catch(e){
      print(e);
      throw (e.message);
      
    }
  }

  Future<LoginResponse> storeData(String publicId, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"63db79c5-565e-4642-9022-0fdde58d0eb4",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return LoginResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<RegisterDone> registerDone(String publicId, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"750b9bef-0cdf-46cb-8a65-51f5bdc63951",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return RegisterDone.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<LoginResponse> referralCode(String publicId,String refCode, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        // "public_id": publicId,
        "refcode": refCode
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"f62a40f8-6f11-46e2-85ed-ccfc822f328d",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return LoginResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  // SBMAX

  Future<SbmaxSimulasiResponse> sbmaxNominal(nominal, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        "nominal": nominal
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"03595930-61d4-4391-87ba-7c96c7f2a4c9",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return SbmaxSimulasiResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<SbmaxPinResponse> sbmaxPinVerify(String imei, String pin, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        "imei": imei,
	      "pin": pin
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"8d9bc785-3e53-447d-833e-44239393d91b",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return SbmaxPinResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<ListRekening> listRekeningKoin(String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {}, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"77382fea-d49d-4740-984c-419bb90cb020",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return ListRekening.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<ListSimpanan> listSimpanan(String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        "status": "inprogress"
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"9fafe358-120b-44bd-81d2-10dde7c29a53",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return ListSimpanan.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<SbmaxDetail> sbmaxDetailAnggota(String noac, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        "noac": noac
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"6bb0cda8-6fe9-414d-853a-ed4d74564c74",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return SbmaxDetail.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<SbmaxSimulasiDetailResponse> sbmaxSimulasiDetail(SbmaxSimulasiDetail dataSimulasi, String auth, String no) async {
    try {
      Response response = await _dio.post(_auth, data: {
          "jasa": (dataSimulasi.jasa == null) ? "" : dataSimulasi.jasa,
          "nominal": (dataSimulasi.nominal == null) ? "" : dataSimulasi.nominal,
          "nominal_jasa": (dataSimulasi.nominalJasa == null) ? "" : dataSimulasi.nominalJasa,
          "nominal_total":(dataSimulasi.nominalTotal == null) ? "" : dataSimulasi.nominalTotal,          
          "tenor": (dataSimulasi.tenor == null) ? "" : dataSimulasi.tenor,
          "accountno": no
        }, 
        options: 
          Options(
            headers: {
              "Content-Type": "application/json",
              "service_id":"8b4028a6-6533-4ee2-ae44-2dc4aa3dca4b",
              "Authorization": "Bearer $auth"
            },
            method: 'POST',
            responseType: ResponseType.json, // or ResponseType.JSON,
            validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
        );      
      return SbmaxSimulasiDetailResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<SbmaxSimulasiDetailResponse> sbmaxSimulasiDetailNon(SbmaxSimulasiDetail dataSimulasi, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
          "jasa": (dataSimulasi.jasa == null) ? "" : dataSimulasi.jasa,
          "nominal": (dataSimulasi.nominal == null) ? "" : dataSimulasi.nominal,
          "nominal_jasa": (dataSimulasi.nominalJasa == null) ? "" : dataSimulasi.nominalJasa,
          "nominal_total":(dataSimulasi.nominalTotal == null) ? "" : dataSimulasi.nominalTotal,
          "tenor": (dataSimulasi.tenor == null) ? "" : dataSimulasi.tenor
        }, 
        options: 
          Options(
            headers: {
              "Content-Type": "application/json",
              "service_id":"8b4028a6-6533-4ee2-ae44-2dc4aa3dca4b",
              "Authorization": "Bearer $auth"
            },
            method: 'POST',
            responseType: ResponseType.json, // or ResponseType.JSON,
            validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
        );
     
      
      print(response);
      return SbmaxSimulasiDetailResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<SbmaxSimulasiDetailResponse> sbmaxInisiasi(SbmaxInisiasi dataSimulasi, String auth, String no) async {
    try {
      Response response;
      if(no == null || no.isEmpty){
        response = await _dio.post(_auth, data: {
          "biaya_anggota": (dataSimulasi.biayaAnggota == null) ? "" : dataSimulasi.biayaAnggota,
          // "jth_tempo":dataSimulasi.jthTempo ==null ? "" : dataSimulasi.jthTempo,
          "jasa": (dataSimulasi.jasa == null) ? "" : dataSimulasi.jasa,
          "nominal": (dataSimulasi.nominal == null) ? "" : dataSimulasi.nominal,
          "nominal_jasa": (dataSimulasi.nominalJasa == null) ? "" : dataSimulasi.nominalJasa,
          "nominal_total":(dataSimulasi.nominalTotal == null) ? "" : dataSimulasi.nominalTotal,          
          "tenor": (dataSimulasi.tenor == null) ? "" : dataSimulasi.tenor,
          "virtual_account": "8850000014400155"
        }, 
        options: 
          Options(
            headers: {
              "Content-Type": "application/json",
              "service_id":"5b8daaeb-ef26-460f-8b20-36d2dd757c61",
              "Authorization": "Bearer $auth"
            },
            method: 'POST',
            responseType: ResponseType.json, // or ResponseType.JSON,
            validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
        );

      }else{
        response = await _dio.post(_auth, data: {
          // "jth_tempo":dataSimulasi.jthTempo ==null ? "" : dataSimulasi.jthTempo,
          "jasa": (dataSimulasi.jasa == null) ? "" : dataSimulasi.jasa,
          "nominal": (dataSimulasi.nominal == null) ? "" : dataSimulasi.nominal,
          "nominal_jasa": (dataSimulasi.nominalJasa == null) ? "" : dataSimulasi.nominalJasa,
          "nominal_total":(dataSimulasi.nominalTotal == null) ? "" : dataSimulasi.nominalTotal,          
          "tenor": (dataSimulasi.tenor == null) ? "" : dataSimulasi.tenor,
          "accountno": no
        }, 
        options: 
          Options(
            headers: {
              "Content-Type": "application/json",
              "service_id":"5b8daaeb-ef26-460f-8b20-36d2dd757c61",
              "Authorization": "Bearer $auth"
            },
            method: 'POST',
            responseType: ResponseType.json, // or ResponseType.JSON,
            validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
        );
      }
        
      
      print(response);
      return SbmaxSimulasiDetailResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<SbmaxSimulasiDetailResponse> sbmaxPencairan(String imei, String noac, String password, String auth) async {
    try {
      print(imei);
        Response response = await _dio.post(_auth, data: {
          "imei": (imei == null) ? "" : imei,
          "noac": noac ==null ? "" : noac,
          "password": (password == null) ? "" : password
        }, 
        options: 
          Options(
            headers: {
              "Content-Type": "application/json",
              "service_id":"bfef3708-d459-4a28-8e2f-a674d571873a",
              "Authorization": "Bearer $auth"
            },
            method: 'POST',
            responseType: ResponseType.json, // or ResponseType.JSON,
            validateStatus: (status) { return status < 500; },// or ResponseType.JSON
          )
        );

      
      print(response);
      return SbmaxSimulasiDetailResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }


  Future<ProfileResponse> getProfile(String auth) async {
    print(auth);
    try {
      Response response = await _dio.post(_auth, data: {
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"656b6d4c-6728-445f-b2f2-098bf5ffdba5",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return ProfileResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<LoginResponse> changePass(String imei, String oldPass, String newPass, String auth) async {
    print(auth);
    try {
      Response response = await _dio.post(_auth, data: {
        "imei": imei,
	      "old_password": oldPass,
	      "new_password": newPass
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"6464cd6f-c130-4878-9a02-c443fdaee550",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return LoginResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<OtpResponse> sentEmail(String email, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        "email_address": email
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"0efbb7bd-1a3d-4c8b-b50d-cc67160d1903",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return OtpResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }


  Future<LoginResponse> verifyEmail(String email, String otpCode, dynamic otpId, String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        "email_address": email,
        "otp_code": otpCode,
	      "otp_id": otpId
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"0efbb7bd-1a3d-4c8b-b50d-cc67160d1903",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return LoginResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<SpesimenResponse> getFotoProfile(String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
        "file": "PROFILE.png",
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"78051678-3418-4a5e-815b-04226a2c075f",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return SpesimenResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }

  Future<CekFiturCoin> cekFiturCoin(String auth) async {
    try {
      Response response = await _dio.post(_auth, data: {
      }, 
      options: 
        Options(
          headers: {
            "Content-Type": "application/json",
            "service_id":"7cb23eca-3399-4d88-b519-4d3ac51c46f1",
            "Authorization": "Bearer $auth"
          },
          method: 'POST',
          responseType: ResponseType.json, // or ResponseType.JSON,
          validateStatus: (status) { return status < 500; },// or ResponseType.JSON
        )
      );
      print(response);
      return CekFiturCoin.fromJson(response.data);
    } on DioError catch(e){
      print(e);
      throw (e.message);
    }
  }
  
}