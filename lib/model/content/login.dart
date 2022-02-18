class LoginModel {
  // String publicId;
  String imei;
  String phonenumber;
  String password;

  LoginModel({this.imei, this.phonenumber, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    // publicId = json['public_id'];
    imei = json['imei'];
    phonenumber = json['phonenumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['public_id'] = this.publicId;
    data['imei'] = this.imei;
    data['phonenumber'] = this.phonenumber;
    data['password'] = this.password;
    return data;
  }
}