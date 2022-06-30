import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Models/TridbModels/getQuestionPaperModel.dart';

class QuestionPaperAnswerController extends GetxController with GetTickerProviderStateMixin {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    var data = Get.arguments;

    classId = data["classId"];
    subjectId = data["subjectId"];
    paperId = data["paperId"];
    paperName = data["paperName"];
    passingmarks = data["passingmarks"];

    var questionAswerList = Get.arguments;
    questionList.value = questionAswerList["questionAnswerList"];
    trivaPaperName = questionAswerList["paperName"];
    level = questionAswerList["level"];
    correctAnswerListData();

    addList(questionList[0].correctAnswer, questionList[0].incorrectAnswers);

    controller = CountdownTimerController(
        endTime: level == "easy"
            ? DateTime.now().millisecondsSinceEpoch + 1000 * 1200
            : level == "medium"
                ? DateTime.now().millisecondsSinceEpoch + 1000 * 600
                : DateTime.now().millisecondsSinceEpoch + 1000 * 300);
    controller!.start();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.disposeTimer();
    controller!.dispose();
  }

  //=====================> Triva Db Controllers <======================//

  RxList<Results> questionList = <Results>[].obs;
  dynamic trivaPaperName;
  RxInt selectedIndex = 0.obs;
  Duration duration = Duration.zero;
  CountdownTimerController? controller;
  CurrentRemainingTime? time;
  RxBool isLoadingEndWidget = false.obs;
  RxMap<int, dynamic> answer = <int, dynamic>{}.obs;
  RxMap<int, dynamic> correctAnswerList = <int, dynamic>{}.obs;
  RxMap<int, dynamic> skippedQuestionList = <int, dynamic>{}.obs;
  RxList finalResultList = [].obs;
  RxList incorrectAnswerList = [].obs;
  RxList finalincorrectAnswerList = [].obs;
  List<String> questionnumber = ["A", "B", "C", "D"];
  var classId;
  var subjectId;
  var paperId;
  var paperName;
  var passingmarks;
  var subjectName;
  var level;
  RxBool isSubmittingResultLoading = false.obs;

  RxList optionsList = [].obs;

  int increment(int value) {
    value++;
    return value;
  }

  int decrement(int value) {
    value--;
    return value;
  }

  onEnd() {
    level == "easy"
        ? DateTime.now().millisecondsSinceEpoch + 1000 * 1200
        : level == "medium"
            ? DateTime.now().millisecondsSinceEpoch + 1000 * 600
            : DateTime.now().millisecondsSinceEpoch + 1000 * 10;
  }

  addList(correctanswer, List<String>? incorrectAnswers) {
    optionsList.clear();
    optionsList.add(correctanswer);
    incorrectAnswers!.forEach((element) {
      optionsList.add(element);
    });
    optionsList.shuffle();
  }

  void correctAnswerListData() {
    for (int i = 0; i < questionList.length; i++) {
      correctAnswerList[i] = questionList[i].correctAnswer;
    }
  }

  checkAtLastIndex() {
    if (answer.containsKey(selectedIndex.value)) {
    } else {
      skippedQuestionList[selectedIndex.value] = questionList[selectedIndex.value].question;
    }
  }
}
