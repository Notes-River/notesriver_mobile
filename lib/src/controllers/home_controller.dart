import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:notesriver_mobile/src/HttpException.dart';
import 'package:notesriver_mobile/src/controllers/api_controller.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  String errorMessage = "";

  //for favScreen
  RxBool isFavLoading = false.obs;
  RxBool isFavError = false.obs;
  String isFavErrorMsg = '';

  AudioPlayer audioPlayer = new AudioPlayer();

  late ApiController _apiController;

  HomeController() {
    _apiController = Get.find<ApiController>();
  }

  loadNotes() async {
    try {
      isLoading.value = true;
      await _apiController.fetchHomeNotes();
      isError.value = false;
      isLoading.value = false;
    } on HttpException catch (e) {
      errorMessage = e.message;
      isError.value = true;
      isLoading.value = false;
    } catch (e) {
      errorMessage = e.toString();
      isError.value = true;
      isLoading.value = false;
    }
  }

  likePost({required int index}) async {
    try {
      await _apiController.likePost(index: index, forLiked: true);
    } on HttpException catch (e) {
      throw HttpException(e.message);
    } catch (e) {
      rethrow;
    }
  }

  dislikePost({required int index}) async {
    try {
      await _apiController.likePost(index: index, forLiked: false);
    } on HttpException catch (e) {
      throw HttpException(e.message);
    } catch (e) {
      rethrow;
    }
  }

  addToFav({required int index}) async {
    try {
      await _apiController.addToFav(index: index);
    } on HttpException catch (e) {
      throw HttpException(e.message);
    } catch (e) {
      rethrow;
    }
  }

  fetchAllFav() async {
    try {
      isFavLoading.value = true;
      await _apiController.fetchAllFavNotes();
      isFavLoading.value = false;
    } on HttpException catch (e) {
      isFavLoading.value = false;
      isFavErrorMsg = e.message;
      isFavError.value = true;
    } catch (e) {
      isFavLoading.value = false;
      isFavErrorMsg = e.toString();
      isFavError.value = true;
    }
  }
}
