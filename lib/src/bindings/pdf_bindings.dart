import 'package:get/get.dart';
import 'package:notesriver_mobile/src/controllers/pdf_controller.dart';

class PdfBinder extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(PdfController());
  }
}
