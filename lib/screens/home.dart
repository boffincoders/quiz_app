import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quiz_app/ApiService/ClassServices/classServices.dart';
import 'package:quiz_app/Models/TridbModels/getQuestionPaperModel.dart';
import 'package:quiz_app/bindings/levelBindings.dart';
import 'package:quiz_app/bindings/questionAnswerBinding.dart';
import 'package:quiz_app/controllers/homeController.dart';
import 'package:quiz_app/screens/questions.dart';
import 'package:quiz_app/screens/selectDifficultyLevelScreen.dart';
import 'package:quiz_app/utils/AppColor.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

import '../Models/TridbModels/getCatogryModel.dart';

class HomeScreen extends GetView<HomeController> {
  String? userName;

  HomeScreen({this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: drawer(),
      body: view(context),
    );
  }

  view(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.only(top: 30),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: [Colors.purple, Colors.deepPurpleAccent])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(),
              CommonWidgets.getSizedBox(height: 20.0),
              CommonWidgets.getSizedBox(height: 15.0),
              CommonWidgets.getSizedBox(height: 15.0),
              selectQuizView(context)
            ],
          ),
        ));
  }

  appBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (controller.scaffoldKey.currentState!.isDrawerOpen) {
                controller.scaffoldKey.currentState!.openEndDrawer();
              } else {
                controller.scaffoldKey.currentState!.openDrawer();
              }
              drawer();
            },
            child: Icon(
              Icons.menu,
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

  dropDownButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
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
          offset: const Offset(-2, -3),
          isExpanded: false,
          iconEnabledColor: Colors.white,
          hint: Container(
              margin: EdgeInsets.only(top: 15, left: 30),
              child: Text(
                controller.dropDownValue?.name ?? "Drop DownList of Classes",
                style: CommonWidgets.getTextStyle(textColor: AppColors.black),
              )),
          style: const TextStyle(color: Colors.white),
          selectedItemBuilder: (BuildContext context) {
            return controller.categoryList.map((TriviaCategories value) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 0.0),
                child: Text(
                  controller.dropDownValue?.name ?? "",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              );
            }).toList();
          },
          items: controller.categoryList.map((selectedType) {
            return DropdownMenuItem(
              child: Text(
                selectedType.name ?? "",
                style: const TextStyle(color: Colors.black),
              ),
              value: selectedType,
            );
          }).toList(),
          onChanged: (TriviaCategories? newValue) async {
            controller.dropDownValue = newValue;
            Get.to(() => DifficultyLevelScreen(), arguments: {"dropDownValue": controller.dropDownValue}, binding: LevelBinding());
          },
        ),
      ),
    );
  }

  selectQuizView(BuildContext context) {
    return Expanded(
        child: Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width,
      decoration: CommonWidgets.getDecoration(boxColor: AppColors.white, boxBorderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0))),
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
          CommonWidgets.getSizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Center(
              child: Container(
                child: Text("All Subjects",
                style: CommonWidgets.getTextStyle(
                  fontSize: 25,
                  textColor: AppColors.gradientColor,
                  fontWeight: FontWeight.w600
                ),),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  controller.isLoadingCateogryList.value?Center(child: CircularProgressIndicator(),): ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: controller.categoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: ()async{
                          GetQuestionPaperModel? getQuestionPAperListData= await ClassServices.getQuestionPaper(controller.categoryList[index].id.toString(),controller.level);
                          if(getQuestionPAperListData!=null){

                            if(getQuestionPAperListData.results!.isNotEmpty){
                              Get.to(() => QuestionPaper(),binding: QuestionAnswerBinding(),arguments: {
                                "questionAnswerList":getQuestionPAperListData.results,"level":controller.level,"paperName":controller.categoryList[index].name
                              });

                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(border: Border.all(color: AppColors.textGradientColor), borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              Text("Subject${index+1}"),
                              CommonWidgets.getSizedBox(width: 15),
                              Expanded(child: Text(controller.categoryList[index].name!,
                              softWrap: true,
                                  maxLines: 3,)),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }




  image() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      height: 65,
      width: 80,
      decoration: CommonWidgets.getDecoration(boxColor: AppColors.grey, boxBorderRadius: BorderRadius.circular(5.0)),
    );
  }




  drawer() {
    return Container(
      width: 200,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.gradientColor,
              ),
              child: CircleAvatar(
                backgroundColor: AppColors.grey,
                maxRadius: 50,
              ),
            ),
            ListTile(
              title: Text(
                "Logout",
                style: CommonWidgets.getTextStyle(fontSize: 20),
              ),
              onTap: () {
             return CommonWidgets.showToast("Nothing is here") ;

              },
              trailing: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

}
