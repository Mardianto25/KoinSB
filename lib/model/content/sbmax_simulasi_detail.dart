class SbmaxSimulasiDetail {
  dynamic jasa;
  dynamic nominal;
  dynamic nominalJasa;
  dynamic nominalTotal;
  dynamic tenor;

  SbmaxSimulasiDetail(
      {this.jasa,
      this.nominal,
      this.nominalJasa,
      this.nominalTotal,
      this.tenor});

  SbmaxSimulasiDetail.fromJson(Map<String, dynamic> json) {
    jasa = json['jasa'];
    nominal = json['nominal'];
    nominalJasa = json['nominal_jasa'];
    nominalTotal = json['nominal_total'];
    tenor = json['tenor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jasa'] = this.jasa;
    data['nominal'] = this.nominal;
    data['nominal_jasa'] = this.nominalJasa;
    data['nominal_total'] = this.nominalTotal;
    data['tenor'] = this.tenor;
    return data;
  }
}