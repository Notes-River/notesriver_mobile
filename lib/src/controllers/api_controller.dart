import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:notesriver_mobile/models/notes.models.dart';
import 'package:notesriver_mobile/models/readlist.model.dart';
import 'package:notesriver_mobile/models/user_profile.model.dart';
import 'package:notesriver_mobile/src/HttpException.dart';
import 'package:notesriver_mobile/src/config.dart';
import 'package:notesriver_mobile/src/controllers/storage_controller.dart';
import 'package:http/http.dart' as http;
import 'package:notesriver_mobile/src/controllers/ui_widget_controller.dart';

class ApiController extends GetxController {
  late StorageController _storageController;
  late UIWidgetController _uiWidgetController;
  ApiController() {
    print('Binding Api controller...');
    _storageController = Get.find<StorageController>();
    _uiWidgetController = Get.find<UIWidgetController>();
  }

  checkUsernameAndEmail({required String uername}) async {
    try {
      http.Response response = await http.get(
          Uri.parse(Config.serverAdress + '/auth/check-username/' + uername));
      if (response.statusCode == 404) {
        throw HttpException('NOT_FOUND');
      } else if (response.statusCode == 200) {
        throw HttpException('FOUND');
      } else {
        throw HttpException('ERROR');
      }
    } catch (e) {
      rethrow;
    }
  }

  loginUser({
    required String username,
    required String password,
    required Function cb,
  }) async {
    try {
      http.Response response = await http
          .post(Uri.parse(Config.serverAdress + '/auth/login-user'), body: {
        "username": username,
        "password": password,
      });
      if (response.statusCode != 200) {
        throw HttpException(json.decode(response.body)['message']);
      } else {
        UserProfile userProfile = UserProfile.fromJSON(
          json.decode(response.body)['user'],
        );
        if (userProfile.status != true) {
          cb(true);
          otpBasedVerificationRequest();
        }
        final String token = json.decode(response.body)['token'];
        await _storageController.storeToken(token: token);
        await _storageController.changeProfileValue(profile: userProfile);
      }
    } catch (e) {
      rethrow;
    }
  }

  registerUser({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(Config.serverAdress + '/auth/register-user'),
        body: {
          "name": name,
          "username": username,
          "password": password,
          "email": email,
        },
      );
      if (response.statusCode != 201)
        throw HttpException(json.decode(response.body)['msg']);
      else {
        try {
          await loginUser(
            username: username,
            password: password,
            cb: (value) {
              print('Verification status: ' + value.toString());
            },
          );
        } on HttpException catch (e) {
          throw HttpException(e.message);
        } catch (e) {
          rethrow;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  otpBasedVerificationRequest() async {
    try {
      http.Response response = await http.post(
        Uri.parse(Config.serverAdress + '/auth/request-ac-verification'),
        headers: {
          "x-user": _storageController.token.value,
        },
      );
      if (response.statusCode != 200)
        throw HttpException(json.decode(response.body)['message']);
      else {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  verificationWithOtp({required otp}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(Config.serverAdress + '/auth/verify-email/' + otp),
        headers: {
          "x-user": _storageController.token.value,
        },
      );

      if (response.statusCode != 200)
        throw HttpException(json.decode(response.body)['message']);
      else {
        _storageController.profile.value.status = true;
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  getUserProfile({required bool notes}) async {
    try {
      String url = Config.serverAdress + '/auth/user-profile?notes=no';
      if (notes == true) {
        url = Config.serverAdress + '/auth/user-profile?notes=yes';
      }
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {"x-user": _storageController.token.value},
      );
      print(_storageController.token.value);
      if (response.statusCode == 404) {
        throw HttpExceptionWithStatus(
          message: 'Token Expired Login again.',
          status: 'TKN_EXPIRE',
          apiStatus: true,
        );
      } else if (response.statusCode == 200) {
        UserProfile profile =
            UserProfile.fromJSON(json.decode(response.body)['user']);
        _storageController.changeProfileValue(profile: profile);
        if (profile.status == false) otpBasedVerificationRequest();
      } else {
        throw HttpException(json.decode(response.body)['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  logoutUser() async {
    try {
      _uiWidgetController.setLogoutProgress(value: true);
      http.Response response = await http.delete(
          Uri.parse(Config.serverAdress + '/auth/logout-user'),
          headers: {"x-user": _storageController.token.value});

      if (response.statusCode != 200) {
        _uiWidgetController.setLogoutProgress(value: false);
        throw HttpException(json.decode(response.body)['message']);
      } else {
        _storageController.storeToken(token: '');
        _storageController.changeProfileValue(
          profile: UserProfile(
            id: '',
            name: '',
            username: '',
            email: '',
            status: false,
          ),
        );
        _uiWidgetController.setLogoutProgress(value: false);
      }
    } catch (e) {
      _uiWidgetController.setLogoutProgress(value: false);
      rethrow;
    }
  }

  Future<List<ReadList>> getReadLists() async {
    try {
      http.Response response = await http.get(
        Uri.parse(Config.serverAdress + '/notes/read-list/auth/user'),
        headers: {
          "x-user": _storageController.token.value,
        },
      );
      if (response.statusCode != 200) throw HttpException(response.body);
      List<ReadList> readlist = [];
      json.decode(response.body)['readlist'].forEach((e) {
        ReadList readList = ReadList.fromJSON(e);
        readlist.add(readList);
      });
      if (readlist.isNotEmpty) {
        await _storageController.setReadLists(list: readlist);
      }
      return readlist;
    } catch (e) {
      rethrow;
    }
  }

  createReadList({
    required String title,
    required String about,
    List? tags,
    String? path,
  }) async {
    try {
      final url = Uri.parse(Config.serverAdress + '/notes/read-list/create');
      http.MultipartRequest request = http.MultipartRequest("POST", url);
      request.fields['title'] = title;
      request.fields['about'] = about;
      if (tags != null) {
        request.fields['tags'] = jsonEncode(tags);
      }
      if (path != null) {
        request.files.add(
          http.MultipartFile.fromBytes('logo', File(path).readAsBytesSync(),
              filename: path.split('/').last),
        );
      }
      request.headers['x-user'] = _storageController.token.value;
      http.StreamedResponse response = await request.send();
      if (response.statusCode != 201)
        throw HttpException(await response.stream.bytesToString());
      await getReadLists();
    } catch (e) {
      rethrow;
    }
  }

  createPost({
    required String title,
    required String about,
    required List? tags,
    required List files,
    required String id,
  }) async {
    try {
      final url = Uri.parse(Config.serverAdress + '/notes/create');
      http.MultipartRequest request = http.MultipartRequest('POST', url);
      request.headers['x-user'] = _storageController.token.value;
      request.fields['title'] = title;
      request.fields['desc'] = about;
      request.fields['id'] = id;
      request.fields['tags'] = jsonEncode(tags);
      List<http.MultipartFile> newList = [];
      for (var e in files) {
        print(e);
        http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
          'notes',
          File(e).readAsBytesSync(),
          filename: e.split('/').last,
        );

        newList.add(multipartFile);
      }

      request.files.addAll(newList);

      http.StreamedResponse response = await request.send();

      if (response.statusCode != 200) throw HttpException('Uploading error');
    } catch (e) {
      rethrow;
    }
  }

  fetchHomeNotes() async {
    try {
      http.Response response = await http
          .get(Uri.parse(Config.serverAdress + '/notes/related'), headers: {
        "x-user": _storageController.token.value,
      });

      if (response.statusCode != 200) {
        throw HttpException(json.decode(response.body)["message"]);
      }

      List<NotesModel> notes = [];

      final data = json.decode(response.body);

      if (data.length > 0) {
        data.forEach((e) {
          NotesModel notesModel = NotesModel.fromJSON(e);
          print(notesModel.id);
          notes.add(notesModel);
        });
      }

      _storageController.setNotes(notes: notes);
    } catch (e) {
      rethrow;
    }
  }

  likePost({required int index, required bool forLiked}) async {
    try {
      NotesModel notesModel = _storageController.notes.value[index];
      final url = Uri.parse(
          Config.serverAdress + '/notes/' + (forLiked ? 'like' : 'dislike'));

      http.Response response = await http.post(url, body: {
        "notesid": notesModel.id,
      }, headers: {
        "x-user": _storageController.token.value,
      });

      if (response.statusCode != 200) {
        throw HttpException(json.decode(response.body)['message']);
      }
      List<String> likedBy = List.from(json.decode(response.body)['likedBy']);
      List<String> dislikedBy =
          List.from(json.decode(response.body)['dislikedBy']);

      notesModel.likedBy = likedBy;
      notesModel.dislikedBy = dislikedBy;

      _storageController.notes.value[index] = notesModel;
      await _storageController.setNotes(
        notes: _storageController.notes.value,
      );
    } catch (e) {
      rethrow;
    }
  }

  addToFav({required int index}) async {
    try {
      NotesModel notesModel = _storageController.notes.value[index];
      http.Response response =
          await http.post(Uri.parse(Config.serverAdress + '/notes/fav'), body: {
        "notesid": notesModel.id,
      }, headers: {
        "x-user": _storageController.token.value,
      });

      if (response.statusCode != 200) {
        throw HttpException(json.decode(response.body)['message']);
      }

      List<NotesModel> notes = [];
      List<String> ids = [];
      final data = json.decode(response.body);

      if (data.length > 0) {
        data.forEach((e) {
          NotesModel notesModel = NotesModel.fromJSON(e);
          ids.add(notesModel.id);
          notes.add(notesModel);
        });
      }

      _storageController.setFavNotesId(ids: ids);
      _storageController.setFavNotes(notes: notes);
    } catch (e) {
      rethrow;
    }
  }

  fetchAllFavNotes() async {
    try {
      http.Response response = await http
          .get(Uri.parse(Config.serverAdress + '/notes/fav'), headers: {
        "x-user": _storageController.token.value,
      });

      if (response.statusCode != 200) {
        throw HttpException(json.decode(response.body)['message']);
      }

      List<NotesModel> notes = [];

      if (json.decode(response.body)['notes'].length > 0) {
        json.decode(response.body)['notes'].forEach((e) {
          NotesModel notesModel = NotesModel.fromJSON(e);
          notes.add(notesModel);
        });
      }

      _storageController.setFavNotes(notes: notes);
    } catch (e) {
      rethrow;
    }
  }
}
