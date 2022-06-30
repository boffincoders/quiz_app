import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/authenticationController/authenticationController.dart';
import 'package:quiz_app/utils/AppColor.dart';
import 'package:quiz_app/utils/AppStrings.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

class Registrtaion extends GetView<AuthenticationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: view(context),
    );
  }

  view(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.only(top: 50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: [Colors.purple, Colors.deepPurpleAccent])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.getSizedBox(height: 15.0),
              appBar(),
              CommonWidgets.getSizedBox(height: 15.0),
              welcomeText(),
              CommonWidgets.getSizedBox(height: 15.0),
              quizAppKnoweldegeText(),
              CommonWidgets.getSizedBox(height: 5.0),
              infoContainer(context),
              CommonWidgets.getSizedBox(height: 15.0),
              registrationContainer(context),
            ],
          ),
        ));
  }

  appBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: AppColors.white,
          ),
          CircleAvatar(
            backgroundColor: AppColors.grey,
          )
        ],
      ),
    );
  }

  welcomeText() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          AppStrings.WelcomeText,
          style: CommonWidgets.getTextStyle(textColor: AppColors.white),
        ));
  }

  quizAppKnoweldegeText() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          AppStrings.QuizAppKnowledgeText,
          style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontWeight: FontWeight.w700, fontSize: 21),
        ));
  }

  infoContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: CommonWidgets.getDecoration(boxColor: AppColors.white, boxBorderRadius: BorderRadius.circular(10.0)),
      child: Text(
          "It is an app helping student to test their subjective knowledge and if answer is wrong.It gives the brief "
          "knowledge about the correct answer. It also provide General topic for student",
          softWrap: true),
    );
  }

  registrationContainer(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(top: 20),
      decoration: CommonWidgets.getDecoration(boxColor: AppColors.white, boxBorderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            tabBarView(context),

            /*  withoutRegistrationText(),*/
          ],
        ),
      ),
    ));
  }

  registerText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        AppStrings.RegisterText,
        style: CommonWidgets.getTextStyle(textColor: AppColors.red, fontSize: 22),
      ),
    );
  }

  withoutRegistrationText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Without Registration you can",
            style: CommonWidgets.getTextStyle(textColor: AppColors.black, fontSize: 16),
          ),
          CommonWidgets.getSizedBox(height: 12.0),
          Row(
            children: [
              Text(
                "not participate\t",
                style: CommonWidgets.getTextStyle(textColor: AppColors.black, fontSize: 16),
              ),
              Text(
                "MCQ test",
                style: CommonWidgets.getTextStyle(textColor: Colors.lightBlue, fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }

  studentNameTextformField(context) {
    return CommonWidgets.getTextFormField(
      hintText: AppStrings.StudentNameText,
      controller: controller.nameController,
      focusNode: controller.fname,
      keyboardAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      submitted: (term) {
        controller.fname.unfocus();
        FocusScope.of(context).requestFocus(controller.email);
      },
    );
  }

  studentEmailTextformField(context) {
    return CommonWidgets.getTextFormField(
      hintText: AppStrings.StudentEmailText,
      controller: controller.emailController,
      focusNode: controller.email,
      keyboardAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      submitted: (term) {
        controller.email.unfocus();
        FocusScope.of(context).requestFocus(controller.pass);
      },
    );
  }

  choosePasswordTextFormFiled(context) {
    return CommonWidgets.getPasswordTextFormField(
      hintText: AppStrings.ChoosePassword,
      controller: controller.passwordController,
      focusNode: controller.pass,
      keyboardAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      submitted: (term) {
        controller.pass.unfocus();
      },
    );
  }

  authenticationButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          registerButton(),
          loginButton(),
        ],
      ),
    );
  }

  registerButton() {
    return controller.selectedTab.value == 0
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {},
            child: PhysicalModel(
              elevation: 6,
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(40.0),
              child: CommonWidgets.getGradientButton(
                  isLoading: controller.isRegistrationLoading.value, btnText: "REGISTER", btnTextStyle: CommonWidgets.getTextStyle(fontSize: 15, textColor: AppColors.white)),
            ))
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (controller.selectedTab.value == 1) {
                controller.selectedTab.value = controller.tabController.index - 1;

                controller.tabController.animateTo(controller.selectedTab.value);
              }
            },
            child: CommonWidgets.getButton(btnText: "REGISTER", btnTextStyle: CommonWidgets.getTextStyle(fontSize: 15, textColor: AppColors.black)),
          );
  }

  loginButton() {
    return controller.selectedTab.value == 1
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {},
            child: PhysicalModel(
              elevation: 6,
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(40.0),
              child: CommonWidgets.getGradientButton(
                  isLoading: controller.isLoginLoading.value, btnText: "Login", btnTextStyle: CommonWidgets.getTextStyle(fontSize: 15, textColor: AppColors.white)),
            ))
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (controller.selectedTab.value == 0) {
                controller.selectedTab.value = controller.tabController.index + 1;

                controller.tabController.animateTo(controller.selectedTab.value);
              }
            },
            child: CommonWidgets.getButton(btnText: "Login", btnTextStyle: CommonWidgets.getTextStyle(fontSize: 15, textColor: AppColors.black)),
          );
  }

  tabBarView(context) {
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0),
            child: TabBar(
              unselectedLabelColor: AppColors.grey,
              labelColor: AppColors.textGradientColor,
              tabs: [
                Tab(
                  text: "REGISTER",
                ),
                Tab(
                  text: "LOGIN",
                )
              ],
              controller: controller.tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [registrationPage(context), loginPage(context)],
              controller: controller.tabController,
            ),
          ),
        ],
      ),
    );
  }

  registrationPage(context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidgets.getSizedBox(height: 15.0),
          registerText(),
          CommonWidgets.getSizedBox(height: 4.0),
          withoutRegistrationText(),
          CommonWidgets.getSizedBox(height: 15.0),
          studentNameTextformField(context),
          CommonWidgets.getSizedBox(height: 15.0),
          studentEmailTextformField(context),
          CommonWidgets.getSizedBox(height: 15.0),
          choosePasswordTextFormFiled(context),
          CommonWidgets.getSizedBox(height: 20.0),
          authenticationButtons(),
        ],
      ),
    );
  }

  loginPage(context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.getSizedBox(height: 15.0),
            logintext(),
            CommonWidgets.getSizedBox(height: 4.0),
            bySigningtext(),
            CommonWidgets.getSizedBox(height: 15.0),
            emailTextFormField(context),
            CommonWidgets.getSizedBox(height: 15.0),
            passwordTextFormField(context),
            CommonWidgets.getSizedBox(height: 20.0),
            authenticationButtons()
          ],
        ),
      ),
    );
  }

  logintext() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        AppStrings.LoginText,
        style: CommonWidgets.getTextStyle(textColor: AppColors.red, fontSize: 22),
      ),
    );
  }

  bySigningtext() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "By signing in you can only go for",
            softWrap: true,
            style: CommonWidgets.getTextStyle(textColor: AppColors.black, fontSize: 16),
          ),
          CommonWidgets.getSizedBox(height: 12.0),
          Row(
            children: [
              Text(
                "the\t",
                style: CommonWidgets.getTextStyle(textColor: AppColors.black, fontSize: 16),
              ),
              Text(
                "MCQ test",
                style: CommonWidgets.getTextStyle(textColor: Colors.lightBlue, fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }

  // email TextField
  emailTextFormField(context) {
    return CommonWidgets.getTextFormField(
      hintText: AppStrings.EnterEmailText,
      controller: controller.loginEmailController,
      focusNode: controller.loginEmail,
      keyboardAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      submitted: (term) {
        controller.loginEmail.unfocus();
        FocusScope.of(context).requestFocus(controller.loginPass);
      },
    );
  }

  // password TextField
  passwordTextFormField(context) {
    return CommonWidgets.getPasswordTextFormField(
      hintText: AppStrings.PasswordText,
      controller: controller.loginPasswordController,
      focusNode: controller.loginPass,
      keyboardAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      submitted: (term) {
        controller.loginPass.unfocus();
      },
    );
  }
}
