import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/ApiService/authenticationServices/authenticationService.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/screens/quizDetail/quizDetail.dart';
import 'package:quiz_app/utils/AppColor.dart';
import 'package:quiz_app/utils/AppStrings.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> with TickerProviderStateMixin {
  late TabController _tabController;
  bool isRegistrationLoading = false;
  bool isLoginLoading = false;
  int selectedTab = 0;
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? loginEmailController;
  TextEditingController? loginPasswordController;
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  FocusNode? fname;
  FocusNode? pass;
  FocusNode? email;
  FocusNode? loginEmail;
  FocusNode? loginPass;

  String msg = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, animationDuration: Duration.zero);
    _tabController.addListener(() {
      if (mounted) {
        setState(() {
          selectedTab = _tabController.index;
        });
      }
    });
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    loginEmailController = TextEditingController(
    );
    loginPasswordController = TextEditingController();
    fname = FocusNode();

    email = FocusNode();
    pass = FocusNode();
    loginEmail = FocusNode();
    loginPass = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    fname!.dispose();

    email!.dispose();
    pass!.dispose();
    loginEmail!.dispose();
    loginPass!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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

  studentNameTextformField() {
    return CommonWidgets.getTextFormField(
      hintText: AppStrings.StudentNameText,
      controller: nameController,
      focusNode: fname,
      keyboardAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      submitted: (term) {
        fname!.unfocus();
        FocusScope.of(context).requestFocus(email);
      },
/*      validator: (value) {
        if (nameController!.text == null || nameController!.text.isEmpty) {
          CommonWidgets.showToast(
              toastGravity: ToastGravity.TOP,
              toast: Toast.LENGTH_SHORT,
              msg: "Please enter name "
          );
        }
        return null;
      },*/
    );
  }

  studentEmailTextformField() {
    return CommonWidgets.getTextFormField(
      hintText: AppStrings.StudentEmailText,
      controller: emailController,
      focusNode: email,
      keyboardAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      submitted: (term) {
        email!.unfocus();
        FocusScope.of(context).requestFocus(pass);
      },
    );
  }

  choosePasswordTextFormFiled() {
    return CommonWidgets.getPasswordTextFormField(
      hintText: AppStrings.ChoosePassword,
      controller: passwordController,
      focusNode: pass,
      keyboardAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      submitted: (term) {
        pass!.unfocus();
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
    return selectedTab == 0
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              validationAndSumitRegisterData();
            },
            child: PhysicalModel(
              elevation: 6,
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(40.0),
              child: CommonWidgets.getGradientButton(
                  isLoading: isRegistrationLoading, btnText: "REGISTER", btnTextStyle: CommonWidgets.getTextStyle(fontSize: 15, textColor: AppColors.white)),
            ))
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (selectedTab == 1) {
                if (mounted)
                  setState(() {
                    selectedTab = _tabController.index - 1;
                  });

                _tabController.animateTo(selectedTab);
              }
            },
            child: CommonWidgets.getButton(btnText: "REGISTER", btnTextStyle: CommonWidgets.getTextStyle(fontSize: 15, textColor: AppColors.black)),
          );
  }

  loginButton() {
    return selectedTab == 1
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              validationAndSumitloginData();
            },
            child: PhysicalModel(
              elevation: 6,
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(40.0),
              child:
                  CommonWidgets.getGradientButton(isLoading: isLoginLoading, btnText: "Login", btnTextStyle: CommonWidgets.getTextStyle(fontSize: 15, textColor: AppColors.white)),
            ))
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (selectedTab == 0) {
                if (mounted) {
                  setState(() {
                    selectedTab = _tabController.index + 1;
                  });
                }
                _tabController.animateTo(selectedTab);
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
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [registrationPage(), loginPage()],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }

  registrationPage() {
    return SingleChildScrollView(
      child: Form(
        key: registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.getSizedBox(height: 15.0),
            registerText(),
            CommonWidgets.getSizedBox(height: 4.0),
            withoutRegistrationText(),
            CommonWidgets.getSizedBox(height: 15.0),
            studentNameTextformField(),
            CommonWidgets.getSizedBox(height: 15.0),
            studentEmailTextformField(),
            CommonWidgets.getSizedBox(height: 15.0),
            choosePasswordTextFormFiled(),
            CommonWidgets.getSizedBox(height: 20.0),
            authenticationButtons(),
          ],
        ),
      ),
    );
  }

  loginPage() {
    return Container(
      child: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.getSizedBox(height: 15.0),
              logintext(),
              CommonWidgets.getSizedBox(height: 4.0),
              bySigningtext(),
              CommonWidgets.getSizedBox(height: 15.0),
              emailTextFormField(),
              CommonWidgets.getSizedBox(height: 15.0),
              passwordTextFormField(),
              CommonWidgets.getSizedBox(height: 20.0),
              authenticationButtons()
            ],
          ),
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
  emailTextFormField() {
    return CommonWidgets.getTextFormField(
      hintText: AppStrings.EnterEmailText,
      controller: loginEmailController,
      focusNode: loginEmail,
      keyboardAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      submitted: (term) {
        loginEmail!.unfocus();
        FocusScope.of(context).requestFocus(loginPass);
      },
    );
  }

  // password TextField
  passwordTextFormField() {
    return CommonWidgets.getPasswordTextFormField(
      hintText: AppStrings.PasswordText,
      controller: loginPasswordController,
      focusNode: loginPass,
      keyboardAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      submitted: (term) {
        loginPass!.unfocus();
      },
    );
  }

  // validation for the register function
  validationAndSumitRegisterData() {
    if (nameController!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter the name");
    } else if (emailController!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter the email");
    } else if (CommonWidgets.validateEmail(emailController!.text) == false) {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter valid email");
    } else if (passwordController!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter the password");
    } else if (CommonWidgets.validatePassword(passwordController!.text) == false) {
      return CommonWidgets.showToast(
          toastGravity: ToastGravity.TOP,
          toast: Toast.LENGTH_SHORT,
          msg: "Eight characters including one uppercase letter, one lowercase letter, and one number or special character");
    } else {
      signUp();
    }
  }

  // validation for the login function
  validationAndSumitloginData() {
    if (loginEmailController!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please Enter the Email");
    } else if (CommonWidgets.validateEmail(loginEmailController!.text) == false) {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter valid email");

    } else if (loginPasswordController!.text == "") {
      return CommonWidgets.showToast(toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT, msg: "Please enter the password");
    } else if (CommonWidgets.validatePassword(loginPasswordController!.text) == false) {
      return CommonWidgets.showToast(
          toastGravity: ToastGravity.TOP,
          toast: Toast.LENGTH_SHORT,
          msg: "Eight characters including one uppercase letter, one lowercase letter, and one number or special character");
    }
    signIn();
  }

  // register function
  signUp() async {
    isRegistrationLoading = true;
    if (mounted) {
      setState(() {});
    }
    var data = await AuthenticationServices.signup(
      email: emailController!.text,
      name: nameController!.text,
      password: passwordController!.text,
    );
    if (data != null) {
      if (data.data != null) {
        isRegistrationLoading = false;
        if (mounted) {
          setState(() {});
        }
        nameController!.clear();
        emailController!.clear();
        passwordController!.clear();
        CommonWidgets.showSnackBar(context, " Succesfully registered......");

        if (selectedTab == 0) {
          if (mounted) {
            setState(() {
              selectedTab = _tabController.index + 1;
            });
          }
          _tabController.animateTo(selectedTab);
        }
      } else {
        CommonWidgets.showSnackBar(context, "Something went wrong please try again!");
        isLoginLoading = false;
        if (mounted) {
          setState(() {});
        }
      }
    } else {
      isRegistrationLoading = false;
      CommonWidgets.showSnackBar(context, "Something went wrong please try again!");

      if (mounted) {
        setState(() {});
      }
    }
  }

  //log in function
  signIn() async {
    isLoginLoading = true;
    if (mounted) {
      setState(() {});
    }
    try {
      var data = await AuthenticationServices.login(
        email: loginEmailController!.text,
        password: loginPasswordController!.text,
      );

      if (data != null) {
        var loginData = data.data;
        if (loginData != null) {
          isLoginLoading = false;
          loginEmailController!.clear();
          loginPasswordController!.clear();

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => prefs!.getString("role") == "admin"
                      ? HomeScreen()
                      : prefs!.getBool("isALreadyLoggedIn") == true
                          ? HomeScreen(userName: loginData.name!)
                          : QuizDetail(
                              userName: loginData.name!,
                            )));

          CommonWidgets.showSnackBar(context, " Succesfully logged in......");
        } else {
          isLoginLoading = false;
          if (mounted) {
            setState(() {});
          }
        }
      } else {
        isLoginLoading = false;
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      isLoginLoading = false;
      if (mounted) {
        setState(() {});
      }
      print(e.toString());
    }
  }
}
