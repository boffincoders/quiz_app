import 'package:get/get.dart';

import 'package:quiz_app/controllers/resultController.dart';

class ResultBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(() => ResultController(),permanent: true);
  }
}