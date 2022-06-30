import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/ApiService/ApiUrls.dart';
import 'package:quiz_app/Models/TridbModels/getCatogryModel.dart';
import 'package:quiz_app/Models/TridbModels/getQuestionPaperModel.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

class ClassServices {
  ClassServices._();

  //=================> TrivadB Url Services <==================//

  static Future<GetCatergoryModel?> getCategory() async {
    GetCatergoryModel catergoryModel = GetCatergoryModel();
    var url = Uri.parse(ApiUrl.getCatogryUrl);

    try {
      var response = await http.get(url);
      if (CommonWidgets.checkStatus(response) == 200) {
        var data = jsonDecode(response.body);
        catergoryModel = GetCatergoryModel.fromJson(data);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return catergoryModel;
  }

  static Future<GetQuestionPaperModel?> getQuestionPaper(String id, String level) async {
    GetQuestionPaperModel questionPaperModel = GetQuestionPaperModel();
    var url = Uri.parse(ApiUrl.getQuestionPaper + "?amount=" + ApiUrl.questionNumber + "&category=" + id + "&difficulty=" + level + "&type=" + ApiUrl.type);
    try {
      var response = await http.get(url);
      if (CommonWidgets.checkStatus(response) == 200) {
        var data = jsonDecode(response.body);
        questionPaperModel = GetQuestionPaperModel.fromJson(data);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return questionPaperModel;
  }
}
