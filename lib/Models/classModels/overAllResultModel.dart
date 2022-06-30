class OverAllResultModel {
  int? statusCode;
  List<OverAllResult>? results;

  OverAllResultModel({this.statusCode, this.results});

  OverAllResultModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['results'] != null) {
      results = <OverAllResult>[];
      json['results'].forEach((v) {
        results!.add(new OverAllResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OverAllResult {
  String? userId;
  String? level;
  String? correctAnswers;
  String? incorrectAnswers;

  OverAllResult(
      {this.userId, this.level, this.correctAnswers, this.incorrectAnswers});

  OverAllResult.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    level = json['level'];
    correctAnswers = json['correct_answers'];
    incorrectAnswers = json['incorrect_answers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['level'] = this.level;
    data['correct_answers'] = this.correctAnswers;
    data['incorrect_answers'] = this.incorrectAnswers;
    return data;
  }
}