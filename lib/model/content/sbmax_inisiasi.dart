class SbmaxInisiasi {
  dynamic biayaAnggota;
  dynamic jasa;
  String jthTempo;
  dynamic nominal;
  dynamic nominalJasa;
  dynamic nominalTotal;
  dynamic tenor;
  String virtualBni;

  SbmaxInisiasi(
      {this.biayaAnggota,
      this.jasa,
      this.jthTempo,
      this.nominal,
      this.nominalJasa,
      this.nominalTotal,
      this.tenor,
      this.virtualBni});

  SbmaxInisiasi.fromJson(Map<String, dynamic> json) {
    biayaAnggota = json['biaya_anggota'];
    jasa = json['jasa'];
    jthTempo = json['jth_tempo'];
    nominal = json['nominal'];
    nominalJasa = json['nominal_jasa'];
    nominalTotal = json['nominal_total'];
    tenor = json['tenor'];
    virtualBni = json['virtual_bni'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['biaya_anggota'] = this.biayaAnggota;
    data['jasa'] = this.jasa;
    data['jth_tempo'] = this.jthTempo;
    data['nominal'] = this.nominal;
    data['nominal_jasa'] = this.nominalJasa;
    data['nominal_total'] = this.nominalTotal;
    data['tenor'] = this.tenor;
    data['virtual_bni'] = this.virtualBni;
    return data;
  }
}