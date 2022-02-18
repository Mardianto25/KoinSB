class RegisterDone {
  String message;
  DoneResponse response;
  int status;

  RegisterDone({this.message, this.response, this.status});

  RegisterDone.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new DoneResponse.fromJson(json['response'])
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

class DoneResponse {
  DoneData data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  DoneResponse(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  DoneResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DoneData.fromJson(json['data']) : null;
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

class DoneData {
  String status;

  DoneData({this.status});

  DoneData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}