import 'package:get/get.dart';
import 'package:notesriver_mobile/src/controllers/notes_create_controller.dart';

class NotesCreateBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NotesCreateController());
  }
}
