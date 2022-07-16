import 'package:get/get.dart';
import 'package:notesriver_mobile/src/HttpException.dart';
import 'package:notesriver_mobile/src/controllers/api_controller.dart';

class ProfileController extends GetxController {
  late ApiController _apiController;
  RxBool profileLoading = false.obs;

  ProfileController() {
    _apiController = Get.find<ApiController>();
  }

  Future<Null> refreshProfile() async {
    try {
      profileLoading.value = true;
      await _apiController.getUserProfile(notes: true);
      profileLoading.value = false;
    } on HttpExceptionWithStatus catch (e) {
      profileLoading.value = false;
    } on HttpException catch (e) {
      profileLoading.value = false;
    } catch (e) {
      profileLoading.value = false;
    }
  }
}
