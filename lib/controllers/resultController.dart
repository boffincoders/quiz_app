import 'package:get/get.dart';

class ResultController extends GetxController {
  var finalResult;
  var incorrectList;
  var skippedQuestionList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    finalResult = data["finalResultList"];
    incorrectList = data["incorrectAnsweList"];
    skippedQuestionList = data["skippedQuestion"];
  }
}
