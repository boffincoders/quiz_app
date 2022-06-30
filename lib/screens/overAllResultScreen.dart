import 'package:flutter/material.dart';
import 'package:quiz_app/Models/classModels/overAllResultModel.dart';
import 'package:quiz_app/utils/AppColor.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

class OverAllResultScreen extends StatefulWidget {
  List<OverAllResult>? data;
  VoidCallback voidCallback;

  OverAllResultScreen(
    this.voidCallback, {
    this.data,
  });

  @override
  State<OverAllResultScreen> createState() => _OverAllResultScreenState();
}

class _OverAllResultScreenState extends State<OverAllResultScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
          appBar(),
          CommonWidgets.getSizedBox(height: 8.0),
          Center(
            child: Text("OverAll Result", style: CommonWidgets.getTextStyle(fontSize: 30, textColor: AppColors.white)),
          ),
          CommonWidgets.getSizedBox(height: 8.0),
          overAllResultView(context),

          // questionPaperView(context),
        ],
      ),
    );
  }

  appBar() {
    return SizedBox(
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

  overAllResultView(BuildContext context) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: CommonWidgets.getDecoration(boxColor: AppColors.white, boxBorderRadius: const BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0))),
      child: SingleChildScrollView(
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
            const SizedBox(
              height: 20,
            ),
            resultCard(),
          ],
        ),
      ),
    ));
  }

  resultCard() {
    return Container(
      margin:const  EdgeInsets.symmetric(horizontal: 40.0),
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(10, 40, 10, 40),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 6,
              blurRadius: 7,
              offset: const Offset(0, -1), // change position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(40)),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: widget.data!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Level ${widget.data![index].level}",
                    softWrap: true,
                    style: CommonWidgets.getTextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Column(
                    children: [
                      Text(
                        "Correct ",
                        softWrap: true,
                        style: CommonWidgets.getTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${widget.data![index].correctAnswers}",
                        style: CommonWidgets.getTextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Incorrect ",
                        softWrap: true,
                        style: CommonWidgets.getTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${widget.data![index].incorrectAnswers}",
                        style: CommonWidgets.getTextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
