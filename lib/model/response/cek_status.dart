class CekStatusResponse {
  String message;
  ResponseStatus response;
  int status;

  CekStatusResponse({this.message, this.response, this.status});

  CekStatusResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new ResponseStatus.fromJson(json['response'])
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

class ResponseStatus {
  Data data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  ResponseStatus(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  ResponseStatus.fromJson(Map<String, dynamic> json) {
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
  String ktp;
  String phonenumber;
  int pikoStatus;
  String proses;
  String state;
  String status;

  Data(
      {this.email,
      this.ktp,
      this.phonenumber,
      this.pikoStatus,
      this.proses,
      this.state,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    ktp = json['ktp'];
    phonenumber = json['phonenumber'];
    pikoStatus = json['piko_status'];
    proses = json['proses'];
    state = json['state'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['ktp'] = this.ktp;
    data['phonenumber'] = this.phonenumber;
    data['piko_status'] = this.pikoStatus;
    data['proses'] = this.proses;
    data['state'] = this.state;
    data['status'] = this.status;
    return data;
  }
}