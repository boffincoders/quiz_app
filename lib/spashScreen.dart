import 'package:flutter/material.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/screens/home.dart';

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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => prefs!.getString("token") != null ? HomeScreen(userName: prefs!.getString("username")) : Registration()));
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
