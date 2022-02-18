class ListSimpanan {
  String message;
  ResponseListSimpanan response;
  int status;

  ListSimpanan({this.message, this.response, this.status});

  ListSimpanan.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new ResponseListSimpanan.fromJson(json['response'])
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

class ResponseListSimpanan {
  List<DataSimpanan> data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  ResponseListSimpanan(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  ResponseListSimpanan.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DataSimpanan>();
      json['data'].forEach((v) {
        data.add(new DataSimpanan.fromJson(v));
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

class DataSimpanan {
  String noac;
  int nominal;
  String productName;
  String status;
  String tglJthTempo;

  DataSimpanan(
      {this.noac,
      this.nominal,
      this.productName,
      this.status,
      this.tglJthTempo});

  DataSimpanan.fromJson(Map<String, dynamic> json) {
    noac = json['noac'];
    nominal = json['nominal'];
    productName = json['product_name'];
    status = json['status'];
    tglJthTempo = json['tgl_jth_tempo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noac'] = this.noac;
    data['nominal'] = this.nominal;
    data['product_name'] = this.productName;
    data['status'] = this.status;
    data['tgl_jth_tempo'] = this.tglJthTempo;
    return data;
  }
}