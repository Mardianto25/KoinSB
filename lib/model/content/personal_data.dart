class PersonalDataContent {
  String publicId;
  String nomorEktp;
  String namaLengkap;
  String tempatLahir;
  String tanggalLahir;
  String jenisKelamin;
  String agama;
  String namaIbuKandung;
  String statusPerkawinan;
  String pendidikanTerakhir;
  String gelar;
  String kontakDarurat;
  String hubunganKontakDarurat;

  PersonalDataContent(
      {this.publicId,
      this.nomorEktp,
      this.namaLengkap,
      this.tempatLahir,
      this.tanggalLahir,
      this.jenisKelamin,
      this.agama,
      this.namaIbuKandung,
      this.statusPerkawinan,
      this.pendidikanTerakhir,
      this.gelar,
      this.kontakDarurat,
      this.hubunganKontakDarurat
      });

  PersonalDataContent.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    nomorEktp = json['nomor_ektp'];
    namaLengkap = json['nama_lengkap'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    jenisKelamin = json['jenis_kelamin'];
    agama = json['agama'];
    namaIbuKandung = json['nama_ibu_kandung'];
    statusPerkawinan = json['status_perkawinan'];
    pendidikanTerakhir = json['pendidikan_terakhir'];
    gelar = json['gelar'];
    kontakDarurat = json['kontak_darurat'];
    hubunganKontakDarurat = json['hubungan_kontak_darurat'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_id'] = this.publicId;
    data['nomor_ektp'] = this.nomorEktp;
    data['nama_lengkap'] = this.namaLengkap;
    data['tempat_lahir'] = this.tempatLahir;
    data['tanggal_lahir'] = this.tanggalLahir;
    data['jenis_kelamin'] = this.jenisKelamin;
    data['agama'] = this.agama;
    data['nama_ibu_kandung'] = this.namaIbuKandung;
    data['status_perkawinan'] = this.statusPerkawinan;
    data['pendidikan_terakhir'] = this.pendidikanTerakhir;
    data['gelar'] = this.gelar;
    data['kontak_darurat'] = this.kontakDarurat;
    data['hubungan_kontak_darurat'] = this.hubunganKontakDarurat;
        
    return data;
  }
}