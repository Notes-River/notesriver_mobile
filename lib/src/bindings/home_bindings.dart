import 'package:get/get.dart';
import 'package:notesriver_mobile/src/controllers/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HomeController());
  }
}
