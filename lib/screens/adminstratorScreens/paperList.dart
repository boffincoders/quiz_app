import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/ApiService/adminstratorServices/adminstratorServices.dart';
import 'package:quiz_app/Models/adminstratorModels/questionPaperLevelListModel.dart';
import 'package:quiz_app/utils/AppColor.dart';

import '../../utils/commonWidgets.dart';

class PaperList extends StatefulWidget {
  String? paperId;
  VoidCallback callback;

  PaperList(this.paperId, this.callback);

  @override
  _PaperListState createState() => _PaperListState();
}

class _PaperListState extends State<PaperList> {
  List<PaperListData>? paperListdata;
  List<PaperListData> levelWiseListData = [];
  var dropDownvalue = "Select Level";
  List level = [];
  bool isLoading = false;
  bool isLoadingQuestionPaperList = false;
  PaperLevelListModel? paperLevelListModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaperLevelList(widget.paperId);
    getlevels(widget.paperId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: view(context),
    );
  }

  view(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: [Colors.purple, Colors.deepPurpleAccent])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBar(),
          CommonWidgets.getSizedBox(height: 20.0),
          paperListView(),
        ],
      ),
    );
  }

  appBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
          ),
          dropDownButton(),
        ],
      ),
    );
  }

  paperListView() {
    return Expanded(
        child: Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width,
      decoration: CommonWidgets.getDecoration(boxColor: AppColors.white, boxBorderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0))),
      child: isLoadingQuestionPaperList
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Center(
                      child: Container(
                        height: 4.5,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: [Colors.blueAccent.shade700, Colors.blueAccent]),
                        ),
                      ),
                    ),
                  ),
                  selectedDropDownItem(dropDownvalue),
                ],
              ),
            ),
    ));
  }

  // level wise paper list function
  List<PaperListData>? getLevelWiseList(String dropDownvalue) {
    levelWiseListData.clear();

    paperListdata!.forEach((element) {
      isLoading = true;
      if (element.questionLevel == dropDownvalue) {
        levelWiseListData.add(element);

        if (mounted) {
          setState(() {});
        }
      }
    });
    return levelWiseListData;
  }

  dropDownButton() {
    return Container(
      width: 180,
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
          borderRadius: BorderRadius.circular(30)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_drop_down, // Add this
              color: AppColors.black,
              size: 30,
            ),
          ),
          offset: Offset(-2, -3),
          isExpanded: false,
          iconEnabledColor: Colors.white,
          hint: Container(
              margin: EdgeInsets.only(top: 15, left: 30),
              child: Text(
                dropDownvalue,
                style: CommonWidgets.getTextStyle(textColor: AppColors.black),
              )),
          style: TextStyle(color: Colors.white),
          selectedItemBuilder: (BuildContext context) {
            return level.map((value) {
              return Padding(
                padding: EdgeInsets.only(top: 12.0, left: 0.0),
                child: Text(
                  dropDownvalue,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              );
            }).toList();
          },
          items: level.map((selectedType) {
            return DropdownMenuItem(
              child: Text(
                "    ${selectedType}",
                style: TextStyle(color: Colors.black),
              ),
              value: selectedType.toString(),
            );
          }).toList(),
          onChanged: (newValue) {
            dropDownvalue = newValue.toString();
            if (mounted) {
              setState(() {});
            }
            getLevelWiseList(dropDownvalue);
          },
        ),
      ),
    );
  }

  Widget selectedDropDownItem(String dropdownvalue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.black, width: 2))),
              child: Text(
                dropDownvalue == "Select Level" ? "${dropDownvalue}" : " Level ${dropDownvalue}",
                style: CommonWidgets.getTextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          levelWiseListData.length > 0
              ? Container(
                  margin: EdgeInsets.only(top: 5),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: levelWiseListData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(color: AppColors.grey), borderRadius: BorderRadius.circular(4)),
                            padding: EdgeInsets.all(6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Ques${index + 1}: ${levelWiseListData[index].questionName}",
                                    style: CommonWidgets.getTextStyle(textColor: AppColors.black),
                                    softWrap: true,
                                    maxLines: 4,
                                  ),
                                ),
                                GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      deleteQuestionDialog(levelWiseListData[index].questionId);
                                    },
                                    child: Icon(Icons.delete,color: AppColors.gradientColor,))
                              ],
                            ),
                          ),
                        );
                      }),
                )
              : Center(child: Align(alignment: Alignment.bottomCenter, child: Text("No Questions"))),
        ],
      ),
    );
  }

  deleteQuestionDialog(String? questionId) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure want to delete the question? "),
            actions: <Widget>[
              GestureDetector(
                onTap: () async {
                  await deleteQuestion(questionId);
                },
                child: Container(
                  color: AppColors.gradientColor,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    "Yes",
                    style: CommonWidgets.getTextStyle(textColor: AppColors.white),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  color: AppColors.gradientColor,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    "No",
                    style: CommonWidgets.getTextStyle(textColor: AppColors.white),
                  ),
                ),
              ),
            ],
          );
        });
  }

  // delete questions function
  deleteQuestion(String? questionId) async {
    var response = await AdminstratorServices.deleteQuestions(questionId: questionId);
    if (response != null) {
      var refreshList = await refreshListData(widget.paperId!, dropDownvalue);
      if (refreshList != null) {
        widget.callback();
        Navigator.pop(context);
      }
    }
  }

  // upated paper list function
  Future<List<PaperListData>?> refreshListData(String paperId, String dropDownvalue) async {
    PaperLevelListModel? response = await AdminstratorServices.getPaperLevelList(paperId: paperId);
    if (response != null) {
      paperListdata = response.data ?? [];

      if (mounted) {
        setState(() {});
      }
      getLevelWiseList(dropDownvalue);
    }
    return paperListdata;
  }

  // all level list function
  Future getlevels(String? paperId) async {
    level.clear();
    var response = await AdminstratorServices.getLevels(int.parse(paperId!));
    if (response != null) {
      level = response.levels ?? [];
      level.sort((a, b) => a.compareTo(b));
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<PaperLevelListModel?> getPaperLevelList(String? paperId) async {
    isLoadingQuestionPaperList = true;
    if (mounted) {
      setState(() {});
    }
    PaperLevelListModel? response = await AdminstratorServices.getPaperLevelList(paperId: paperId!);
    if (response != null) {
      isLoadingQuestionPaperList = false;
      if (mounted) {
        setState(() {});
      }
      paperLevelListModel = response;
      paperListdata = paperLevelListModel!.data;
    }
    return paperLevelListModel;
  }
}
