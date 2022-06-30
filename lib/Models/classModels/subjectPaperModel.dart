class SubjectPaperModel {
  int? statusCode;
  List<SubjectPaperData>? data;

  SubjectPaperModel({this.statusCode, this.data});

  SubjectPaperModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <SubjectPaperData>[];
      json['data'].forEach((v) {
        data!.add(new SubjectPaperData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectPaperData {
  String? id;
  String? subjectId;
  String? classId;
  String? paperName;
  String? passMarks;
  String? level;
  int? questions;
  int? totalLevels;

  SubjectPaperData(
      {this.id,
        this.subjectId,
        this.classId,
        this.paperName,
        this.passMarks,
        this.level,
        this.questions,
        this.totalLevels});

  SubjectPaperData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectId = json['subject_id'];
    classId = json['class_id'];
    paperName = json['paper_name'];
    passMarks = json['pass_marks'];
    level = json['level'];
    questions = json['questions'];
    totalLevels = json['total_levels'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject_id'] = this.subjectId;
    data['class_id'] = this.classId;
    data['paper_name'] = this.paperName;
    data['pass_marks'] = this.passMarks;
    data['level'] = this.level;
    data['questions'] = this.questions;
    data['total_levels'] = this.totalLevels;
    return data;
  }
}