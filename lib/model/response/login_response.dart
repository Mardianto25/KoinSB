class LoginResponse {
  String message;
  LoginData response;
  int status;

  LoginResponse({this.message, this.response, this.status});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new LoginData.fromJson(json['response'])
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

class LoginData {
  String data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  LoginData(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  LoginData.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    respCode = json['resp_code'];
    respDesc = json['resp_desc'];
    respMessage = json['resp_message'];
    respStatus = json['resp_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['resp_code'] = this.respCode;
    data['resp_desc'] = this.respDesc;
    data['resp_message'] = this.respMessage;
    data['resp_status'] = this.respStatus;
    return data;
  }
}