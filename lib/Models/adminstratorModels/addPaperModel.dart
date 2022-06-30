class AddPaperModel {
  String? message;
  int? statusCode;
  Data? data;

  AddPaperModel({this.message, this.statusCode, this.data});

  AddPaperModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? classId;
  String? subjectId;
  String? paperName;
  String? passMarks;
  String? totalLevel;

  Data({this.classId, this.subjectId, this.paperName, this.passMarks, this.totalLevel});

  Data.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    subjectId = json['subject_id'];
    paperName = json['paper_name'];
    passMarks = json['pass_marks'];
    totalLevel = json['total_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_id'] = this.classId;
    data['subject_id'] = this.subjectId;
    data['paper_name'] = this.paperName;
    data['pass_marks'] = this.passMarks;
    data['total_level'] = this.totalLevel;
    return data;
  }
}
