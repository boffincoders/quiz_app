class EditLevelModel {
  int? statusCode;
  String? status;
  Data? data;

  EditLevelModel({this.statusCode, this.status, this.data});

  EditLevelModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? level;
  String? paperId;

  Data({this.level, this.paperId});

  Data.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    paperId = json['paper_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['paper_id'] = this.paperId;
    return data;
  }
}