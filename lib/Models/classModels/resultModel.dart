class ResultModel {
  int? statusCode;
  Results? results;

  ResultModel({this.statusCode, this.results});

  ResultModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class Results {
  int? correct;
  int? incorrect;
  int? points;
  String? level;
  String? passMarks;
  List<IncorrectData>? incorrectData;
  List<UnselectedData>? unselectedData;

  Results(
      {this.correct,
        this.incorrect,
        this.points,
        this.level,
        this.passMarks,
        this.incorrectData,
        this.unselectedData});

  Results.fromJson(Map<String, dynamic> json) {
    correct = json['correct'];
    incorrect = json['incorrect'];
    points = json['points'];
    level = json['level'];
    passMarks = json['pass_marks'];
    if (json['incorrect_data'] != null) {
      incorrectData = <IncorrectData>[];
      json['incorrect_data'].forEach((v) {
        incorrectData!.add(new IncorrectData.fromJson(v));
      });
    }
    if (json['unselected_data'] != null) {
      unselectedData = <UnselectedData>[];
      json['unselected_data'].forEach((v) {
        unselectedData!.add(new UnselectedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['points'] = this.points;
    data['level'] = this.level;
    data['pass_marks'] = this.passMarks;
    if (this.incorrectData != null) {
      data['incorrect_data'] =
          this.incorrectData!.map((v) => v.toJson()).toList();
    }
    if (this.unselectedData != null) {
      data['unselected_data'] =
          this.unselectedData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IncorrectData {
  String? questionId;
  String? questionText;
  String? givenAnswerId;
  String? givenAnswerText;
  String? correctAnswerId;
  String? correctAnswerText;
  String? answerDescription;

  IncorrectData(
      {this.questionId,
        this.questionText,
        this.givenAnswerId,
        this.givenAnswerText,
        this.correctAnswerId,
        this.correctAnswerText,
        this.answerDescription});

  IncorrectData.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    questionText = json['question_text'];
    givenAnswerId = json['given_answer_id'];
    givenAnswerText = json['given_answer_text'];
    correctAnswerId = json['correct_answer_id'];
    correctAnswerText = json['correct_answer_text'];
    answerDescription = json['answer_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['question_text'] = this.questionText;
    data['given_answer_id'] = this.givenAnswerId;
    data['given_answer_text'] = this.givenAnswerText;
    data['correct_answer_id'] = this.correctAnswerId;
    data['correct_answer_text'] = this.correctAnswerText;
    data['answer_description'] = this.answerDescription;
    return data;
  }
}

class UnselectedData {
  String? questionId;
  String? questionName;
  List<Answers>? answers;

  UnselectedData({this.questionId, this.questionName, this.answers});

  UnselectedData.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    questionName = json['question_name'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['question_name'] = this.questionName;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String? id;
  String? answerName;
  String? questionId;
  String? correctAnswer;

  Answers({this.id, this.answerName, this.questionId, this.correctAnswer});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answerName = json['answer_name'];
    questionId = json['question_id'];
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['answer_name'] = this.answerName;
    data['question_id'] = this.questionId;
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}