import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Routes/appRoutes.dart';
import 'package:quiz_app/bindings/authenticationBindings/authenticationBinding.dart';
import 'package:quiz_app/dbHelper/dpHelper.dart';
import 'package:quiz_app/pages.dart';

final quizAppDb = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: appPages,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.Splash.name,
      initialBinding: AuthenticationBinding(),
    );
  }
}
