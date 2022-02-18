class ShowAll {
  String message;
  ShowResponse response;
  int status;

  ShowAll({this.message, this.response, this.status});

  ShowAll.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'] != null
        ? new ShowResponse.fromJson(json['response'])
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

class ShowResponse {
  ShowData data;
  String respCode;
  String respDesc;
  String respMessage;
  String respStatus;

  ShowResponse(
      {this.data,
      this.respCode,
      this.respDesc,
      this.respMessage,
      this.respStatus});

  ShowResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ShowData.fromJson(json['data']) : null;
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

class ShowData {
  Address address;
  DataPersonal dataPersonal;
  Jobs jobs;

  ShowData({this.address, this.dataPersonal, this.jobs});

  ShowData.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    dataPersonal = json['data_personal'] != null
        ? new DataPersonal.fromJson(json['data_personal'])
        : null;
    jobs = json['jobs'] != null ? new Jobs.fromJson(json['jobs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.dataPersonal != null) {
      data['data_personal'] = this.dataPersonal.toJson();
    }
    if (this.jobs != null) {
      data['jobs'] = this.jobs.toJson();
    }
    return data;
  }
}

class Address {
  String alamatLengkap;
  String statusRumah;
  String isKtpAddress;
  String kecamatan;
  String kelurahan;
  String kodePos;
  String kotaKabupaten;
  String provinsi;

  Address(
      {this.alamatLengkap,
      this.statusRumah,      
      this.isKtpAddress,
      this.kecamatan,
      this.kelurahan,
      this.kodePos,
      this.kotaKabupaten,
      this.provinsi});

  Address.fromJson(Map<String, dynamic> json) {
    alamatLengkap = json['alamat_lengkap'];
    statusRumah = json['status_rumah'];    
    isKtpAddress = json['is_ktp_address'];
    kecamatan = json['kecamatan'];
    kelurahan = json['kelurahan'];
    kodePos = json['kode_pos'];
    kotaKabupaten = json['kota_kabupaten'];
    provinsi = json['provinsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alamat_lengkap'] = this.alamatLengkap;
    data['status_rumah'] = this.statusRumah;    
    data['is_ktp_address'] = this.isKtpAddress;
    data['kecamatan'] = this.kecamatan;
    data['kelurahan'] = this.kelurahan;
    data['kode_pos'] = this.kodePos;
    data['kota_kabupaten'] = this.kotaKabupaten;
    data['provinsi'] = this.provinsi;
    return data;
  }
}

class DataPersonal {
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

  DataPersonal(
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

  DataPersonal.fromJson(Map<String, dynamic> json) {
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

class Jobs {
  String jenisPekerjaan;
  String lamaBekerja;
  String namaInstansi;
  String statusPekerjaan;

  Jobs(
      {this.jenisPekerjaan,
      this.lamaBekerja,
      this.namaInstansi,
      this.statusPekerjaan});

  Jobs.fromJson(Map<String, dynamic> json) {
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
