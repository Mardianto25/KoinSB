class SbmaxSimulasiResponse {
  String message;
  ResponseSimulasi response;
  int status;

  SbmaxSimulasiResponse({this.message, this.response, this.status});

  SbmaxSimulasiResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new ResponseSimulasi.fromJson(json['response'])
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

class ResponseSimulasi {
  List<DataSimulasi> data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  ResponseSimulasi(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  ResponseSimulasi.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DataSimulasi>();
      json['data'].forEach((v) {
        data.add(new DataSimulasi.fromJson(v));
      });
    }
    respCode = json['resp_code'];
    respDesc = json['resp_desc'];
    respMessage = json['resp_message'];
    respStatus = json['resp_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['resp_code'] = this.respCode;
    data['resp_desc'] = this.respDesc;
    data['resp_message'] = this.respMessage;
    data['resp_status'] = this.respStatus;
    return data;
  }
}

class DataSimulasi {
  double jasa;
  int nominal;
  double nominalJasa;
  double nominalTotal;
  int tenor;

  DataSimulasi(
      {this.jasa,
      this.nominal,
      this.nominalJasa,
      this.nominalTotal,
      this.tenor});

  DataSimulasi.fromJson(Map<String, dynamic> json) {
    jasa = json['jasa'];
    nominal = json['nominal'];
    nominalJasa = json['nominal_jasa'];
    nominalTotal = json['nominal_total'];
    tenor = json['tenor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jasa'] = this.jasa;
    data['nominal'] = this.nominal;
    data['nominal_jasa'] = this.nominalJasa;
    data['nominal_total'] = this.nominalTotal;
    data['tenor'] = this.tenor;
    return data;
  }
}