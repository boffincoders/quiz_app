class PaperLevelListModel {
  int? statusCode;
  int? size;
  List<PaperListData>? data;

  PaperLevelListModel({this.statusCode, this.size, this.data});

  PaperLevelListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    size = json['size'];
    if (json['data'] != null) {
      data = <PaperListData>[];
      json['data'].forEach((v) {
        data!.add(new PaperListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['size'] = this.size;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaperListData {
  String? questionId;
  String? questionName;
  String? questionLevel;

  PaperListData({this.questionId, this.questionName, this.questionLevel});

  PaperListData.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    questionName = json['question_name'];
    questionLevel = json['question_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['question_name'] = this.questionName;
    data['question_level'] = this.questionLevel;
    return data;
  }
}