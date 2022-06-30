class SubjectQuestionAnswerModel {
  int? statusCode;
  String? passMarks;
  int? totalLevels;
  List<Data>? data;

  SubjectQuestionAnswerModel({this.statusCode, this.passMarks, this.data});

  SubjectQuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    passMarks = json['pass_marks'];
    totalLevels = json['total_levels'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['pass_marks'] = this.passMarks;
    data['total_levels'] = this.totalLevels;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? questionId;
  String? question;
  String? level;
  List<Answer>? answer;

  Data({this.questionId, this.question, this.level, this.answer});

  Data.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    question = json['question'];
    level = json['level'];
    if (json['answer'] != null) {
      answer = <Answer>[];
      json['answer'].forEach((v) {
        answer!.add(new Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['question'] = this.question;
    data['level'] = this.level;
    if (this.answer != null) {
      data['answer'] = this.answer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answer {
  String? answerId;
  String? answerName;
  bool? isSelected;

  Answer({this.answerId, this.answerName, this.isSelected});

  Answer.fromJson(Map<String, dynamic> json) {
    answerId = json['answer_id'];
    answerName = json['answer_name'];
    isSelected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_id'] = this.answerId;
    data['answer_name'] = this.answerName;
    data['is_selected'] = this.isSelected;
    return data;
  }
}