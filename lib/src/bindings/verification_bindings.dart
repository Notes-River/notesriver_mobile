import 'package:get/get.dart';
import 'package:notesriver_mobile/src/controllers/verification_controller.dart';

class VerificationBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    print('Binding Verification Controller');
    Get.put(VerificationController());
  }
}
