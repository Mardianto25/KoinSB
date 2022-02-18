class ProfileResponse {
  String message;
  ResponseProfile response;
  int status;

  ProfileResponse({this.message, this.response, this.status});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new ResponseProfile.fromJson(json['response'])
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

class ResponseProfile {
  Data data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  ResponseProfile(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  ResponseProfile.fromJson(Map<String, dynamic> json) {
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
  String email;
  int isAnggota;
  String ktp;
  String name;
  String phonenumber;
  String refcode;

  Data(
      {this.email,
      this.isAnggota,
      this.ktp,
      this.name,
      this.phonenumber,
      this.refcode});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    isAnggota = json['is_anggota'];
    ktp = json['ktp'];
    name = json['name'];
    phonenumber = json['phonenumber'];
    refcode = json['refcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['is_anggota'] = this.isAnggota;
    data['ktp'] = this.ktp;
    data['name'] = this.name;
    data['phonenumber'] = this.phonenumber;
    data['refcode'] = this.refcode;
    return data;
  }
}