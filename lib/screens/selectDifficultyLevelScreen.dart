
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quiz_app/bindings/homeScreenBinding.dart';
import 'package:quiz_app/controllers/levelControllers.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/utils/AppColor.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

class DifficultyLevelScreen extends GetView<LevelControllers>{
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
          CommonWidgets.getSizedBox(height: 25.0),
          appBar(context),
          levelView(context),
        ],
      ),
    );
  }

  appBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 50,
      child: ListTile(

        title: Center(
            child: Text(
              "Choose Level",
              style: CommonWidgets.getTextStyle(fontSize: 20, textColor: AppColors.white,fontWeight: FontWeight.w600),
            )),

      ),
    );
  }

  levelView(BuildContext context) {
    return Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: CommonWidgets.getDecoration(boxColor: AppColors.white, boxBorderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0))),
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
              const SizedBox(height: 5),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text("Select Dificulty Level", style: CommonWidgets.getTextStyle(fontSize: 20, textColor: AppColors.grey,fontWeight: FontWeight.w600))),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: ()async{
                                controller.level.value="easy";
                                Get.off(()=>HomeScreen(),binding: HomeScreenBinding(),arguments: {"level": controller.level.value});

                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.gradientColor,
                                    maxRadius: 40,
                                    child: Center(child: Image.asset("assets/point.png",width: 60,)),
                                  ),
                                  CommonWidgets.getSizedBox(height: 8),
                                  Text("Easy",style: CommonWidgets.getTextStyle(fontSize: 22, textColor: Colors.grey.shade700,fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: ()async{

                                controller.level.value="medium";
                                Get.off(()=>HomeScreen(),binding: HomeScreenBinding(),arguments: {"level": controller.level.value});


                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    maxRadius: 40,
                                    child:Center(child: Image.asset("assets/speedometer.png",width: 80,height: 80,)),
                                  ),
                                  CommonWidgets.getSizedBox(height: 8),
                                  Text("Medium",style: CommonWidgets.getTextStyle(fontSize: 22, textColor: Colors.grey.shade700,fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: ()async{
                                controller.level.value="hard";
                                Get.off(()=>HomeScreen(),binding: HomeScreenBinding(),arguments: {"level": controller.level.value});

                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    maxRadius: 40,
                                    child:Center(child: Image.asset("assets/next-level.png",width: 80,height: 80,)),

                                  ),
                                  CommonWidgets.getSizedBox(height: 8),
                                  Text("Hard",style: CommonWidgets.getTextStyle(fontSize: 22, textColor: Colors.grey.shade700,fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )


                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }

}


