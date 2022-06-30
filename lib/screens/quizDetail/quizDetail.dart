import 'package:flutter/material.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/screens/home.dart';

import '../../utils/AppColor.dart';
import '../../utils/AppStrings.dart';
import '../../utils/commonWidgets.dart';

class QuizDetail extends StatefulWidget {
  String? userName;

  QuizDetail({this.userName});

  @override
  _QuizDetailState createState() => _QuizDetailState();
}

class _QuizDetailState extends State<QuizDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: view(),
      ),
    );
  }

  view() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: [Colors.purple, Colors.deepPurpleAccent])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidgets.getSizedBox(height: 25.0),
          appBar(),
          CommonWidgets.getSizedBox(height: 40.0),
          explanationText(),
          CommonWidgets.getSizedBox(height: 20.0),
          registrationContainer(context),
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
          Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          Text(
            "Detail of how to use Quiz App",
            style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 19, fontWeight: FontWeight.w600),
          ),
          CircleAvatar(
            backgroundColor: AppColors.grey,
          )
        ],
      ),
    );
  }

  registrationContainer(BuildContext context) {
    return Expanded(
        child: Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width,
      decoration: CommonWidgets.getDecoration(boxColor: AppColors.white, boxBorderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.getSizedBox(height: 20.0),
            Center(
              child: Container(
                height: 4,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: [Colors.blueAccent.shade700, Colors.blueAccent]),
                ),
              ),
            ),
            detailPageConatiner(),
            CommonWidgets.getSizedBox(height: 20.0),
            instructorView(),
            CommonWidgets.getSizedBox(height: 20.0),
            selectQuizButton(context),
            CommonWidgets.getSizedBox(height: 20.0),

            /*  withoutRegistrationText(),*/
          ],
        ),
      ),
    ));
  }

  explanationText() {
    return Center(
      child: Container(
        child: Text(
          AppStrings.ExplainText,
          style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 19, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  detailPageConatiner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      margin: EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "Brief explanation about the working of quiz app",
              style: CommonWidgets.getTextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              softWrap: true,
            ),
          ),
          CommonWidgets.getSizedBox(height: 15.0),
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.black,
                  radius: 22,
                  child: Icon(Icons.book_outlined),
                ),
                CommonWidgets.getSizedBox(width: 15.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("10 Questions", style: CommonWidgets.getTextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    CommonWidgets.getSizedBox(height: 4.0),
                    Text(
                      "1point for a correct answer",
                      style: CommonWidgets.getTextStyle(textColor: AppColors.grey),
                    ),
                  ],
                )
              ],
            ),
          ),
          CommonWidgets.getSizedBox(height: 18.0),
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.black,
                  radius: 22,
                  child: Icon(Icons.book_outlined),
                ),
                CommonWidgets.getSizedBox(width: 15.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("MCQ Test", style: CommonWidgets.getTextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    CommonWidgets.getSizedBox(height: 4.0),
                    Text(
                      "Pick only one Answer of each question",
                      style: CommonWidgets.getTextStyle(textColor: AppColors.grey),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  instructorView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Text(
            "Please read the instruction before starting the quiz\n"
            "so you can understand it how to use app.",
            style: CommonWidgets.getTextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          CommonWidgets.getSizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 3),
                child: CircleAvatar(
                  backgroundColor: AppColors.black,
                  radius: 4,
                ),
              ),
              CommonWidgets.getSizedBox(width: 14.0),
              Expanded(
                child: Text("Each correct answer carry 1 mark awarded and no"
                    "marks for a incorrect answer."),
              )
            ],
          ),
          CommonWidgets.getSizedBox(height: 20.0),
          Row(
            children: [
              Container(
                child: CircleAvatar(
                  backgroundColor: AppColors.black,
                  radius: 4,
                ),
              ),
              CommonWidgets.getSizedBox(width: 14.0),
              Text("Select one option as answer from the given list.")
            ],
          ),
          CommonWidgets.getSizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 3),
                child: CircleAvatar(
                  backgroundColor: AppColors.black,
                  radius: 4,
                ),
              ),
              CommonWidgets.getSizedBox(width: 14.0),
              Expanded(
                child: Text(
                    "If your answer is wrong then you can check the right answer at bottom of the result screen,"
                    "brief description is giving for right answer,It will "
                    "ehance your knowledge.",
                    softWrap: true,
                    maxLines: 3),
              )
            ],
          ),
          CommonWidgets.getSizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 3),
                child: CircleAvatar(
                  backgroundColor: AppColors.black,
                  radius: 4,
                ),
              ),
              CommonWidgets.getSizedBox(width: 14.0),
              Expanded(
                child: Text("After giving the answer of all question please click "
                    "on Submit Quiz button. At the end you can get your "
                    "final score on the screen."),
              )
            ],
          )
        ],
      ),
    );
  }

  selectQuizButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(userName: widget.userName)));
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
        child: Text(
          "Click Here to Select Quiz Option",
          style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
