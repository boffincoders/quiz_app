import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/ApiService/ApiUrls.dart';
import 'package:quiz_app/Models/classModels/classSubjectModel.dart';
import 'package:quiz_app/Models/classModels/classModel.dart';
import 'package:quiz_app/Models/classModels/overAllResultModel.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

import '../../Models/classModels/resultModel.dart';
import '../../Models/classModels/subjectPaperModel.dart';
import '../../Models/classModels/subjectQuestionAnswerModel.dart';

class ClassServices {
  ClassServices._();

  static Future<ClassModel?> getClasses() async {
    ClassModel classModel = ClassModel();
    final data = {"method": "type_class", "operation": "get_classes"};
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, headers: {"Authorization": "Bearer ${prefs!.getString("token")}"}, body: data);
      if (CommonWidgets.checkStatus(response) == 200) {
        var classData = jsonDecode(response.body);
        classModel = ClassModel.fromJson(classData);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return classModel;
  }

  static Future<ClassSubjectModel?> getAllSubjects(String id) async {
    ClassSubjectModel subjectModel = ClassSubjectModel();
    final data = {"method": "type_subject", "operation": "get_subjects", "class_id": id};
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, headers: {"Authorization": "Bearer ${prefs!.getString("token")}"}, body: data);
      if (CommonWidgets.checkStatus(response)== 200) {
        var data = jsonDecode(response.body);
        subjectModel =  ClassSubjectModel.fromJson(data);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return subjectModel;
  }

  static Future<SubjectPaperModel?> getSubjectPaper(String subjectId) async {
    SubjectPaperModel subjectPaperModel = SubjectPaperModel();
    final data = {"method": "papers", "operation": "get_papers", "subject_id": subjectId};
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, headers: {"Authorization": "Bearer ${prefs!.getString("token")}"}, body: data);
      if (CommonWidgets.checkStatus(response)== 200) {
        var data = jsonDecode(response.body);
        subjectPaperModel =  SubjectPaperModel.fromJson(data);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return subjectPaperModel;
  }

  static Future<SubjectQuestionAnswerModel?> getSubjectPaperQuestionAnswer(String paperId) async {
    SubjectQuestionAnswerModel subjectQuestionAnswerModel = SubjectQuestionAnswerModel();
    final data = {"method": "questions", "operation": "get_questions", "paper_id": paperId};
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, headers: {"Authorization": "Bearer ${prefs!.getString("token")}"}, body: data);
      if (CommonWidgets.checkStatus(response) == 200) {
        var data = jsonDecode(response.body);
        subjectQuestionAnswerModel =  SubjectQuestionAnswerModel.fromJson(data);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return subjectQuestionAnswerModel;
  }

  static Future<ResultModel?> getSubjectPaperQuestionAnswerResult(
      {String? classId, String? paperId, String? subjectId, List<Map<String, dynamic>>? result, String? level, int? passingMarks}) async {
    ResultModel resultModel = ResultModel();
    var url = Uri.parse(ApiUrl.Url);

    var requestData = http.MultipartRequest("POST", url);
    requestData.headers.addAll({"Authorization": "Bearer ${prefs!.getString("token")}"});
    requestData.fields["method"] = 'answer_results';
    requestData.fields["paper_id"] = paperId!;
    requestData.fields["class_id"] = classId!;
    requestData.fields["subject_id"] = subjectId!;
    requestData.fields["level"] = level!;
    requestData.fields["pass_marks"] = passingMarks!.toString();

    if (result!.length > 0) {
      for (int i = 0; i < result.length; i++) {
        requestData.fields["results[" + i.toString() + "][question_id]"] = result[i]['question_id'];
        requestData.fields["results[" + i.toString() + "][answer_id]"] = result[i]['answer_id'];
      }
    }

    try {
      var response = await requestData.send();
      var responed = await http.Response.fromStream(response);

      if (CommonWidgets.checkStatus(responed) == 200) {
        final resultData = jsonDecode(responed.body);
        resultModel =  ResultModel.fromJson(resultData);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return resultModel;
  }

  static Future<OverAllResultModel?> getOverAllResult(String paperId) async {
    OverAllResultModel overAllResultModel = OverAllResultModel();
    final data = {"method": "overall_results", "paper_id": paperId};
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, headers: {"Authorization": "Bearer ${prefs!.getString("token")}"}, body: data);
      if (CommonWidgets.checkStatus(response) == 200) {
        var data = jsonDecode(response.body);
        overAllResultModel =  OverAllResultModel.fromJson(data);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return overAllResultModel;
  }
}
