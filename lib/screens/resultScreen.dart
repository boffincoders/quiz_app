import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_app/ApiService/ClassServices/classServices.dart';
import 'package:quiz_app/Models/classModels/overAllResultModel.dart';
import 'package:quiz_app/Models/classModels/resultModel.dart';
import 'package:quiz_app/Models/classModels/subjectPaperModel.dart';
import 'package:quiz_app/Models/classModels/subjectQuestionAnswerModel.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/screens/overAllResultScreen.dart';
import 'package:quiz_app/screens/questions.dart';

import '../utils/AppColor.dart';
import '../utils/commonWidgets.dart';

class ResultScreen extends StatefulWidget {
  ResultModel? resultModel;
  String? passingMarks;
  String? classId;
  String? subjectId;
  String? paperId;
  SubjectQuestionAnswerModel? subjectQuestionAnswer;
  String? subjectName1;
  String? totalLevels;
  VoidCallback? callback;

  ResultScreen({this.resultModel, this.passingMarks, this.classId, this.subjectId, this.paperId, this.subjectQuestionAnswer, this.subjectName1, this.totalLevels, this.callback});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  SubjectQuestionAnswerModel? subjectQuestionAnswerModel;
  bool isLoading = false;
  List<Data>? data = [];
  List level = [];
  List<OverAllResult>? overAllResult = [];
  List<SubjectPaperData> subjectsPaper = [];
  bool isLoadingPaper = false;
  bool isLoadingOverAllResult = false;
  List<IncorrectData> incorrectListData = [];
  List<UnselectedData> unselectedData = [];
  List overAllResultList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.resultModel;
    incorrectListData = widget.resultModel?.results?.incorrectData ?? [];
    unselectedData = widget.resultModel?.results?.unselectedData ?? [];
    data = widget.subjectQuestionAnswer?.data ?? [];
    data!.forEach((element) {
      var i = level.indexWhere((x) => x["question_level"] == element.level.toString());
      if (i <= -1) {
        level.add({"question_level": element.level.toString()});
      }
    });

    if (widget.subjectQuestionAnswer!.data![0].level == widget.totalLevels) {
      prefs!.setString('resultData', jsonEncode(widget.resultModel));
      prefs!.setString('questionAnswerData', jsonEncode(widget.subjectQuestionAnswer));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: view(context),
      ),
    );
  }

  view(BuildContext context) {
    print(widget.resultModel);
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: [Colors.purple, Colors.deepPurpleAccent])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidgets.getSizedBox(height: 15.0),
          appBar(),
          CommonWidgets.getSizedBox(height: 8.0),
          Center(
            child: Text("&", style: CommonWidgets.getTextStyle(fontSize: 40, textColor: AppColors.white)),
          ),
          CommonWidgets.getSizedBox(height: 8.0),
          Center(child: Text("Explanation of the wrong Answer", style: CommonWidgets.getTextStyle(fontSize: 20, textColor: AppColors.white))),
          scoreCardView(),

          // questionPaperView(context),
        ],
      ),
    );
  }

  appBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 50,
      child: ListTile(
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.of(context).pop();
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

  scoreCardView() {
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
                  Visibility(
                    visible: incorrectListData.isNotEmpty && unselectedData.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
                      child: Text(
                        "Here you can read the right answer which you did not know before . It help to enhance your knowledge",
                        softWrap: true,
                        maxLines: 2,
                        style: CommonWidgets.getTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  CommonWidgets.getSizedBox(height: 15.0),
                  incorrectAnsweListView(),
                  unselectesAnswerListView(),
                ],
              ),
            ),
          ),
          CommonWidgets.getSizedBox(height: 7.0),
          widget.totalLevels == widget.subjectQuestionAnswer!.data![0].level && widget.resultModel!.results!.correct == widget.subjectQuestionAnswer!.data!.length
              ? endQuizbutton()
              : widget.totalLevels != widget.subjectQuestionAnswer!.data![0].level && widget.resultModel!.results!.correct! >= int.parse(widget.passingMarks.toString())
                  ? nextLevelButton()
                  : restartQuizButton()
        ],
      ),
    ));
  }

  resultCard() {
    return Container(
      height: 130,
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
          Text(
            " ${widget.resultModel!.results!.correct.toString()}/${widget.subjectQuestionAnswer!.data!.length}",
            style: CommonWidgets.getTextStyle(fontSize: 30, textColor: AppColors.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  endQuizbutton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        isLoadingOverAllResult = true;
        if (mounted) {
          setState(() {});
        }
        List<OverAllResult>? data = await getOverAllResult(widget.paperId);
        if (data != null) {
          isLoadingOverAllResult = false;
          if (mounted) {
            setState(() {});
          }
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => OverAllResultScreen(
                      widget.callback ?? () {},
                      data: data,
                    )),
          );
          if (widget.callback != null) {
            widget.callback!();
          }
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: CommonWidgets.getDecoration(
          boxBorderRadius: BorderRadius.circular(7),
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.purple, Colors.deepPurpleAccent]),
        ),
        child: isLoadingOverAllResult
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                "See Over All Result",
                style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 17, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  nextLevelButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        isLoading = true;
        if (mounted) {
          setState(() {});
        }
        SubjectQuestionAnswerModel? subjectQuestionAnswerdata = await getSubjectQuestionPaper(widget.paperId);
        if (subjectQuestionAnswerdata != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => QuestionPaper(
                      () {
                        getSubjectQuestionPaper(widget.subjectId);
                      },
                      subjectId: widget.subjectId,
                      classId: widget.classId,
                      paperId: widget.paperId,
                      passingMarks: int.parse(widget.passingMarks!),
                      subjectName1: widget.subjectName1,
                    )),
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: CommonWidgets.getDecoration(
          boxBorderRadius: BorderRadius.circular(7),
          gradient:const  LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.purple, Colors.deepPurpleAccent]),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                "Next Level",
                style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 17, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  Future<SubjectQuestionAnswerModel?> getSubjectQuestionPaper(String? id) async {
    SubjectQuestionAnswerModel? response = await ClassServices.getSubjectPaperQuestionAnswer(id!);
    if (response != null) {
      isLoading = true;
      if (mounted) {
        setState(() {});
      }
      subjectQuestionAnswerModel = response;

      if (mounted) {
        setState(() {});
      }
    }
    return subjectQuestionAnswerModel;
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future getSubjectPaper(String? id) async {
    subjectsPaper.clear();
    isLoadingPaper = true;
    if (mounted) {
      setState(() {});
    }
    var response = await ClassServices.getSubjectPaper(id!);
    if (response != null) {
      isLoadingPaper = false;
      subjectsPaper = response.data ?? [];
      if (mounted) {
        setState(() {});
      }
    }
  }

  restartQuizButton() {
    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          isLoading = true;
          if (mounted) {
            setState(() {});
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => QuestionPaper(
                      widget.callback ?? () {},
                      subjectId: widget.subjectId,
                      classId: widget.classId,
                      paperId: widget.paperId,
                      passingMarks: int.parse(widget.passingMarks!),
                      subjectName1: widget.subjectName1,
                    )),
          );
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: CommonWidgets.getDecoration(
            boxBorderRadius: BorderRadius.circular(7),
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.purple, Colors.deepPurpleAccent]),
          ),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Text(
                  "Restart Level",
                  style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 17, fontWeight: FontWeight.w600),
                ),
        ),
      ),
    );
  }

  incorrectAnsweListView() {
    return Container(
      child: incorrectListData.length > 0
          ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: incorrectListData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(bottom: 20, left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 3.5,
                            backgroundColor: AppColors.black,
                          ),
                          CommonWidgets.getSizedBox(width: 15.0),
                          Expanded(
                            child: Text(
                              "${incorrectListData[index].questionText}",
                              softWrap: true,
                              maxLines: 2,
                              style: CommonWidgets.getTextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      CommonWidgets.getSizedBox(height: 6.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("${incorrectListData[index].correctAnswerText}",
                            softWrap: true, maxLines: 2, style: CommonWidgets.getTextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                      )
                    ],
                  ),
                );
              })
          : SizedBox.shrink(),
    );
  }

  Future<List<OverAllResult>?> getOverAllResult(String? paperId) async {
    overAllResult!.clear();
    var response = await ClassServices.getOverAllResult(paperId!);
    if (response != null) {
      overAllResult = response.results ?? [];
      if (mounted) {
        setState(() {});
      }
    }
    return overAllResult;
  }

  unselectesAnswerListView() {
    return Container(
      child: unselectedData.length > 0
          ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: unselectedData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(bottom: 20, left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 3.5,
                            backgroundColor: AppColors.black,
                          ),
                          CommonWidgets.getSizedBox(width: 15.0),
                          Expanded(
                            child: Text(
                              "${unselectedData[index].questionName}",
                              softWrap: true,
                              maxLines: 2,
                              style: CommonWidgets.getTextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      CommonWidgets.getSizedBox(height: 6.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(unselectedData[index].answers?[0].answerName ?? '',
                            softWrap: true, maxLines: 2, style: CommonWidgets.getTextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                      )
                    ],
                  ),
                );
              })
          : SizedBox.shrink(),
    );
  }
}
