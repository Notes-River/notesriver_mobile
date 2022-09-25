import 'package:get/get.dart';
import 'package:notesriver_mobile/src/controllers/readlistinfo_controller.dart';

class ReadlistInfoBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ReadlistInfoController());
  }
}