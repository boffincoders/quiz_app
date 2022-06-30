import 'package:get/get.dart';
import 'package:quiz_app/controllers/homeController.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeController(),fenix: true);
  }
}
