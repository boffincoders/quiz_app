class AddQuestionModel {
  String? message;
  int? statusCode;
  Data? data;

  AddQuestionModel({this.message, this.statusCode, this.data});

  AddQuestionModel.fromJson(Map<String, dynamic> json) {
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
  String? paperId;
  String? question;
  String? level;
  Answers? answers;
  String? correctAnswer;

  Data({this.paperId, this.question, this.level, this.answers, this.correctAnswer});

  Data.fromJson(Map<String, dynamic> json) {
    paperId = json['Paper Id'];
    question = json['Question'];
    level = json['level'];
    answers = json['answers'] != null ? new Answers.fromJson(json['answers']) : null;
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Paper Id'] = this.paperId;
    data['Question'] = this.question;
    data['level'] = this.level;
    if (this.answers != null) {
      data['answers'] = this.answers!.toJson();
    }
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}

class Answers {
  String? answer1;
  String? answer2;
  String? answer3;
  String? answer4;

  Answers({this.answer1, this.answer2, this.answer3, this.answer4});

  Answers.fromJson(Map<String, dynamic> json) {
    answer1 = json['answer1'];
    answer2 = json['answer2'];
    answer3 = json['answer3'];
    answer4 = json['answer4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer1'] = this.answer1;
    data['answer2'] = this.answer2;
    data['answer3'] = this.answer3;
    data['answer4'] = this.answer4;
    return data;
  }
}
