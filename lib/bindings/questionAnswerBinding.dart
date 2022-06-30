import 'package:get/get.dart';
import 'package:quiz_app/controllers/questionPaperController.dart';
import 'package:quiz_app/controllers/resultController.dart';

class QuestionAnswerBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => QuestionPaperAnswerController(),fenix: true);
    Get.lazyPut(() => ResultController(), fenix: true);
  }
}
