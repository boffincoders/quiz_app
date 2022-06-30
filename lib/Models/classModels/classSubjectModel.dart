class ClassSubjectModel {
  int? statusCode;
  List<SubjectData>? data;

  ClassSubjectModel({this.statusCode, this.data});

  ClassSubjectModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <SubjectData>[];
      json['data'].forEach((v) {
        data!.add(new SubjectData.fromJson(v));
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

class SubjectData {
  String? id;
  String? classId;
  String? subjectName;
  String? status;

  SubjectData({this.id, this.classId, this.subjectName, this.status});

  SubjectData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['class_id'];
    subjectName = json['subject_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['class_id'] = this.classId;
    data['subject_name'] = this.subjectName;
    data['status'] = this.status;
    return data;
  }
}