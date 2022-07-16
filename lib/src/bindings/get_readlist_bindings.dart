import 'package:get/get.dart';
import 'package:notesriver_mobile/src/controllers/get_readlist_controller.dart';

class ReadlistUtilsBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ReadlistUtils());
  }
}
