import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Models/TridbModels/getQuestionPaperModel.dart';
import 'package:quiz_app/bindings/resultBinding.dart';
import 'package:quiz_app/controllers/homeController.dart';
import 'package:quiz_app/controllers/questionPaperController.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/screens/resultScreen.dart';
import 'package:quiz_app/utils/AppColor.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

class QuestionPaper extends GetView<QuestionPaperAnswerController> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: view(context),
    );
  }

  view(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: [Colors.purple, Colors.deepPurpleAccent])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.getSizedBox(height: 25.0),
              appBar(context),
              questionPaperView(context),
            ],
          ),
        ));
  }

  appBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 50,
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
          ),
          CommonWidgets.getSizedBox(width: 15.0),
          Expanded(
            child: Text(
              // controller.paperName,
              controller.trivaPaperName,
              softWrap: true,
              style: CommonWidgets.getTextStyle(fontSize: 22, textColor: AppColors.white),
            ),
          )
        ],
      ),
    );
  }

  questionPaperView(BuildContext context) {
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
          questionDetail(context, controller.questionList[controller.selectedIndex.value], controller.selectedIndex.value),
          const SizedBox(
            height: 20,
          ),

        ],
      ),
    ));
  }

  questionDetail(BuildContext context, Results questionList, int slectedTabIndex) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded(child: questionTabBar(context)),

              CommonWidgets.getSizedBox(height: 15),
              Expanded(child: questionAnswer(context, questionList, slectedTabIndex)),
            ],
          ),
        ),
      ),
    );
  }




  questionView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: SingleChildScrollView(
        child: prevoiusAndSkipButton(),
      ),
    );
  }

  prevoiusAndSkipButton() {
    return controller.selectedIndex.value == controller.questionList.length - 1
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [previousButton(), submitQuizButton()],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [previousButton(), skipButton()],
          );
  }

  previousButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: controller.selectedIndex.value == 0
          ? null
          : () {
              if (controller.selectedIndex.value > 0 || controller.selectedIndex.value == controller.questionList.length - 1) {
                controller.selectedIndex.value = controller.decrement(controller.selectedIndex.value);
                controller.addList(controller.questionList[controller.selectedIndex.value].correctAnswer, controller.questionList[controller.selectedIndex.value].incorrectAnswers);
              }
            },
      child: CommonWidgets.getButton(
          isLoading: false,
          btnText: "Previous",
          btnTextStyle: CommonWidgets.getTextStyle(fontSize: 15, textColor: controller.selectedIndex.value == 0 ? AppColors.grey : AppColors.black)),
    );
  }

  skipButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (controller.selectedIndex.value == 0) {
          if (controller.answer.containsKey(controller.selectedIndex.value)) {
            if (controller.skippedQuestionList.containsKey(controller.selectedIndex.value)) {
              controller.skippedQuestionList.remove(controller.selectedIndex.value);
            }
          } else {
            controller.skippedQuestionList[controller.selectedIndex.value] = controller.questionList[controller.selectedIndex.value].question;
          }
          controller.selectedIndex.value = controller.increment(controller.selectedIndex.value);
          controller.addList(controller.questionList[controller.selectedIndex.value].correctAnswer, controller.questionList[controller.selectedIndex.value].incorrectAnswers);
        } else {
          if (controller.selectedIndex.value >= 1 && controller.selectedIndex.value < controller.questionList.length - 1) {
            if (controller.answer.containsKey(controller.selectedIndex.value)) {
              if (controller.skippedQuestionList.containsKey(controller.selectedIndex.value)) {
                controller.skippedQuestionList.remove(controller.selectedIndex.value);
              }
            } else {
              controller.skippedQuestionList[controller.selectedIndex.value] = controller.questionList[controller.selectedIndex.value].question;
            }
            controller.selectedIndex.value = controller.increment(controller.selectedIndex.value);
            controller.addList(controller.questionList[controller.selectedIndex.value].correctAnswer, controller.questionList[controller.selectedIndex.value].incorrectAnswers);
          }
        }
        print("skipped  question ${controller.skippedQuestionList.length}");
        print("answer  ${controller.answer.length}");
      },
      child: CommonWidgets.getButton(
          isLoading: false,
          btnText: "Skip",
          btnTextStyle:
              CommonWidgets.getTextStyle(fontSize: 15, textColor: controller.selectedIndex.value == controller.questionList.length - 1 ? AppColors.grey : AppColors.black)),
    );
  }

  questionAnswer(BuildContext context, Results questionList, int slectedTabIndex) {
    return CountdownTimer(
      controller: controller.controller,
      onEnd: controller.onEnd(),
      widgetBuilder: (_, CurrentRemainingTime? time) {
        if (time == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  "Quiz Over",
                  style: CommonWidgets.getTextStyle(fontSize: 25),
                ),
              ),
              seeResultButton(),
            ],
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("${time.min ?? "00"}:${time.sec.toString().padLeft(2, '0')}", style: const TextStyle(fontSize: 24.0)),
                ),
                CommonWidgets.getSizedBox(height: 8),
                Text("Ques" "${controller.selectedIndex.value + 1}",
                    style: CommonWidgets.getTextStyle(textColor: AppColors.textGradientColor, fontSize: 22, fontWeight: FontWeight.w600)),
                CommonWidgets.getSizedBox(height: 8),
                Text(questionList.question!, style: CommonWidgets.getTextStyle(textColor: AppColors.black, fontSize: 18)),
                CommonWidgets.getSizedBox(height: 15),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: controller.optionsList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              if (controller.selectedIndex.value == controller.questionList.length - 1) {
                                if (controller.skippedQuestionList.containsKey(slectedTabIndex)) {
                                  controller.skippedQuestionList.remove(slectedTabIndex);
                                }
                                controller.answer[slectedTabIndex] = controller.optionsList[index];
                              } else {
                                if (controller.skippedQuestionList.containsKey(slectedTabIndex)) {
                                  controller.skippedQuestionList.remove(slectedTabIndex);
                                }
                                controller.answer[slectedTabIndex] = controller.optionsList[index];
                                controller.selectedIndex.value = controller.increment(controller.selectedIndex.value);
                                controller.addList(controller.questionList[controller.selectedIndex.value].correctAnswer,
                                    controller.questionList[controller.selectedIndex.value].incorrectAnswers);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: controller.answer[slectedTabIndex] == controller.optionsList[index] ? AppColors.textGradientColor : AppColors.grey,
                                    child: Text(
                                      controller.questionnumber[index],
                                      style: CommonWidgets.getTextStyle(textColor: AppColors.white),
                                    ),
                                  ),
                                  CommonWidgets.getSizedBox(width: 8),
                                  Expanded(
                                      child: Text(
                                    controller.optionsList[index],
                                    style: CommonWidgets.getTextStyle(
                                        fontSize: 18,
                                        textColor: controller.answer[slectedTabIndex] == controller.optionsList[index] ? AppColors.textGradientColor : AppColors.grey),
                                    softWrap: true,
                                    maxLines: 3,
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
            questionView(context),
          ],
        );
      },
    );
  }

  submitQuizButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        controller.incorrectAnswerList.clear();
        controller.isSubmittingResultLoading.value = true;
        Future.delayed(const Duration(seconds: 8));
        controller.checkAtLastIndex();
        for (int i = 0; i < controller.correctAnswerList.length; i++) {
          if (controller.correctAnswerList.containsValue(controller.answer[i])) {
            controller.finalResultList.add(controller.answer[i]);
          } else {
            controller.incorrectAnswerList.add(controller.answer[i]);
          }
        }
        if (controller.incorrectAnswerList.isNotEmpty) {
          controller.incorrectAnswerList.forEach((element) {
            if (element != null) {
              controller.finalincorrectAnswerList.add(element);
            }
          });
        }
        var data = await quizAppDb.saveBlog(
            controller.trivaPaperName, controller.level, controller.finalResultList.length, controller.finalincorrectAnswerList.length, controller.skippedQuestionList.length);
        controller.isSubmittingResultLoading.value = false;
        if (data == true) {
          Get.off(() => ResultScreen(),
              arguments: {
                "finalResultList": controller.finalResultList,
                "incorrectAnsweList": controller.finalincorrectAnswerList,
                "skippedQuestion": controller.skippedQuestionList
              },
              binding: ResultBinding());
        }
      },
      child: CommonWidgets.getButton(
          isLoading: controller.isSubmittingResultLoading.value,
          btnText: "Submit",
          btnTextStyle: CommonWidgets.getTextStyle(fontSize: 15, textColor: controller.selectedIndex.value == 0 ? AppColors.grey : AppColors.black)),
    );
  }

  seeResultButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        controller.controller!.disposeTimer();
        controller.incorrectAnswerList.clear();
        controller.isSubmittingResultLoading.value = true;
        for (int i = 0; i < controller.correctAnswerList.length; i++) {
          if (controller.correctAnswerList.containsValue(controller.answer[i])) {
            controller.finalResultList.add(controller.answer[i]);
          } else {
            controller.incorrectAnswerList.add(controller.answer[i]);
          }
        }
        if (controller.incorrectAnswerList.isNotEmpty) {
          controller.incorrectAnswerList.forEach((element) {
            if (element != null) {
              controller.finalincorrectAnswerList.add(element);
            }
          });
        }
        var data = await quizAppDb.saveBlog(
            controller.trivaPaperName, controller.level, controller.finalResultList.length, controller.finalincorrectAnswerList.length, controller.skippedQuestionList.length);
        controller.isSubmittingResultLoading.value = false;
        if (data == true) {
          Get.off(() => ResultScreen(),
              arguments: {
                "finalResultList": controller.finalResultList,
                "incorrectAnsweList": controller.finalincorrectAnswerList,
                "skippedQuestion": controller.skippedQuestionList
              },
              binding: ResultBinding());
        }
      },
      child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: CommonWidgets.getButton(
            isLoading: false,
            btnText: "See the Result",
            btnTextStyle: CommonWidgets.getTextStyle(fontSize: 15, textColor: AppColors.black),
          )),
    );
  }
}
