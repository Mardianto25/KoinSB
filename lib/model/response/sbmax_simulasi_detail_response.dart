class SbmaxSimulasiDetailResponse {
  String message;
  ResponseDetailSimulasi response;
  int status;

  SbmaxSimulasiDetailResponse({this.message, this.response, this.status});

  SbmaxSimulasiDetailResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new ResponseDetailSimulasi.fromJson(json['response'])
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

class ResponseDetailSimulasi {
  Data data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  ResponseDetailSimulasi(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  ResponseDetailSimulasi.fromJson(Map<String, dynamic> json) {
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
  String accountno;
  dynamic jasa;
  String jthTempo;
  dynamic nominal;
  dynamic nominalJasa;
  dynamic nominalTotal;
  dynamic tenor;

  Data(
      {this.accountno,
      this.jasa,
      this.jthTempo,
      this.nominal,
      this.nominalJasa,
      this.nominalTotal,
      this.tenor});

  Data.fromJson(Map<String, dynamic> json) {
    accountno = json['accountno'];
    jasa = json['jasa'];
    jthTempo = json['jth_tempo'];
    nominal = json['nominal'];
    nominalJasa = json['nominal_jasa'];
    nominalTotal = json['nominal_total'];
    tenor = json['tenor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountno'] = this.accountno;
    data['jasa'] = this.jasa;
    data['jth_tempo'] = this.jthTempo;
    data['nominal'] = this.nominal;
    data['nominal_jasa'] = this.nominalJasa;
    data['nominal_total'] = this.nominalTotal;
    data['tenor'] = this.tenor;
    return data;
  }
}