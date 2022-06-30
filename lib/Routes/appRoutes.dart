enum AppRoutes { Registration, Home, QuizDetail, Question, AddQuestion, AddQuiz, PaperList, Result, OverAllResult,
  Splash,LevelScreen }

extension RouteExtension on AppRoutes {
  String get name {
    switch (this) {
      case AppRoutes.Splash:
        return '/splash';
      case AppRoutes.Registration:
        return '/registration';
      case AppRoutes.Home:
        return '/home';
      case AppRoutes.QuizDetail:
        return '/quizDetail';
      case AppRoutes.Question:
        return '/question';
      case AppRoutes.AddQuestion:
        return '/addQuestion';
      case AppRoutes.AddQuiz:
        return '/addQuiz';
      case AppRoutes.PaperList:
        return '/paperList';
      case AppRoutes.Result:
        return '/result';
      case AppRoutes.OverAllResult:
        return '/overAllResult';
        case AppRoutes.LevelScreen:
        return '/level';

      default:
        return '/';
    }
  }
}
