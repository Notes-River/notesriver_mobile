import 'package:get/get.dart';
import 'package:notesriver_mobile/models/readlist.model.dart';
import 'package:notesriver_mobile/models/user_profile.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageController extends GetxController {
  RxString token = ''.obs;
  RxString username = ''.obs;
  RxString password = ''.obs;
  RxList notes = [].obs;
  RxList readLists = [].obs;
  RxList favNotes = [].obs;
  RxList favNotesIds = [].obs;

  Rx<UserProfile> profile =
      UserProfile(name: '', username: '', email: '', status: false, id: '').obs;

  StorageController() {
    print('Binding Storage colntroller...');
    getStoredPassword();
  }

  Future<bool> storeToken({required String token}) async {
    this.token.value = token;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('appToken', token);
    return true;
  }

  getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final t = preferences.getString('appToken');
    if (t == null) {
      token.value = '';
    } else {
      token.value = t;
    }
  }

  storeUsernamePassword(
      {required String username, required String password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('username', username);
    preferences.setString('password', password);
  }

  getStoredPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final u = preferences.getString('username');
    final p = preferences.getString('password');
    if (u != null) {
      username.value = u;
    }

    if (p != null) {
      password.value = p;
    }
  }

  changeProfileValue({required UserProfile profile}) {
    this.profile.value = profile;
  }

  setReadLists({required List<ReadList> list}) async {
    readLists.value = [];
    readLists.value = list;
  }

  setNotes({required List notes}) {
    this.notes.value = [];
    this.notes.value = notes;
  }

  setFavNotes({required List notes}) {
    favNotes.value = [];
    favNotes.value = notes;
  }

  setFavNotesId({required List ids}) {
    favNotesIds.value = [];
    favNotesIds.value = ids;
  }
}
