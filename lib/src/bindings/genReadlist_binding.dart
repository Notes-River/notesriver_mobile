import 'package:get/get.dart';
import 'package:notesriver_mobile/src/controllers/readlist_controller.dart';

class CreateReadListBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ReadListController());
  }
}
