import 'package:get/get.dart';
import 'package:notesriver_mobile/src/controllers/api_controller.dart';
import 'package:notesriver_mobile/src/controllers/storage_controller.dart';
import 'package:notesriver_mobile/src/controllers/ui_widget_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(UIWidgetController());
    Get.put(StorageController());
    Get.put(ApiController());
  }
}
