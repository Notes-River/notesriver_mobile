import 'package:get/get.dart';
import 'package:notesriver_mobile/models/readlist.model.dart';
import 'package:notesriver_mobile/src/HttpException.dart';
import 'package:notesriver_mobile/src/controllers/api_controller.dart';
import 'package:notesriver_mobile/src/controllers/storage_controller.dart';

class ReadlistUtils extends GetxController {
  late ApiController _apiController;
  late StorageController _storageController;
  RxList readLists = [].obs;
  RxBool isLoading = false.obs;

  ReadlistUtils() {
    _apiController = Get.find<ApiController>();
    _storageController = Get.find<StorageController>();
  }

  loadReadLists() async {
    isLoading.value = true;
    try {
      List<ReadList> readlist = await _apiController.getReadLists();
      readLists.value = readlist;
      isLoading.value = false;
    } on HttpException catch (e) {
      isLoading.value = false;
      throw HttpException(e.message);
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }
}
