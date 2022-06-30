import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/ApiService/authenticationServices/authenticationService.dart';
import 'package:quiz_app/bindings/homeScreenBinding.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

class AuthenticationController extends GetxController with GetTickerProviderStateMixin {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController loginEmailController;
  late TextEditingController loginPasswordController;
  late FocusNode fname;
  late FocusNode pass;
  late FocusNode email;
  late FocusNode loginEmail;
  late FocusNode loginPass;
  late TabController tabController;
  RxInt selectedTab = 0.obs;
  RxBool isRegistrationLoading = false.obs;
  RxBool isLoginLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    loginPasswordController = TextEditingController();
    loginEmailController = TextEditingController();
    fname = FocusNode();
    pass = FocusNode();
    email = FocusNode();
    loginEmail = FocusNode();
    loginPass = FocusNode();

    tabController = TabController(length: 2, vsync: this, animationDuration: Duration.zero);
    tabController.addListener(() {
      selectedTab.value = tabController.index;
    });
  }

  @override
  void dispose() {
    fname.dispose();

    email.dispose();
    pass.dispose();
    loginEmail.dispose();
    loginPass.dispose();

    super.dispose();
  }
}
