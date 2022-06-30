import 'dart:convert';

import 'package:quiz_app/ApiService/ApiUrls.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/Models/adminstratorModels/deltePaperModel.dart';
import 'package:quiz_app/Models/adminstratorModels/getLevelModel.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

import '../../Models/adminstratorModels/addPaperModel.dart';
import '../../Models/adminstratorModels/addQuestionModel.dart';
import '../../Models/adminstratorModels/deleteQuestionModel.dart';
import '../../Models/adminstratorModels/questionPaperLevelListModel.dart';

class AdminstratorServices {
  AdminstratorServices._();

  static Future<AddPaperModel?> addPaper({String? classId, String? subjectId, String? paperName, int? passingMarks, String? level}) async {
    AddPaperModel addPaperModel = AddPaperModel();
    final data = {"method": "add_paper", "class_id": classId, "subject_id": subjectId, "paper_name": paperName, "pass_marks": passingMarks.toString(), "total_level": level};
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, headers: {"Authorization": "Bearer ${prefs!.getString("token")}"}, body: data);
      if (CommonWidgets.checkStatus(response) == 200) {
        var addPaperData = jsonDecode(response.body);
        addPaperModel = AddPaperModel.fromJson(addPaperData);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return addPaperModel;
  }

  static Future<DeletePaperModel?> deletePaper({
    int? paperId,
  }) async {
    DeletePaperModel deletePaperModel = DeletePaperModel();
    final data = {"method": "delete_paper", "paper_id": paperId.toString()};
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, headers: {"Authorization": "Bearer ${prefs!.getString("token")}"}, body: data);
      if (CommonWidgets.checkStatus(response) == 200) {
        var addPaperData = jsonDecode(response.body);
        deletePaperModel = DeletePaperModel.fromJson(addPaperData);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return deletePaperModel;
  }

  static Future<AddQuestionModel?> addQuestions({
    String? paperId,
    String? question,
    String? answer1,
    String? answer2,
    String? answer3,
    String? answer4,
    String? correctAnswer,
    String? level,
  }) async {
    AddQuestionModel addQuestionModel = AddQuestionModel();
    var data = {
      "method": "add_question",
      "paper_id": paperId!,
      "question_name": question!,
      "answer1": answer1!,
      "answer2": answer2!,
      "answer3": answer3!,
      "answer4": answer4!,
      "correct_answer": correctAnswer!,
      "level": level!
    };
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, headers: {"Authorization": "Bearer ${prefs!.getString("token")}"}, body: data);
      if (CommonWidgets.checkStatus(response) == 200) {
        var addQuestionData = jsonDecode(response.body);
        addQuestionModel = AddQuestionModel.fromJson(addQuestionData);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return addQuestionModel;
  }

  static Future<DeleteQuestionModel?> deleteQuestions({String? questionId}) async {
    DeleteQuestionModel deleteQuestionModel = DeleteQuestionModel();
    var data = {"method": "delete_question", "question_id": questionId};
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, headers: {"Authorization": "Bearer ${prefs!.getString("token")}"}, body: data);
      if (CommonWidgets.checkStatus(response) == 200) {
        var deleteQuestionData = jsonDecode(response.body);
        deleteQuestionModel = DeleteQuestionModel.fromJson(deleteQuestionData);
        return deleteQuestionModel;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<PaperLevelListModel?> getPaperLevelList({String? paperId}) async {
    PaperLevelListModel questionPaperLevelListModel = PaperLevelListModel();
    var data = {"method": "question_levels", "paper_id": paperId};
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, headers: {"Authorization": "Bearer ${prefs!.getString("token")}"}, body: data);
      if (CommonWidgets.checkStatus(response) == 200) {
        var paperLevelListData = jsonDecode(response.body);
        questionPaperLevelListModel = PaperLevelListModel.fromJson(paperLevelListData);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return questionPaperLevelListModel;
  }

  static Future<GetLevelModel?> getLevels(int paperId) async {
    GetLevelModel getLevelModel = GetLevelModel();
    var data = {'method': "get_level", "paper_id": paperId.toString()};
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, headers: {"Authorization": "Bearer ${prefs!.getString("token")}"}, body: data);
      if (CommonWidgets.checkStatus(response) == 200) {
        var levelList = jsonDecode(response.body);
        getLevelModel = GetLevelModel.fromJson(levelList);
        return getLevelModel;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
