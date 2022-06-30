import 'package:get/get.dart';
import 'package:quiz_app/controllers/authenticationController/authenticationController.dart';

class AuthenticationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AuthenticationController());
  }

}