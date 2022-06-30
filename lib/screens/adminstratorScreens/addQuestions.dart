import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/ApiService/adminstratorServices/adminstratorServices.dart';
import 'package:quiz_app/utils/AppColor.dart';
import 'package:quiz_app/utils/AppStrings.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

class AddQuestionsScrren extends StatefulWidget {
  String? paperId;
  VoidCallback callback;

  AddQuestionsScrren(this.paperId, this.callback);

  @override
  _AddQuestionsScrrenState createState() => _AddQuestionsScrrenState();
}

class _AddQuestionsScrrenState extends State<AddQuestionsScrren> {
  TextEditingController? questionController;
  TextEditingController? answer1Controller;
  TextEditingController? answer2Controller;
  TextEditingController? answer3Controller;
  TextEditingController? answer4Controller;
  String? dropDownvalue;

  int? isChecked;

  bool isaddQuestionLoading = false;

  String correctAnswer = "";

  List level = [];
  List answerList = ["Enter Answer1 here", "Enter Answer2 here", "Enter Answer3 here", "Enter Answer4 here"];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionController = TextEditingController();
    answer1Controller = TextEditingController();
    answer2Controller = TextEditingController();
    answer3Controller = TextEditingController();
    answer4Controller = TextEditingController();
    controllers = [answer1Controller!, answer2Controller!, answer3Controller!, answer4Controller!];
    getlevels(widget.paperId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: view(context),
    );
  }

  view(BuildContext context) {
    widget.paperId;
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
          addQuestionText(),
          CommonWidgets.getSizedBox(height: 15.0),
          addQuestionView(),
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
          CircleAvatar(
            backgroundColor: AppColors.grey,
          )
        ],
      ),
    );
  }

  addQuestionText() {
    return Center(
      child: Text(
        AppStrings.AddQuestionText,
        style: CommonWidgets.getTextStyle(fontSize: 27, textColor: AppColors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  addQuestionView() {
    return Expanded(
        child: Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width,
      decoration: CommonWidgets.getDecoration(boxColor: AppColors.white, boxBorderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            CommonWidgets.getSizedBox(height: 40.0),
            questionTextField(),
            CommonWidgets.getSizedBox(height: 20.0),
            ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: answer1TextFormField(index),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                isChecked = index;
                                correctAnswer = controllers[index].text;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(border: Border.all(color: AppColors.gradientColor, width: 2), borderRadius: BorderRadius.circular(60)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(color: isChecked == index ? Colors.green : Colors.white, borderRadius: BorderRadius.circular(60)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            CommonWidgets.getSizedBox(height: 20.0),
            addLevel(),
            CommonWidgets.getSizedBox(height: 60.0),
            sunmitQuestionButton(),
          ],
        ),
      ),
    ));
  }

  questionTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: CommonWidgets.getTextFormField(
        hintText: AppStrings.EnterQuestionText,
        controller: questionController,
        keyboardAction: TextInputAction.next,
        keyboardType: TextInputType.text,
      ),
    );
  }

  answer1TextFormField(int index) {
    return CommonWidgets.getTextFormField(
      hintText: answerList[index],
      controller: controllers[index],
      keyboardAction: TextInputAction.next,
      keyboardType: TextInputType.text,
    );
  }

  // Submit button for adding questions
  sunmitQuestionButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        validationAndSubmitPaper();
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: CommonWidgets.getDecoration(
          boxBorderRadius: BorderRadius.circular(7),
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.purple, Colors.deepPurpleAccent]),
        ),
        child: isaddQuestionLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                "Submit",
                style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 17, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  addLevel() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
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
                  dropDownvalue ?? "Select Level",
                  style: CommonWidgets.getTextStyle(textColor: AppColors.black),
                )),
            style: TextStyle(color: Colors.white),
            selectedItemBuilder: (BuildContext context) {
              return level.map((value) {
                return Padding(
                  padding: EdgeInsets.only(top: 12.0, left: 0.0),
                  child: Text(
                    value.toString(),
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                );
              }).toList();
            },
            items: level.map((selectedType) {
              return DropdownMenuItem(
                child: Text(
                  "$selectedType",
                  style: TextStyle(color: Colors.black),
                ),
                value: selectedType,
              );
            }).toList(),
            onChanged: (newValue) {
              dropDownvalue = newValue.toString();
              if (mounted) {
                setState(() {});
              }
            },
          ),
        ),
      ),
    );
  }

  // add question function
  addQuestion() async {
    isaddQuestionLoading = true;
    if (mounted) {
      setState(() {});
    }

    var response = await AdminstratorServices.addQuestions(
        level: dropDownvalue,
        paperId: widget.paperId,
        question: questionController!.text,
        answer1: answer1Controller!.text,
        answer2: answer2Controller!.text,
        answer3: answer3Controller!.text,
        answer4: answer4Controller!.text,
        correctAnswer: correctAnswer);
    print("response1");
    if (response != null) {
      try {
        widget.callback();
        isaddQuestionLoading = false;
        if (mounted) {
          setState(() {});
        }
        print("response");
      } catch (e) {
        print(e.toString());
      }

      Navigator.pop(context);
    } else {
      isaddQuestionLoading = false;
      if (mounted) {
        setState(() {});
      }
      CommonWidgets.showSnackBar(context, "Something went wrong.....");
    }
  }

  // validation for the adding question function
  validationAndSubmitPaper() {
    if (questionController!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter the question name");
    } else if (answer1Controller!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter answer 1");
    } else if (answer2Controller!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter answer 2");
    } else if (answer3Controller!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter answer 3");
    } else if (answer4Controller!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter answer 4");
    } else if (dropDownvalue == null) {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please select the level");
    } else if (dropDownvalue == null) {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please select the level");
    } else if (isChecked == null) {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please select one answer");
    } else {
      addQuestion();
    }
  }

  // get levels function
  Future getlevels(String? paperId) async {
    level.clear();
    var response = await AdminstratorServices.getLevels(int.parse(paperId!));
    if (response != null) {
      level = response.levels ?? [];
      if (mounted) {
        setState(() {});
      }
    }
  }
}
