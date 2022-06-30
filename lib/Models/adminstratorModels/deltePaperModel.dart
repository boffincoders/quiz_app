class DeletePaperModel {
  int? statusCode;
  List<String>? data;

  DeletePaperModel({this.statusCode, this.data});

  DeletePaperModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['data'] = this.data;
    return data;
  }
}