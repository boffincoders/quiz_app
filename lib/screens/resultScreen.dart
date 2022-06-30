import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/bindings/levelBindings.dart';
import 'package:quiz_app/controllers/homeController.dart';
import 'package:quiz_app/controllers/questionPaperController.dart';
import 'package:quiz_app/controllers/resultController.dart';
import 'package:quiz_app/screens/selectDifficultyLevelScreen.dart';
import 'package:quiz_app/utils/AppColor.dart';
import 'package:quiz_app/utils/commonWidgets.dart';


class ResultScreen extends GetView<ResultController> {
  final HomeController homeController = Get.find<HomeController>();
  final QuestionPaperAnswerController questionAnswerController = Get.find<QuestionPaperAnswerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: view(context),
    );
  }

  view(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: [Colors.purple, Colors.deepPurpleAccent])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidgets.getSizedBox(height: 15.0),
          appBar(context),
          CommonWidgets.getSizedBox(height: 8.0),
          Center(
            child: Text("&", style: CommonWidgets.getTextStyle(fontSize: 40, textColor: AppColors.white)),
          ),
          CommonWidgets.getSizedBox(height: 8.0),
          Center(child: Text("Explanation of the wrong Answer", style: CommonWidgets.getTextStyle(fontSize: 20, textColor: AppColors.white))),
          scoreCardView(context),

          // questionPaperView(context),
        ],
      ),
    );
  }

  appBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 50,
      child: ListTile(
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Get.off(() => DifficultyLevelScreen(), binding: LevelBinding());
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
        ),
        title: Center(
            child: Text(
          " Final Score of the Quiz",
          style: CommonWidgets.getTextStyle(fontSize: 20, textColor: AppColors.white),
        )),
        trailing: CircleAvatar(
          backgroundColor: AppColors.grey,
        ),
      ),
    );
  }

  scoreCardView(BuildContext context) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: CommonWidgets.getDecoration(boxColor: AppColors.white, boxBorderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidgets.getSizedBox(height: 20.0),
          Center(
            child: Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: [Colors.blueAccent.shade700, Colors.blueAccent]),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  resultCard(),
                  CommonWidgets.getSizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  resultCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40.0),
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 6,
              blurRadius: 7,
              offset: const Offset(0, -1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "FINAL SCORE",
            style: CommonWidgets.getTextStyle(fontSize: 30, textColor: AppColors.black, fontWeight: FontWeight.w700),
            maxLines: 2,
            softWrap: true,
          ),
          CommonWidgets.getSizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Correct Answers :", style: CommonWidgets.getTextStyle(fontSize: 22, textColor: AppColors.black, fontWeight: FontWeight.w700)),
              Text(
                " ${controller.finalResult.length}/${questionAnswerController.correctAnswerList.length}",
                style: CommonWidgets.getTextStyle(fontSize: 22, textColor: AppColors.black, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          CommonWidgets.getSizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Incorrect Answers :", style: CommonWidgets.getTextStyle(fontSize: 22, textColor: AppColors.black, fontWeight: FontWeight.w700)),
              Text(
                " ${controller.incorrectList.length}/${questionAnswerController.correctAnswerList.length}",
                style: CommonWidgets.getTextStyle(fontSize: 22, textColor: AppColors.black, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          CommonWidgets.getSizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Attempted :", style: CommonWidgets.getTextStyle(fontSize: 22, textColor: AppColors.black, fontWeight: FontWeight.w700)),
              Text(
                " ${questionAnswerController.answer.length}/${questionAnswerController.correctAnswerList.length}",
                style: CommonWidgets.getTextStyle(fontSize: 22, textColor: AppColors.black, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          CommonWidgets.getSizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Skipped Question:", style: CommonWidgets.getTextStyle(fontSize: 22, textColor: AppColors.black, fontWeight: FontWeight.w700)),
              Text(
                " ${questionAnswerController.skippedQuestionList.length}/${questionAnswerController.correctAnswerList.length}",
                style: CommonWidgets.getTextStyle(fontSize: 22, textColor: AppColors.black, fontWeight: FontWeight.w700),
              ),
            ],
          )
        ],
      ),
    );
  }

}
