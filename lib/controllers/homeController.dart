import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiz_app/ApiService/ClassServices/classServices.dart';
import 'package:quiz_app/Models/TridbModels/getCatogryModel.dart';
import 'package:rxdart/rxdart.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  //========================> Tridb variables Decalaration <====================//
  RxList<TriviaCategories> categoryList = <TriviaCategories>[].obs;
  RxBool isLoadingCateogryList = false.obs;
  var level;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    level = data["level"];
    getCategory();
  }

  getDailogBox() {
    return Get.defaultDialog(title: 'Are you sure?', middleText: 'Do you want to exit an App', content: getContent());
  }

  Widget getContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            print("no");
            Get.back();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
          child: const Text('Yes'),
        )
      ],
    );
  }

  //========================> Tridb Controller =======================//

  //======================> variables <======================//
  TriviaCategories? dropDownValue;

  Future getCategory() async {
    categoryList.clear();
    isLoadingCateogryList.value = true;
    var response = await ClassServices.getCategory();
    if (response != null) {
      isLoadingCateogryList.value = false;
      categoryList.value = response.triviaCategories ?? [];
    }
  }
}
