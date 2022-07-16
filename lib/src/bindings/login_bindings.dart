import 'package:get/get.dart';
import 'package:notesriver_mobile/src/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    print('Binding Login Controller');
    Get.put(LoginController());
  }
}
