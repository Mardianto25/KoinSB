class PersonalDataResponse {
  String message;
  ResponseData response;
  int status;

  PersonalDataResponse({this.message, this.response, this.status});

  PersonalDataResponse.fromJson(Map<String, dynamic> json) {
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
  String agama;
  String gelar;
  String jenisKelamin;
  String namaIbuKandung;
  String namaLengkap;
  String nomorEktp;
  String pendidikanTerakhir;
  String statusPerkawinan;
  String tanggalLahir;
  String tempatLahir;
  String kontakDarurat;
  String hubunganKontakDarurat;

  Data(
      {this.agama,
      this.gelar,
      this.jenisKelamin,
      this.namaIbuKandung,
      this.namaLengkap,
      this.nomorEktp,
      this.pendidikanTerakhir,
      this.statusPerkawinan,
      this.tanggalLahir,
      this.tempatLahir,
      this.kontakDarurat,
      this.hubunganKontakDarurat
      
      });

  Data.fromJson(Map<String, dynamic> json) {
    agama = json['agama'];
    gelar = json['gelar'];
    jenisKelamin = json['jenis_kelamin'];
    namaIbuKandung = json['nama_ibu_kandung'];
    namaLengkap = json['nama_lengkap'];
    nomorEktp = json['nomor_ektp'];
    pendidikanTerakhir = json['pendidikan_terakhir'];
    statusPerkawinan = json['status_perkawinan'];
    tanggalLahir = json['tanggal_lahir'];
    tempatLahir = json['tempat_lahir'];
    kontakDarurat = json['kontak_darurat'];
    hubunganKontakDarurat = json['hubungan_kontak_darurat'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agama'] = this.agama;
    data['gelar'] = this.gelar;
    data['jenis_kelamin'] = this.jenisKelamin;
    data['nama_ibu_kandung'] = this.namaIbuKandung;
    data['nama_lengkap'] = this.namaLengkap;
    data['nomor_ektp'] = this.nomorEktp;
    data['pendidikan_terakhir'] = this.pendidikanTerakhir;
    data['status_perkawinan'] = this.statusPerkawinan;
    data['tanggal_lahir'] = this.tanggalLahir;
    data['tempat_lahir'] = this.tempatLahir;
    data['kontak_darurat'] = this.kontakDarurat;
    data['hubungan_kontak_darurat'] = this.hubunganKontakDarurat;    
    
    return data;
  }
}