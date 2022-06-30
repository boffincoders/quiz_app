import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/ApiService/adminstratorServices/adminstratorServices.dart';
import 'package:quiz_app/Models/classModels/classModel.dart';
import 'package:quiz_app/Models/classModels/classSubjectModel.dart';
import 'package:quiz_app/utils/AppStrings.dart';

import '../../utils/AppColor.dart';

import '../../utils/commonWidgets.dart';

class AddQuizScreen extends StatefulWidget {
  ClassData? className;
  SubjectData? subjectName;
  VoidCallback callback;
  int? selectedTab;

  AddQuizScreen(this.className, this.subjectName, this.callback, this.selectedTab);

  @override
  _AddQuizScreenState createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  TextEditingController? addPaperController;
  TextEditingController? passingMarksController;
  TextEditingController? addLevelController;
  bool isAddPaperLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addPaperController = TextEditingController();
    passingMarksController = TextEditingController();
    addLevelController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: view(context),
    );
  }

  view(BuildContext context) {
    widget.selectedTab;
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
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Welcome to Administrator",
                style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 16),
              )),
          CommonWidgets.getSizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Add Quizes into the Quiz Database",
                style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 19, fontWeight: FontWeight.w600),
              )),
          CommonWidgets.getSizedBox(height: 15.0),
          CommonWidgets.getSizedBox(height: 15.0),
          addQuizView()
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
            onTap: (){
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

  addQuizView() {
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
            CommonWidgets.getSizedBox(height: 10.0),
            addQuiz(),
            CommonWidgets.getSizedBox(height: 15.0),
            addQuizCard(),
            CommonWidgets.getSizedBox(height: 15.0),
            selectClassView(),
            CommonWidgets.getSizedBox(height: 15.0),
            selectSubjectView(),
            CommonWidgets.getSizedBox(height: 15.0),
            nameQuizFieldView(),
            CommonWidgets.getSizedBox(height: 15.0),
            passingMarksFieldView(),
            CommonWidgets.getSizedBox(height: 15.0),
            addLevelFieldView(),
            CommonWidgets.getSizedBox(height: 70.0),
            saveAndResetbutton(),
          ],
        ),
      ),
    ));
  }

  addQuiz() {
    return Container(
      decoration: CommonWidgets.getDecoration(boxBorder: Border(bottom: BorderSide(color: AppColors.textGradientColor))),
      padding: EdgeInsets.all(4.0),
      child: Text(
        AppStrings.AddQuizText,
        style: CommonWidgets.getTextStyle(fontSize: 22, textColor: AppColors.textGradientColor),
      ),
    );
  }

  addQuizCard() {
    return RichText(
      softWrap: true,
      textAlign: TextAlign.start,
      text: TextSpan(text: "Form to add Quiz Card", style: TextStyle(color: AppColors.red, fontSize: 25, fontWeight: FontWeight.w600), children: <TextSpan>[
        TextSpan(
          text: "\nCreate",
          style: TextStyle(color: AppColors.black, fontSize: 16),
        ),
        TextSpan(
          text: " MCQ Test",
          style: TextStyle(color: AppColors.accentBlueColor, fontSize: 16),
        ),
        TextSpan(
          text: " cards for students",
          style: TextStyle(color: AppColors.black, fontSize: 16),
        ),
        TextSpan(
          text: "\n\nof particular classes & subjects",
          style: TextStyle(color: AppColors.black, fontSize: 16),
        )
      ]),
    );
  }

  selectClassView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(15, 16, 15, 16),
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
      child: Text(
        widget.className!.name!,
        softWrap: true,
        style: CommonWidgets.getTextStyle(fontSize: 16),
      ),
    );
  }

  selectSubjectView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(15, 16, 15, 16),
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
      child: Text(
        widget.subjectName!.subjectName!,
        softWrap: true,
        style: CommonWidgets.getTextStyle(fontSize: 16),
      ),
    );
  }

  nameQuizFieldView() {
    return CommonWidgets.getTextFormField(hintText: "Name of Quiz Card", keyboardType: TextInputType.text, keyboardAction: TextInputAction.done, controller: addPaperController);
  }

  saveAndResetbutton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          saveButton(),
          cancelButton(),
        ],
      ),
    );
  }

  // sav button for adding quiz in the database
  saveButton() {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          validationAndSubmitQuiz();
        },
        child: PhysicalModel(
          elevation: 6,
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(40.0),
          child: CommonWidgets.getGradientButton(isLoading: isAddPaperLoading, btnText: "SAVE", btnTextStyle: CommonWidgets.getTextStyle(fontSize: 15, textColor: AppColors.white)),
        ));
  }

  cancelButton() {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          Navigator.pop(context);
        },
        child: PhysicalModel(
            elevation: 6,
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(40.0),
            child: CommonWidgets.getButton(btnTextStyle: CommonWidgets.getTextStyle(fontSize: 15, textColor: AppColors.black), btnText: "CANCEL")));
  }

  passingMarksFieldView() {
    return CommonWidgets.getTextFormField(
        hintText: AppStrings.PassingMarksText, keyboardType: TextInputType.number, keyboardAction: TextInputAction.next, controller: passingMarksController);
  }

  // add quiz function
  addPaper(String? level) async {
    isAddPaperLoading = true;
    if (mounted) {
      setState(() {});
    }
    var response = await AdminstratorServices.addPaper(
        classId: widget.className!.id, subjectId: widget.subjectName!.id, paperName: addPaperController!.text, passingMarks: int.parse(passingMarksController!.text), level: level);
    if (response != null) {
      isAddPaperLoading = false;
      if (mounted) {
        setState(() {});
        Navigator.pop(context);
        widget.callback();
      }
    }
  }

  // validation for adding Quiz function
  validationAndSubmitQuiz() {
    if (addPaperController!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter the Paper name");
    } else if (passingMarksController!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter the passing marks");
    } else if (addLevelController!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter level");
    } else {
      addPaper(addLevelController!.text);
    }
  }

  addLevelFieldView() {
    return CommonWidgets.getTextFormField(
        hintText: AppStrings.AddLevelText, keyboardType: TextInputType.number, keyboardAction: TextInputAction.done, controller: addLevelController);
  }
}
