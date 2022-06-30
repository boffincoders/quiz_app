import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quiz_app/ApiService/ClassServices/classServices.dart';
import 'package:quiz_app/ApiService/adminstratorServices/adminstratorServices.dart';
import 'package:quiz_app/Models/adminstratorModels/questionPaperLevelListModel.dart';
import 'package:quiz_app/Models/classModels/classSubjectModel.dart';
import 'package:quiz_app/Models/classModels/classModel.dart';
import 'package:quiz_app/Models/classModels/resultModel.dart';
import 'package:quiz_app/Models/classModels/subjectPaperModel.dart';
import 'package:quiz_app/Models/classModels/subjectQuestionAnswerModel.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/screens/adminstratorScreens/addQuestions.dart';
import 'package:quiz_app/screens/adminstratorScreens/addQuiz.dart';
import 'package:quiz_app/screens/adminstratorScreens/paperList.dart';
import 'package:quiz_app/screens/authentication/registrationAuthentication.dart';
import 'package:quiz_app/screens/questions.dart';
import 'package:rxdart/rxdart.dart';
import '../Models/classModels/overAllResultModel.dart';
import '../utils/AppColor.dart';
import '../utils/commonWidgets.dart';

class HomeScreen extends StatefulWidget {
  String? userName;
  ResultModel? resultModel;
  String? classId;
  SubjectQuestionAnswerModel? subjectQuestionAnswerModel;

  HomeScreen({this.userName, this.resultModel, this.classId, this.subjectQuestionAnswerModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  List<ClassData> classes = [];
  List<SubjectData> subjects = [];
  List<SubjectPaperData> subjectsPaper = [];
  List<OverAllResult>? overAllResult = [];
  ClassData? dropDownvalue;
  bool isLoadingClass = false;
  bool isLoadingQuizCard = false;
  bool isLoadingSubject = false;
  bool isLoadingPaper = false;
  bool isDeletingPaper = false;
  int selectedTab = 0;
  late SlidableController slideAbleController;
  SubjectQuestionAnswerModel? subjectQuestionAnswerModel;
  PaperLevelListModel? paperLevelListModel;
  var passingMarks;
  var resultData;
  int totalLevels = 5;

  final subjectStereamController = BehaviorSubject<List<SubjectPaperData>>();

  Stream<List<SubjectPaperData>> get subjectStream => subjectStereamController.stream;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    prefs!.setString("username", widget.userName == null ? "" : widget.userName!);
    prefs!.setBool("isALreadyLoggedIn", true);
    slideAbleController = SlidableController(this);
    getAllClasses();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: drawer(),
        body: view(context),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  view(BuildContext context) {
    return Container(
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
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                prefs!.getString("role") == "admin" ? "Hi Admin" : "Hi ${widget.userName == null ? "" : widget.userName!}",
                style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 16),
              )),
          CommonWidgets.getSizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                prefs!.getString("role") == "admin" ? "Manage your Quiz Card" : "Check your knowledge of Subject",
                style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 19, fontWeight: FontWeight.w600),
              )),
          CommonWidgets.getSizedBox(height: 15.0),
          dropDownButton(),
          CommonWidgets.getSizedBox(height: 15.0),
          selectQuizView()
        ],
      ),
    );
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
              if (_scaffoldKey.currentState!.isDrawerOpen) {
                _scaffoldKey.currentState!.openEndDrawer();
              } else {
                _scaffoldKey.currentState!.openDrawer();
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

  dropDownButton() {
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
                dropDownvalue?.name ?? "Drop DownList of Classes",
                style: CommonWidgets.getTextStyle(textColor: AppColors.black),
              )),
          style: const TextStyle(color: Colors.white),
          selectedItemBuilder: (BuildContext context) {
            return classes.map((ClassData value) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 0.0),
                child: Text(
                  dropDownvalue?.name ?? "",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              );
            }).toList();
          },
          items: classes.map((selectedType) {
            return DropdownMenuItem(
              child: Text(
                selectedType.name ?? "",
                style: const TextStyle(color: Colors.black),
              ),
              value: selectedType,
            );
          }).toList(),
          onChanged: (ClassData? newValue) async {
            dropDownvalue = newValue;
            if (mounted) setState(() {});
            await getAllSubject(dropDownvalue!.id);
          },
        ),
      ),
    );
  }

  selectQuizView() {
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
            subjects.length > 0
                ? tabBarView()
                : Center(
                    child: Text(
                      "No Subjects",
                      style: CommonWidgets.getTextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                  ),
            prefs!.getString('role') == "admin"
                ? dropDownvalue == null
                    ? const SizedBox.shrink()
                    : addQuizButton()
                : const SizedBox.shrink()
          ],
        ),
      ),
    ));
  }

  tabBarView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .6,
      child: subjects.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TabBar(
                    isScrollable: true,
                    indicatorPadding: EdgeInsets.only(left: 15.0, right: 15.0),
                    unselectedLabelColor: AppColors.grey,
                    labelColor: AppColors.textGradientColor,
                    tabs: tabMaker(),
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: List<Widget>.generate(subjects.length, (int index) {
                      return subjectData(selectedTab);
                    }),
                    controller: _tabController,
                  ),
                ),
              ],
            )
          : Visibility(visible: isLoadingClass, child: Center(child: CircularProgressIndicator())),
    );
  }

  subjectData(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            subjectsPaper.isNotEmpty
                ? isDeletingPaper
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: subjectsPaper.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: prefs!.getString('role') == "admin"
                                ? () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PaperList(subjectsPaper[index].id!, () {
                                                  getSubjectPaper(subjects[selectedTab].id);
                                                })));
                                  }
                                : () async {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return QuestionPaper(
                                        () {
                                          getSubjectPaper(subjects[selectedTab].id);
                                        },
                                        classId: dropDownvalue!.id,
                                        subjectId: subjects[selectedTab].id,
                                        paperId: subjectsPaper[index].id,
                                        passingMarks: int.parse(subjectsPaper[index].passMarks!),
                                        subjectName1: subjectsPaper[index].paperName!,
                                      );
                                    }));
                                    // }
                                  },
                            child: prefs!.getString('role') == "admin"
                                ? Slidable(
                                    endActionPane: ActionPane(
                                      extentRatio: 0.25,
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (BuildContext context) async {
                                            await deletePaper(subjectsPaper[index].id);
                                          },
                                          backgroundColor: AppColors.gradientColor,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
                                          height: 100,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      subjectsPaper[index].questions! >= int.parse(subjectsPaper[index].passMarks!) ? AppColors.textGradientColor : AppColors.red,
                                                  width: 1.5),
                                              borderRadius: BorderRadius.circular(7.0)),
                                          child: Row(
                                            children: [
                                              image(),
                                              CommonWidgets.getSizedBox(width: 13),
                                              Container(
                                                margin: const EdgeInsets.only(top: 20),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        subjectsPaper.length > 0 ? subjectsPaper[index].paperName! : "",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: CommonWidgets.getTextStyle(
                                                            textColor: subjectsPaper[index].questions! >= int.parse(subjectsPaper[index].passMarks!)
                                                                ? AppColors.textGradientColor
                                                                : AppColors.red,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600),
                                                        softWrap: true,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.book_outlined,
                                                          color: AppColors.grey,
                                                          size: 15,
                                                        ),
                                                        CommonWidgets.getSizedBox(width: 8),
                                                        Text(
                                                          "Level ${subjectsPaper[index].level!}",
                                                          style: CommonWidgets.getTextStyle(textColor: AppColors.grey, fontSize: 15),
                                                        ),
                                                        CommonWidgets.getSizedBox(width: 8),
                                                        Text(
                                                          " ${subjectsPaper[index].questions!} Questions",
                                                          style: CommonWidgets.getTextStyle(textColor: AppColors.grey, fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        prefs!.getString('role') == "admin"
                                            ? GestureDetector(
                                                behavior: HitTestBehavior.deferToChild,
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => AddQuestionsScrren(subjectsPaper[index].id, () {
                                                                print(subjectsPaper.length);

                                                                getSubjectPaper(subjects[selectedTab].id);
                                                              })));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      child: Icon(
                                                    Icons.add,
                                                    color:
                                                        subjectsPaper[index].questions! >= int.parse(subjectsPaper[index].passMarks!) ? AppColors.textGradientColor : AppColors.red,
                                                  )),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                        subjectsPaper[index].questions! <= int.parse(subjectsPaper[index].passMarks!)
                                            ? int.parse(subjectsPaper[index].passMarks!) == (subjectsPaper[index].questions!)
                                                ? const SizedBox.shrink()
                                                : Positioned(
                                                    bottom: 30,
                                                    right: 20,
                                                    child: Text(
                                                      "Pending Question ${int.parse(subjectsPaper[index].passMarks!) - (subjectsPaper[index].questions!)}",
                                                      style: CommonWidgets.getTextStyle(
                                                          textColor: int.parse(subjectsPaper[index].passMarks!) == (subjectsPaper[index].questions!)
                                                              ? AppColors.textGradientColor
                                                              : AppColors.red),
                                                    ),
                                                  )
                                            : const SizedBox.shrink()
                                      ],
                                    ))
                                : Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(bottom: 15, left: 5, right: 4),
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(border: Border.all(color: AppColors.textGradientColor, width: 2), borderRadius: BorderRadius.circular(7.0)),
                                    child: Row(
                                      children: [
                                        image(),
                                        CommonWidgets.getSizedBox(width: 13),
                                        Container(
                                          margin: const EdgeInsets.only(top: 20),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  subjectsPaper.isNotEmpty ? subjectsPaper[index].paperName! : "",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: CommonWidgets.getTextStyle(textColor: AppColors.textGradientColor, fontSize: 16, fontWeight: FontWeight.w600),
                                                  softWrap: true,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.book_outlined,
                                                    color: AppColors.grey,
                                                    size: 15,
                                                  ),
                                                  CommonWidgets.getSizedBox(width: 8),
                                                  Text(
                                                    "Level ${subjectsPaper.length > 0 ? int.parse(subjectsPaper[index].level!) > subjectsPaper[index].totalLevels! ? "${int.parse(subjectsPaper[index].level.toString()) - 1}" : subjectsPaper[index].level! : SizedBox()}",
                                                    style: CommonWidgets.getTextStyle(textColor: AppColors.grey, fontSize: 16),
                                                  ),
                                                  CommonWidgets.getSizedBox(width: 8),
                                                  Text(
                                                    " ${subjectsPaper.isNotEmpty ? int.parse(subjectsPaper[index].level!) > subjectsPaper[index].totalLevels! ? "Completed" : subjectsPaper[index].questions! : SizedBox()} ${subjectsPaper.length > 0 ? int.parse(subjectsPaper[index].level!) > subjectsPaper[index].totalLevels! ? "" : "Questions" : SizedBox()}",
                                                    style: CommonWidgets.getTextStyle(textColor: AppColors.grey, fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          );
                        })
                : Visibility(visible: isLoadingPaper, child: const Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }

  image() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      height: 65,
      width: 80,
      decoration: CommonWidgets.getDecoration(boxColor: AppColors.grey, boxBorderRadius: BorderRadius.circular(5.0)),
    );
  }

  addQuizButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        isLoadingQuizCard = true;
        if (mounted) {
          setState(() {});
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddQuizScreen(dropDownvalue, subjects[selectedTab], () {
                      getSubjectPaper(subjects[selectedTab].id);
                    }, selectedTab)));

        isLoadingQuizCard = false;
        if (mounted) {
          setState(() {});
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: CommonWidgets.getDecoration(
          boxBorderRadius: BorderRadius.circular(7),
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.purple, Colors.deepPurpleAccent]),
        ),
        child: Text(
          "Add Quiz",
          style: CommonWidgets.getTextStyle(textColor: AppColors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  //get all classes fuction
  Future getAllClasses() async {
    isLoadingClass = true;
    setState(() {});
    var response = (await ClassServices.getClasses());
    if (response != null) {
      classes = response.data ?? [];
      isLoadingClass = false;
      setState(() {});
    }
  }

  // get all subject function
  Future getAllSubject(String? id) async {
    isLoadingSubject = true;
    setState(() {});
    var response = await ClassServices.getAllSubjects(id!);
    if (response != null) {
      subjects = response.data ?? [];
      isLoadingSubject = false;
      setState(() {});
      tabMaker();
      _tabController = TabController(length: subjects.length, vsync: this, animationDuration: Duration.zero);
      if (subjects.isNotEmpty) {
        await getSubjectPaper(subjects[0].id);
      }
      _tabController.addListener(() {
        if (mounted) {
          setState(() {
            selectedTab = _tabController.index;
            subjects[selectedTab];
            getSubjectPaper(subjects[selectedTab].id);
          });
        }
      });
    }
  }

  // dynamic tab maker function
  tabMaker() {
    List<Tab> tabs = [];
    for (var i = 0; i < subjects.length; i++) {
      tabs.add(Tab(
        text: subjects[i].subjectName,
      ));
    }
    ;
    return tabs;
  }

  Future getSubjectPaper(String? id) async {
    subjectsPaper.clear();
    isLoadingPaper = true;
    if (mounted) {
      setState(() {});
    }
    var response = await ClassServices.getSubjectPaper(id!);
    if (response != null) {
      if (mounted) {
        setState(() {
          isLoadingPaper = false;
        });
      }
      subjectsPaper = response.data ?? [];
      subjectStereamController.sink.add(subjectsPaper);
    }
  }

  // get subject wise Question paper function
  Future<SubjectQuestionAnswerModel?> getSubjectQuestionPaper(String? id) async {
    SubjectQuestionAnswerModel? response = await ClassServices.getSubjectPaperQuestionAnswer(id!);
    if (response != null) {
      subjectQuestionAnswerModel = response;
      totalLevels = subjectQuestionAnswerModel!.totalLevels!;
      setState(() {});
    }
    return subjectQuestionAnswerModel;
  }

  // delete paper function
  deletePaper(String? paperId) async {
    subjectsPaper.clear();
    isDeletingPaper = true;
    if (mounted) {
      setState(() {});
    }

    int paperid = int.parse(paperId!);
    var response = await AdminstratorServices.deletePaper(paperId: paperid);
    if (response != null) {
      isDeletingPaper = false;
      if (mounted) {
        setState(() {});
      }
      await getSubjectPaper(subjects[selectedTab].id);
    }
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
                prefs!.remove("role");
                prefs!.remove("token");
                prefs!.remove("isALreadyLoggedIn");

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => Registration()), ModalRoute.withName('/'));
              },
              trailing: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  // get over all result function
  Future<List<OverAllResult>?> getOverAllResult(String? paperId) async {
    overAllResult!.clear();
    var response = await ClassServices.getOverAllResult(paperId!);
    if (response != null) {
      overAllResult = response.results ?? [];
      setState(() {});
    }
    return overAllResult;
  }
}
