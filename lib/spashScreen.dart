import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quiz_app/bindings/authenticationBindings/authenticationBinding.dart';
import 'package:quiz_app/bindings/homeScreenBinding.dart';
import 'package:quiz_app/bindings/levelBindings.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/screens/selectDifficultyLevelScreen.dart';

import 'screens/authentication/registrationAuthentication.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 5), () {
      // Get.offAll(()=>HomeScreen(), binding: HomeScreenBinding());
      Get.offAll(()=>DifficultyLevelScreen(), binding: LevelBinding());
     /* prefs!.getString("token") != null
          ? Get.offAll(()=>HomeScreen(userName: prefs!.getString("username")), binding: HomeScreenBinding())
          : Get.offAll(()=>Registrtaion(), binding: AuthenticationBinding());*/
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: SizedBox(
            height: 130,
            child: Image.network("https://play-lh.googleusercontent.com/WkK8-_NYDo0f15qfGsZnn4iZ9G7Q-MMloycE5mdnClbUNnkQ50hZrkWi5xxubg5_F8E"),
          )),
        ],
      ),
    );
  }
}
