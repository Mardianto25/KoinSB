class JobDataContent {
  String publicId;
  String jenisPekerjaan;
  String namaInstansi;
  String statusPekerjaan;
  String lamaBekerja;

  JobDataContent(
      {this.publicId,
      this.jenisPekerjaan,
      this.namaInstansi,
      this.statusPekerjaan,
      this.lamaBekerja});

  JobDataContent.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    jenisPekerjaan = json['jenis_pekerjaan'];
    namaInstansi = json['nama_instansi'];
    statusPekerjaan = json['status_pekerjaan'];
    lamaBekerja = json['lama_bekerja'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_id'] = this.publicId;
    data['jenis_pekerjaan'] = this.jenisPekerjaan;
    data['nama_instansi'] = this.namaInstansi;
    data['status_pekerjaan'] = this.statusPekerjaan;
    data['lama_bekerja'] = this.lamaBekerja;
    return data;
  }
}