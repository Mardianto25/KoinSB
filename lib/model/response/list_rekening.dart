class ListRekening {
  String message;
  ResponseRekening response;
  int status;

  ListRekening({this.message, this.response, this.status});

  ListRekening.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new ResponseRekening.fromJson(json['response'])
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

class ResponseRekening {
  DataRekening data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  ResponseRekening(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  ResponseRekening.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataRekening.fromJson(json['data']) : null;
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

class DataRekening {
  String noac;
  int nominal;

  DataRekening({this.noac, this.nominal});

  DataRekening.fromJson(Map<String, dynamic> json) {
    noac = json['noac'];
    nominal = json['nominal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noac'] = this.noac;
    data['nominal'] = this.nominal;
    return data;
  }
}
