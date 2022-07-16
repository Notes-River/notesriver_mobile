import 'package:get/get.dart';
import 'package:notesriver_mobile/src/controllers/registration_controller.dart';

class RegistrationBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    print('Binding Registration Controller');
    Get.put(RegistrationController());
  }
}
