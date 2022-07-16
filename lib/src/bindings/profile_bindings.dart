import 'package:get/get.dart';
import 'package:notesriver_mobile/src/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ProfileController());
  }
}
