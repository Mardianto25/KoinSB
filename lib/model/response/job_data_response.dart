class JobDataResponse {
  String message;
  ResponseData response;
  int status;

  JobDataResponse({this.message, this.response, this.status});

  JobDataResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new ResponseData.fromJson(json['response'])
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

class ResponseData {
  Data data;
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
  String jenisPekerjaan;
  String lamaBekerja;
  String namaInstansi;
  String statusPekerjaan;

  Data(
      {this.jenisPekerjaan,
      this.lamaBekerja,
      this.namaInstansi,
      this.statusPekerjaan});

  Data.fromJson(Map<String, dynamic> json) {
    jenisPekerjaan = json['jenis_pekerjaan'];
    lamaBekerja = json['lama_bekerja'];
    namaInstansi = json['nama_instansi'];
    statusPekerjaan = json['status_pekerjaan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jenis_pekerjaan'] = this.jenisPekerjaan;
    data['lama_bekerja'] = this.lamaBekerja;
    data['nama_instansi'] = this.namaInstansi;
    data['status_pekerjaan'] = this.statusPekerjaan;
    return data;
  }
}