class SbmaxPinResponse {
  String message;
  ResponseSbmaxPin response;
  int status;

  SbmaxPinResponse({this.message, this.response, this.status});

  SbmaxPinResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new ResponseSbmaxPin.fromJson(json['response'])
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

class ResponseSbmaxPin {
  Data data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  ResponseSbmaxPin(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  ResponseSbmaxPin.fromJson(Map<String, dynamic> json) {
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
  int verify;

  Data({this.verify});

  Data.fromJson(Map<String, dynamic> json) {
    verify = json['verify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verify'] = this.verify;
    return data;
  }
}