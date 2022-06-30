class GetLevelModel {
  int? statusCode;
  List<int>? levels;

  GetLevelModel({this.statusCode, this.levels});

  GetLevelModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    levels = json['levels'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['levels'] = this.levels;
    return data;
  }
}
