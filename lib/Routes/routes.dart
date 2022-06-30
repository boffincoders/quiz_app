import 'package:flutter/cupertino.dart';

import 'package:quiz_app/screens/home.dart';

import 'package:quiz_app/spashScreen.dart';

class Routes {
  Routes._();

  static const String splash = "/spalsh";
  static const String home = "/home";
  static const String paper = "/paper";
  static const String question = "/question";
  static const String detailScreen = "/detailScreen";

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    home: (BuildContext context) => HomeScreen(),
  };
}

/*class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    print(settings.name);

    switch (settings.name) {
      case Routes.splash:
        return GeneratePageRoute(widget: SplashScreen(), routeName: settings.name);

      case Routes.home:
        return GeneratePageRoute(widget: HomeScreen(), routeName: settings.name);

      case Routes.question:
        return GeneratePageRoute(widget: QuestionPaper(), routeName: settings.name);

      case Routes.detailScreen:
        return GeneratePageRoute(widget: QuizDetail(), routeName: settings.name);

      default:
        return null;
    }
  }
}*/
