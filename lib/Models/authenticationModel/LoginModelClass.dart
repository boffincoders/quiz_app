class LoginModel {
  String? message;
  int? statusCode;
  LoginData? data;

  LoginModel({this.message, this.statusCode, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginData {
  String? jwt;
  String? email;
  String? name;
  String? role;
  int? expireAt;

  LoginData({this.jwt, this.email, this.name, this.role, this.expireAt});

  LoginData.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    email = json['email'];
    name = json['name'];
    role = json['role'];
    expireAt = json['expireAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    data['email'] = this.email;
    data['name'] = this.name;
    data['role'] = this.role;
    data['expireAt'] = this.expireAt;
    return data;
  }
}