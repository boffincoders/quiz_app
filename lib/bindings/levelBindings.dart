import 'package:get/get.dart';
import 'package:quiz_app/controllers/levelControllers.dart';

class LevelBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LevelControllers());
  }
}