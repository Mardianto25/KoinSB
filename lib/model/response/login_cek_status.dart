class LoginCekStatusResponse {
  String message;
  ResponseCekLogin response;
  int status;

  LoginCekStatusResponse({this.message, this.response, this.status});

  LoginCekStatusResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new ResponseCekLogin.fromJson(json['response'])
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

class ResponseCekLogin {
  Data data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  ResponseCekLogin(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  ResponseCekLogin.fromJson(Map<String, dynamic> json) {
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
  String state;
  String status;

  Data({this.state, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['status'] = this.status;
    return data;
  }
}