class RegisterResponse {
  String message;
  RegisterResponseData response;
  int status;

  RegisterResponse({this.message, this.response, this.status});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new RegisterResponseData.fromJson(json['response'])
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

class RegisterResponseData {
  Data data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  RegisterResponseData(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  RegisterResponseData.fromJson(Map<String, dynamic> json) {
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
  String imei;
  String noKtp;
  int pikoStatus;

  Data({this.imei, this.noKtp, this.pikoStatus});

  Data.fromJson(Map<String, dynamic> json) {
    imei = json['imei'];
    noKtp = json['no_ktp'];
    pikoStatus = json['piko_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imei'] = this.imei;
    data['no_ktp'] = this.noKtp;
    data['piko_status'] = this.pikoStatus;
    return data;
  }
}