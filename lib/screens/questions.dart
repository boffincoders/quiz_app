import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/ApiService/ClassServices/classServices.dart';
import 'package:quiz_app/Models/classModels/overAllResultModel.dart';
import 'package:quiz_app/Models/classModels/subjectQuestionAnswerModel.dart';
import 'package:quiz_app/screens/overAllResultScreen.dart';
import 'package:quiz_app/screens/resultScreen.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

import '../utils/AppColor.dart';

class QuestionPaper extends StatefulWidget {
  VoidCallback callback;
  String? classId;
  String? subjectId;
  String? paperId;
  String? subjectName1;
  int? passingMarks;

  QuestionPaper(this.callback, {this.classId, this.subjectId, this.paperId, this.subjectName1, this.passingMarks});

  @override
  State<QuestionPaper> createState() => _QuestionPaperState();
}

class _QuestionPaperState extends State<QuestionPaper> with TickerProviderStateMixin {
  List<Data> mainQuestionAnswerList = [];
  String? subjectName;
  var firstIndex = 0;
  var index;
  var answerId = "";
  var lastIndex;
  var currentIndex;
  Map<String, dynamic>? answer = {};
  bool isChecked = false;
  List<Map<String, dynamic>> resultList = [];
  List<OverAllResult>? overAllResult = [];
  List<Map<String, dynamic>> isCheckedList = [];
  bool isSubmittingResultLoading = false;

  List<String> questionnumber = ["A", "B", "C", "D"];

  TabController? _tabController;
  int selectedTab = 0;
  SubjectQuestionAnswerModel? subjectQuestionAnswerModel;
  bool isLoadingData = true;

  @override
  void initState() {
    super.initState();
    getSubjectQuestionpaper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: view(context),
    );
  }

  view(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: [Colors.purple, Colors.deepPurpleAccent])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidgets.getSizedBox(height: 25.0),
          appBar(),
          questionPaperView(context),
        ],
      ),
    );
  }

  appBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: 50,
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
          ),
          CommonWidgets.getSizedBox(width: 15.0),
          Expanded(
            child: Text(
              subjectName ?? "",
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
      margin: EdgeInsets.only(top: 20),
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
          questionDetail(context),
          SizedBox(
            height: 20,
          ),
          mainQuestionAnswerList.length > 0 ? submitButton(context) : SizedBox.shrink(),
        ],
      ),
    ));
  }

  questionDetail(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Expanded(child: questionTabBar(context)),
          ],
        ),
      ),
    );
  }

  subjectiveQuestion(Data questionAnswerList, int tabIndex) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              questionAnswerList.question!,
              style: CommonWidgets.getTextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              softWrap: true,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questionAnswerList.answer!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (selectedTab == tabIndex) {
                        answerId = questionAnswerList.answer![index].answerId!;
                        if (mounted) {
                          setState(() {});
                        }
                        answer = {"answer_id": answerId, "question_id": questionAnswerList.questionId!};
                        int index1 = resultList.indexWhere((element) => element['question_id'] == answer!['question_id']);

                        if (index1 < 0) {
                          resultList.add({"question_id": questionAnswerList.questionId!, "answer_id": answerId});
                        } else {
                          var index = resultList.indexWhere((element) => element["question_id"] == questionAnswerList.questionId!);
                          if (index > -1) {
                            if (resultList[index]["question_id"] == questionAnswerList.questionId! && resultList[index]["answer_id"] == answerId) {
                              resultList.removeAt(index);
                            } else {
                              if (mounted) {
                                setState(() {
                                  resultList[index]["answer_id"] = answerId;
                                });
                              }
                            }
                          }
                        }
                      }
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: getBackgroundColor(questionAnswerList.answer!, resultList, tabIndex, questionAnswerList.answer![index].answerId),
                          // backgroundColor:bg_color ,
                          child: Text(
                            questionnumber[index],
                            style: CommonWidgets.getTextStyle(textColor: AppColors.white),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(questionAnswerList.answer!.isNotEmpty ? questionAnswerList.answer![index].answerName! : "",
                            style: CommonWidgets.getTextStyle(
                                textColor: getBackgroundColor(questionAnswerList.answer!, resultList, tabIndex, questionAnswerList.answer![index].answerId)),
                            softWrap: true),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  submitButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              firstIndex = mainQuestionAnswerList.indexOf(mainQuestionAnswerList.first);
              lastIndex = mainQuestionAnswerList.lastIndexOf(mainQuestionAnswerList.last);
              if (selectedTab != firstIndex || selectedTab == lastIndex) {
                if (mounted) {
                  setState(() {
                    selectedTab = _tabController!.index - 1;
                  });
                }
                _tabController!.animateTo(selectedTab);
              }
              ;
            },
            child: Image.asset(
              selectedTab == firstIndex ? "assets/arrow3.png" : "assets/arrow1.png",
              height: 60,
            ),
          ),
          submit(context, index),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              index = mainQuestionAnswerList.lastIndexOf(mainQuestionAnswerList.last);
              if (selectedTab != index) {
                if (mounted) {
                  setState(() {
                    selectedTab = _tabController!.index + 1;
                  });
                }
                _tabController!.animateTo(selectedTab);
              }
            },
            child: Image.asset(selectedTab == index ? "assets/arrow2.png" : "assets/arrow.png", height: 60),
          )
        ],
      ),
    );
  }

  submit(BuildContext context, index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: resultList.length >= 0 && resultList.length < 1
          ? () async {
              isSubmittingResultLoading = false;
              return CommonWidgets.showToast(toast: Toast.LENGTH_SHORT, toastGravity: ToastGravity.TOP, msg: "Please select atleast 1 answers");
            }
          : () async {
              await submitAnswer(index);
            },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        height: 50,
        width: MediaQuery.of(context).size.width * .5,
        decoration: BoxDecoration(border: Border.all(color: AppColors.textGradientColor), borderRadius: BorderRadius.circular(5)),
        child: isSubmittingResultLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                "Submit Quiz",
                style: CommonWidgets.getTextStyle(textColor: AppColors.textGradientColor, fontSize: 17, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  questionTabBar(BuildContext context) {
    if (subjectQuestionAnswerModel == null && isLoadingData) {
      return const Center(child: CircularProgressIndicator());
    } else if (subjectQuestionAnswerModel == null && !isLoadingData) return Center(child: Text("No record found!"));
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                //This is for background color
                color: Colors.white.withOpacity(0.0),
                //This is for bottom border that is needed
                border: Border(bottom: BorderSide(color: Colors.grey.shade400, width: 1.5))),
            child: DefaultTabController(
              length: mainQuestionAnswerList.length,
              child: TabBar(
                indicatorColor: AppColors.textGradientColor,
                isScrollable: true,
                unselectedLabelColor: AppColors.grey,
                labelColor: AppColors.gradientColor,
                physics: AlwaysScrollableScrollPhysics(),
                tabs: tabMaker(),
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
          ),
          Visibility(
            visible: subjectQuestionAnswerModel == null ? false : true,
            child: Expanded(
              child: TabBarView(
                children: List<Widget>.generate(mainQuestionAnswerList.length, (int index) {
                  return questions(mainQuestionAnswerList[selectedTab], index);
                }),
                controller: _tabController,
              ),
            ),
          ),
        ],
      ),
    );
  }

  questions(
    Data questionAnswerList,
    int tabIndex,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          subjectiveQuestion(questionAnswerList, tabIndex),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  // dynamic tabs
  tabMaker() {
    List<Tab> tabs = [];
    for (var i = 0; i < mainQuestionAnswerList.length; i++) {
      tabs.add(Tab(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: selectedTab == i ? AppColors.textGradientColor : AppColors.grey,
            child: Text(
              (i + 1).toString(),
              style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ));
    }
    ;
    return tabs;
  }

  // Submit Quiz Button function
  Future submitAnswer(index) async {
    isSubmittingResultLoading = true;
    if (mounted) {
      setState(() {});
    }
    var response = await ClassServices.getSubjectPaperQuestionAnswerResult(
        classId: widget.classId,
        paperId: widget.paperId,
        subjectId: widget.subjectId,
        result: resultList,
        level: mainQuestionAnswerList[index].level,
        passingMarks: widget.passingMarks);

    if (response!.results != null) {
      widget.callback();
      isSubmittingResultLoading = false;
      if (mounted) {
        setState(() {});
      }

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ResultScreen(
                    resultModel: response,
                    passingMarks: widget.passingMarks.toString(),
                    totalLevels: subjectQuestionAnswerModel!.totalLevels.toString(),
                    subjectId: widget.subjectId,
                    paperId: widget.paperId,
                    subjectName1: widget.subjectName1,
                    subjectQuestionAnswer: subjectQuestionAnswerModel,
                    classId: widget.classId,
                    callback: widget.callback,
                  )));
    }
  }

  // Color changing Function according to the selected and unselected answers
  Color? getBackgroundColor(List mainList, List<Map<String, dynamic>> resultList, int tabIndex, var answer) {
    Color? selectedColor = AppColors.grey;

    if (answer == null && resultList.isEmpty) {
      selectedColor = Colors.grey;
    } else {
      if (selectedTab == tabIndex) {
        if (resultList.length > 0) {
          var data = resultList.where((element) => element['answer_id'].toString() == answer.toString()).toList();
          if (data.length > 0) {
            if (mainList.map((answers) => answers.answerId).contains(data[0]['answer_id'])) {
              selectedColor = AppColors.textGradientColor;
            } else {
              selectedColor = AppColors.grey;
            }
          }
        }
      }
    }
    return selectedColor;
  }

  Future getSubjectQuestionpaper() async {
    SubjectQuestionAnswerModel? subjectQuestionAnswerdata = await getSubjectQuestionPaper(widget.paperId);
    if (subjectQuestionAnswerdata!.data == null) {
      List<OverAllResult>? data = await getOverAllResult(widget.paperId);
      if (data!.isNotEmpty) {
        await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return OverAllResultScreen(
            () {
              widget.callback();
            },
            data: data,
          );
        }));
        widget.callback();
      }
    } else {
      subjectQuestionAnswerModel = subjectQuestionAnswerdata;
      mainQuestionAnswerList = subjectQuestionAnswerModel!.data == null ? [] : subjectQuestionAnswerModel!.data!;
      subjectName = widget.subjectName1;
      mainQuestionAnswerList.length > 0 ? tabMaker() : SizedBox();
      _tabController = TabController(length: mainQuestionAnswerList.length, vsync: this, animationDuration: Duration.zero);
      _tabController!.addListener(() {
        if (mounted) {
          setState(() {
            selectedTab = _tabController!.index;
          });
        }
      });
      lastIndex = mainQuestionAnswerList.length > 0 ? mainQuestionAnswerList.lastIndexOf(mainQuestionAnswerList.last) : "";

      index = mainQuestionAnswerList.length > 0 ? mainQuestionAnswerList.lastIndexOf(mainQuestionAnswerList.last) : "";
    }
    if (mounted)
      setState(() {
        isLoadingData = false;
      });
  }

  Future<SubjectQuestionAnswerModel?> getSubjectQuestionPaper(String? id) async {
    try {
      SubjectQuestionAnswerModel? response = await ClassServices.getSubjectPaperQuestionAnswer(id!);

      return response;
    } catch (e) {}
  }

  Future<List<OverAllResult>?> getOverAllResult(String? paperId) async {
    overAllResult!.clear();
    var response = await ClassServices.getOverAllResult(paperId!);
    if (response != null) {
      overAllResult = response.results ?? [];
    }
    return overAllResult;
  }
}
