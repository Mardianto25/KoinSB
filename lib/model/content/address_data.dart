class AddressDataContent {
  String publicId;
  String statusRumah;
  String alamatLengkap;
  String provinsi;
  String kotaKabupaten;
  String kecamatan;
  String kelurahan;
  String kodePos;
  String isKtpAddress;

  AddressDataContent(
      {this.publicId,
      this.statusRumah,
      this.alamatLengkap,
      this.provinsi,
      this.kotaKabupaten,
      this.kecamatan,
      this.kelurahan,
      this.kodePos,
      this.isKtpAddress});

  AddressDataContent.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    statusRumah = json['status_rumah'];    
    alamatLengkap = json['alamat_lengkap'];
    provinsi = json['provinsi'];
    kotaKabupaten = json['kota_kabupaten'];
    kecamatan = json['kecamatan'];
    kelurahan = json['kelurahan'];
    kodePos = json['kode_pos'];
    isKtpAddress = json['is_ktp_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_id'] = this.publicId;
    data['status_rumah'] = this.statusRumah;    
    data['alamat_lengkap'] = this.alamatLengkap;
    data['provinsi'] = this.provinsi;
    data['kota_kabupaten'] = this.kotaKabupaten;
    data['kecamatan'] = this.kecamatan;
    data['kelurahan'] = this.kelurahan;
    data['kode_pos'] = this.kodePos;
    data['is_ktp_address'] = this.isKtpAddress;
    return data;
  }
}