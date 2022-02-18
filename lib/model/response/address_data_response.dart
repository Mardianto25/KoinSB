class AddressDataResponse {
  String message;
  ResponseData response;
  int status;

  AddressDataResponse({this.message, this.response, this.status});

  AddressDataResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new ResponseData.fromJson(json['response'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class ResponseData {
  Data data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  ResponseData(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  ResponseData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    respCode = json['resp_code'];
    respDesc = json['resp_desc'];
    respMessage = json['resp_message'];
    respStatus = json['resp_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['resp_code'] = this.respCode;
    data['resp_desc'] = this.respDesc;
    data['resp_message'] = this.respMessage;
    data['resp_status'] = this.respStatus;
    return data;
  }
}

class Data {
  String statusRumah;
  String alamatLengkap;
  String isKtpAddress;
  String kecamatan;
  String kelurahan;
  String kodePos;
  String kotaKabupaten;
  String provinsi;

  Data(
      {
      this.statusRumah,
      this.alamatLengkap,
      this.isKtpAddress,
      this.kecamatan,
      this.kelurahan,
      this.kodePos,
      this.kotaKabupaten,
      this.provinsi});

  Data.fromJson(Map<String, dynamic> json) {
    statusRumah = json['status_rumah'];    
    alamatLengkap = json['alamat_lengkap'];
    isKtpAddress = json['is_ktp_address'];
    kecamatan = json['kecamatan'];
    kelurahan = json['kelurahan'];
    kodePos = json['kode_pos'];
    kotaKabupaten = json['kota_kabupaten'];
    provinsi = json['provinsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_rumah'] = this.statusRumah;    
    data['alamat_lengkap'] = this.alamatLengkap;
    data['is_ktp_address'] = this.isKtpAddress;
    data['kecamatan'] = this.kecamatan;
    data['kelurahan'] = this.kelurahan;
    data['kode_pos'] = this.kodePos;
    data['kota_kabupaten'] = this.kotaKabupaten;
    data['provinsi'] = this.provinsi;
    return data;
  }
}