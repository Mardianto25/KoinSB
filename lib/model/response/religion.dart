class General {
  ResponseData response;

  General({this.response});

  General.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new ResponseData.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    return data;
  }
}

class ResponseData {
  List<GeneralData> data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  ResponseData(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  ResponseData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<GeneralData>();
      json['data'].forEach((v) {
        data.add(new GeneralData.fromJson(v));
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

class GeneralData {
  String iD;
  String name;
  String kode;
  String sandi;

  GeneralData({this.iD, this.name, this.kode, this.sandi});

  GeneralData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    kode = json['Kode'];
    sandi = json['Sandi'];    
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['Kode'] = this.kode;
    data['Sandi'] = this.sandi;
    return data;
  }
}