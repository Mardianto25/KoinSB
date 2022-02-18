class SbmaxDetail {
  String message;
  ResponseSbmaxDetail response;
  int status;

  SbmaxDetail({this.message, this.response, this.status});

  SbmaxDetail.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new ResponseSbmaxDetail.fromJson(json['response'])
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

class ResponseSbmaxDetail {
  Data data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  ResponseSbmaxDetail(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  ResponseSbmaxDetail.fromJson(Map<String, dynamic> json) {
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
  dynamic jasa;
  dynamic jasaTerbentuk;
  dynamic jumlahSaatJthTempo;
  String noac;
  dynamic penempatanProduk;
  String sourceNumber;
  String status;
  String tenor;
  String tglJthTempo;

  Data(
      {this.jasa,
      this.jasaTerbentuk,
      this.jumlahSaatJthTempo,
      this.noac,
      this.penempatanProduk,
      this.sourceNumber,
      this.status,
      this.tenor,
      this.tglJthTempo});

  Data.fromJson(Map<String, dynamic> json) {
    jasa = json['jasa'];
    jasaTerbentuk = json['jasa_terbentuk'];
    jumlahSaatJthTempo = json['jumlah_saat_jth_tempo'];
    noac = json['noac'];
    penempatanProduk = json['penempatan_produk'];
    sourceNumber = json['source_number'];
    status = json['status'];
    tenor = json['tenor'];
    tglJthTempo = json['tgl_jth_tempo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jasa'] = this.jasa;
    data['jasa_terbentuk'] = this.jasaTerbentuk;
    data['jumlah_saat_jth_tempo'] = this.jumlahSaatJthTempo;
    data['noac'] = this.noac;
    data['penempatan_produk'] = this.penempatanProduk;
    data['source_number'] = this.sourceNumber;
    data['status'] = this.status;
    data['tenor'] = this.tenor;
    data['tgl_jth_tempo'] = this.tglJthTempo;
    return data;
  }
}