import 'package:get/get.dart';
import 'package:quiz_app/Models/TridbModels/getCatogryModel.dart';
import 'package:quiz_app/main.dart';

class LevelControllers extends GetxController {
  late TriviaCategories dropDownValue;
  RxString level = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllData();

  }

   getAllData()async {
     List<Map<String, dynamic>> dbData = await quizAppDb.getAllBlogs();
     print(dbData);
   }
}
